import 'package:flutter/material.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.trailing,
    this.title,
    this.onTap,
    this.tileColor,
  });

  final Widget? trailing;
  final String? title;
  final Function()? onTap;
  final Color? tileColor;

  build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:8.0.w, vertical: 4.0.h),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        tileColor: tileColor,
        trailing: trailing ?? const SizedBox(),
        horizontalTitleGap: 0,
        onTap: onTap,
        title: Text(
          title ?? '',
          style: largeTextStyle,
        ),
      ),
    );
  }
}
