import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/ui/theme/style.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final int? maxLines;

  CommonTextFormField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.labelText = '',
    this.obscureText = false,
    this.keyboardType = TextInputType.number,
    this.maxLines  = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: montserratStyle(
        fontSize: 16.sp, // Normal font size
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      maxLines: maxLines,

      decoration: InputDecoration(
        labelStyle: montserratStyle(
          fontSize: 14.sp, // Normal hint text size
          color: Colors.grey,
        ),
        label:  Text('$labelText'),
        hintText: hintText, // Default hint text
        hintStyle: montserratStyle(
          fontSize: 14.sp, // Normal hint text size
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // Rounded corners
          borderSide: BorderSide(
            color: Colors.black12, // Border color
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // Rounded corners when focused
          borderSide: BorderSide(
            color: Colors.blueGrey, // Highlighted border color
            width: 2.w, // Thicker border on focus
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // Rounded corners for enabled state
          borderSide: BorderSide(
            color: Colors.black12, // Border color when enabled
            width: 1.w, // Standard border width
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 16.w,
        ), // Inner padding for better spacing
      ),
    );
  }
}
