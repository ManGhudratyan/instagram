import 'package:flutter/material.dart';


class TextFormField extends StatelessWidget {
  const TextFormField(
      {super.key, this.controller, this.obscureText, this.title});
  final TextEditingController? controller;
  final bool? obscureText;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: title,
          ),
        ),
      ],
    );
  }
}
