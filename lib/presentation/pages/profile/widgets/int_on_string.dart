import 'package:flutter/material.dart';

class IntOnString extends StatelessWidget {
  const IntOnString({
    super.key,
    required this.count,
    required this.text,
  });
  final String count;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
