import 'package:flutter/material.dart';

import '../models/game.dart';

/// Warna status diambil dari ColorScheme, bukan nilai tetap,
/// supaya ikut berubah mengikuti tema.
Color _statusColor(GameStatus status, ColorScheme scheme) => switch (status) {
      GameStatus.playing => scheme.primary,
      GameStatus.finished => scheme.tertiary,
      GameStatus.dropped => scheme.error,
      GameStatus.backlog => scheme.onSurfaceVariant,
    };

/// Reuse: dipakai di setiap GameCard.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final GameStatus status;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(status, Theme.of(context).colorScheme);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(status.label, style: TextStyle(color: color)),
    );
  }
}