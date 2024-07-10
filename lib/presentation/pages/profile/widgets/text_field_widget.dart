import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
        ),
        SizedBox(height: Gaps.small)
      ],
    );
  }
}
