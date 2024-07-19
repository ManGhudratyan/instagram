import 'package:flutter/material.dart';

class IntOnString extends StatelessWidget {
  const IntOnString({
    super.key,
    required this.count,
    required this.text,
  });
  final int count;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ],
    );
  }
}
