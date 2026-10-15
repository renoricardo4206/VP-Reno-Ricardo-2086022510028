import 'package:flutter/material.dart';

import '../models/game.dart';

/// Readability: memisahkan UI filter dari build() screen.
/// Memakai Wrap supaya chip turun ke baris berikutnya di layar sempit,
/// bukan overflow ke samping.
class StatusFilterChips extends StatelessWidget {
  const StatusFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final GameStatus? selected;
  final ValueChanged<GameStatus?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: selected == null,
            onSelected: (_) => onSelected(null),
          ),
          for (final s in GameStatus.values)
            ChoiceChip(
              label: Text(s.label),
              selected: selected == s,
              onSelected: (_) => onSelected(s),
            ),
        ],
      ),
    );
  }
}