import 'package:flutter/material.dart';
import '../../../core/widgets/price_tag.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Warung Digital')),
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            PriceTag(amount: 20000000),
            PriceTag(amount: 30000000),
            PriceTag(amount: 60000000),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}