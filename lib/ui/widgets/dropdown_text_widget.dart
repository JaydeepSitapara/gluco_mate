import 'package:flutter/material.dart';
import 'package:gluco_mate/ui/theme/style.dart';

class DropdownTextWidget extends StatelessWidget {
  const DropdownTextWidget({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: titleTextStyle,
    );
  }
}
