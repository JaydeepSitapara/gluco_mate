import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;


  SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.dm), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10.dm,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          //primary: Colors.transparent, // Make the button's background transparent to show the gradient
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.dm), // Rounded corners
          ),

        ),
        child:  Text(
          'Save',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white, // Text color remains white
          ),
        ),
      ),
    );
  }
}
