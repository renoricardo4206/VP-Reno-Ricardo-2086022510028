import 'package:flutter/material.dart';

import '../models/game.dart';

/// Readability: ringkasan jumlah per status.
/// Pendukung, bukan fokus: memakai onSurfaceVariant (lebih redup).
/// Tiap kolom dibungkus Expanded supaya lebarnya dibagi rata dan tidak overflow.
class BacklogSummary extends StatelessWidget {
  const BacklogSummary({super.key, required this.games});

  final List<Game> games;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          for (final s in GameStatus.values)
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${games.where((g) => g.status == s).length}',
                    style: textTheme.titleLarge?.copyWith(color: muted),
                  ),
                  Text(
                    s.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textTheme.labelMedium?.copyWith(color: muted),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}