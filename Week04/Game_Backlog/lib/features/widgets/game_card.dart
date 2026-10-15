import 'package:flutter/material.dart';

import '../models/game.dart';
import 'status_badge.dart';

/// Reuse: satu instance per item list. Stateless, melapor lewat callback.
/// Judul game adalah elemen paling penting di layar. Teks yang bisa panjang
/// dibatasi maxLines + overflow supaya tidak merusak layout.
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
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colors.onSurface,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              StatusBadge(status: game.status),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  game.platform,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
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