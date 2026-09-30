import 'package:flutter/material.dart';

import '../models/game.dart';

class BacklogSummary extends StatelessWidget {
  const BacklogSummary({super.key, required this.games});

  final List<Game> games;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final s in GameStatus.values)
            Column(
              children: [
                Text(
                  '${games.where((g) => g.status == s).length}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(s.label),
              ],
            ),
        ],
      ),
    );
  }
}
