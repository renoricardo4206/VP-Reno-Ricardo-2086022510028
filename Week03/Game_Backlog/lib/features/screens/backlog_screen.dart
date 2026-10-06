import 'package:flutter/material.dart';

import '../models/game.dart';
import '../widgets/backlog_summary.dart';
import '../widgets/game_card.dart';
import '../widgets/game_search_bar.dart';
import '../widgets/status_filter_chips.dart';

class BacklogScreen extends StatefulWidget {
  const BacklogScreen({super.key});

  @override
  State<BacklogScreen> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  final List<Game> _games = [
    const Game(id: 1, title: 'Elden Ring', platform: 'PC', status: GameStatus.playing),
    const Game(id: 2, title: 'Hades', platform: 'Switch', status: GameStatus.finished),
    const Game(id: 3, title: 'Cyberpunk 2077', platform: 'PC', status: GameStatus.backlog),
    const Game(id: 4, title: 'Hollow Knight', platform: 'PC', status: GameStatus.dropped),
    const Game(id: 5, title: 'Genshin Impact', platform: 'Mobile', status: GameStatus.playing),
  ];

  GameStatus? _selectedStatus; // null = semua
  String _query = '';

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

  @override
  Widget build(BuildContext context) {
    final games = _visibleGames;
    return Scaffold(
      appBar: AppBar(title: const Text('Game Backlog')),
      body: Column(
        children: [
          BacklogSummary(games: _games),
          GameSearchBar(onChanged: (q) => setState(() => _query = q)),
          StatusFilterChips(
            selected: _selectedStatus,
            onSelected: (s) => setState(() => _selectedStatus = s),
          ),
          Expanded(
            child: games.isEmpty
                ? const Center(child: Text('Tidak ada game'))
                : ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return GameCard(
                        key: ValueKey(game.id),
                        game: game,
                        onStatusChanged: (s) => _changeStatus(game.id, s),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}