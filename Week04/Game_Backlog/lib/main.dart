import 'package:flutter/material.dart';

import 'features/screens/backlog_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Backlog',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF4F46E5), // indigo-violet
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const BacklogScreen(),
    );
  }
}