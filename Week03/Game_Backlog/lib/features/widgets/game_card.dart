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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(game.title),
        subtitle: Text(game.platform),
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
