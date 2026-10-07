import 'package:flutter/material.dart';

class GameSearchBar extends StatelessWidget {
  const GameSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchBar(
        hintText: 'Cari game...',
        leading: const Icon(Icons.search),
        elevation: const WidgetStatePropertyAll<double>(0),
        onChanged: onChanged,
      ),
    );
  }
}