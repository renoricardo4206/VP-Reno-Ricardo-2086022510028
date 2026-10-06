import 'package:flutter/material.dart';

import '../models/game.dart';
import 'status_badge.dart';


class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.game,
    required this.onStatusChanged,
  });

  final Game game;
  final ValueChanged<GameStatus> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          game.title,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colors.onSurface,
          ),
        ),
        subtitle: Text(
          game.platform,
          style: textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
        ),
        leading: StatusBadge(status: game.status),
        trailing: PopupMenuButton<GameStatus>(
          onSelected: onStatusChanged,
          itemBuilder: (context) => [
            for (final s in GameStatus.values)
              PopupMenuItem(value: s, child: Text(s.label)),
          ],
        ),
      ),
    );
  }
}