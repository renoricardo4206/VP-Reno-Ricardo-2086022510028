import 'package:flutter/material.dart';

class GameSearchBar extends StatelessWidget {
  const GameSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Cari game...',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
