import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  CommonTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 45, // Bigger font for numbers
            fontWeight: FontWeight.bold,
            color: Colors.black38
          ),
          decoration: InputDecoration(
            hintText: hintText ?? '0.0', // Default hint value as 0.0
            hintStyle: const TextStyle(
              fontSize: 45, // Bigger hint text size
              color: Colors.black26,
            ),
            border: InputBorder.none, // No default border
          ),
        ),
        Container(
          height: 4, // Thicker underline
          width: 120, // Wider underline
          color: Colors.black12, // Underline color
        ),
      ],
    );
  }
}
