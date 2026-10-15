import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/game.dart';
import '../widgets/backlog_summary.dart';
import '../widgets/game_card.dart';
import '../widgets/game_empty_state.dart';
import '../widgets/game_search_bar.dart';
import '../widgets/status_filter_chips.dart';

// State di-hoist di sini: daftar game, filter status, kata kunci pencarian,
// dan controller kolom pencarian.
class BacklogScreen extends StatefulWidget {
  const BacklogScreen({super.key, this.initialGames});

  /// Opsional, dipakai tes. Kalau null, data dipilih lewat --dart-define=SCENARIO.
  final List<Game>? initialGames;

  @override
  State<BacklogScreen> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  /// Lebar (dp) mulai layout dua panel.
  static const double _wideBreakpoint = 600;

  late final List<Game> _games;
  final TextEditingController _searchController = TextEditingController();
  GameStatus? _selectedStatus; // null = semua
  String _query = '';

  @override
  void initState() {
    super.initState();
    _games = [...(widget.initialGames ?? gamesForScenario(kScenario))];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Game> get _visibleGames => _games.where((g) {
        final matchStatus = _selectedStatus == null || g.status == _selectedStatus;
        final matchQuery = g.title.toLowerCase().contains(_query.toLowerCase());
        return matchStatus && matchQuery;
      }).toList();

  void _changeStatus(int id, GameStatus status) {
    setState(() {
      final i = _games.indexWhere((g) => g.id == id);
      _games[i] = _games[i].copyWith(status: status);
    });
  }

  void _resetFilters() {
    _searchController.clear();
    setState(() {
      _selectedStatus = null;
      _query = '';
    });
  }

  void _loadSample() {
    setState(() {
      _games
        ..clear()
        ..addAll(kDefaultGames);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Backlog')),
      // SafeArea: tidak ada yang bisa diketuk di bawah gesture bar atau notch.
      body: SafeArea(
        top: false, // bagian atas sudah ditangani AppBar
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= _wideBreakpoint;
            return isWide ? _buildWide() : _buildNarrow();
          },
        ),
      ),
    );
  }

  /// Ringkasan, pencarian, dan filter. Dipakai di kedua layout.
  Widget _controls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BacklogSummary(games: _games),
        GameSearchBar(
          controller: _searchController,
          onChanged: (q) => setState(() => _query = q),
        ),
        StatusFilterChips(
          selected: _selectedStatus,
          onSelected: (s) => setState(() => _selectedStatus = s),
        ),
      ],
    );
  }

  Widget _emptyState() {
    final noGames = _games.isEmpty;
    return GameEmptyState(
      key: const Key('empty-state'),
      message: noGames ? 'Belum ada game di backlog' : 'Tidak ada game yang cocok',
      actionLabel: noGames ? 'Muat data contoh' : 'Reset filter',
      onAction: noGames ? _loadSample : _resetFilters,
    );
  }

  Widget _card(Game game) {
    return GameCard(
      key: ValueKey(game.id),
      game: game,
      onStatusChanged: (s) => _changeStatus(game.id, s),
    );
  }

  /// Layar sempit (< 600 dp): satu kolom. Seluruh isi menggulir bersama,
  /// jadi aman di layar pendek dan saat keyboard terbuka.
  Widget _buildNarrow() {
    final games = _visibleGames;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _controls()),
        if (games.isEmpty)
          SliverFillRemaining(hasScrollBody: false, child: _emptyState())
        else
          SliverList.builder(
            itemCount: games.length,
            itemBuilder: (context, index) => _card(games[index]),
          ),
      ],
    );
  }

  /// Layar lebar (>= 600 dp): panel kontrol di kiri, daftar di kanan.
  Widget _buildWide() {
    final games = _visibleGames;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 340,
          child: SingleChildScrollView(child: _controls()),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: games.isEmpty
              ? _emptyState()
              : ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (context, index) => _card(games[index]),
                ),
        ),
      ],
    );
  }
}