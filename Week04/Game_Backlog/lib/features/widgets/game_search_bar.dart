import 'package:flutter/material.dart';

/// Readability: input teks, hanya melapor query ke atas.
/// Controller dimiliki screen supaya teks bisa dikosongkan saat filter di-reset.
class GameSearchBar extends StatelessWidget {
  const GameSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchBar(
        key: const Key('search-field'),
        controller: controller,
        hintText: 'Cari game...',
        leading: const Icon(Icons.search),
        elevation: const WidgetStatePropertyAll<double>(0),
        onChanged: onChanged,
      ),
    );
  }
}