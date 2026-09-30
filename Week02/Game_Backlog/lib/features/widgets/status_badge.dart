import 'package:flutter/material.dart';

import '../models/game.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final GameStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(status.label, style: TextStyle(color: status.color)),
    );
  }
}
