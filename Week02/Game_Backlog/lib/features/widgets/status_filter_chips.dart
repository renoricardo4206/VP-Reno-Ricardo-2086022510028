import 'package:flutter/material.dart';

import '../models/game.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: selected == null,
            onSelected: (_) => onSelected(null),
          ),
          for (final s in GameStatus.values) ...[
            const SizedBox(width: 8),
            ChoiceChip(
              label: Text(s.label),
              selected: selected == s,
              onSelected: (_) => onSelected(s),
            ),
          ],
        ],
      ),
    );
  }
}
