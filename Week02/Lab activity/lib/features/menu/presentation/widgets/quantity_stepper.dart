import 'package:flutter/material.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int qty;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: qty == 0 ? null : onDecrement,
          icon: Icon(Icons.remove_circle_outline),
        ),
        SizedBox(
          width: 28,
          child: Text(
            '$qty',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(
          onPressed: qty >= 99 ? null : onIncrement,
          icon: Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}