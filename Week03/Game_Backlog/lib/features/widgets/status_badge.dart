import 'package:flutter/material.dart';

import '../models/game.dart';

Color _statusColor(GameStatus status, ColorScheme scheme) => switch (status) {
      GameStatus.playing => scheme.primary,
      GameStatus.finished => scheme.tertiary,
      GameStatus.dropped => scheme.error,
      GameStatus.backlog => scheme.onSurfaceVariant,
    };


class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final GameStatus status;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(status, Theme.of(context).colorScheme);
    return Chip(
      label: Text(status.label),
      labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: color,
          ),
      backgroundColor: color.withValues(alpha: 0.15),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
    );
  }
}