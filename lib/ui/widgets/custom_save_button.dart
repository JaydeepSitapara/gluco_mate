import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/ui/theme/style.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonText;

  SaveButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          backgroundColor: Colors.blueAccent, // Background color corrected
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r), // Fixed border radius
          ),
        ),
        child: Text(
          buttonText ?? '',
          style: montserratStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white, // Text color remains white
          ),
        ),
      ),
    );
  }
}
