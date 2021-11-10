import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreMenuCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Icon icon;
  final Function onTap;

  MoreMenuCard({
    this.title,
    this.iconPath,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 1.sw,
        height: 50.r,
        margin: EdgeInsets.only(
          bottom: 16.r,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 18.r,
          vertical: 12.r,
        ),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFCCCCCC),
              blurRadius: 12,
              offset: Offset(0, 0),
              spreadRadius: -5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon != null ? icon : Image.asset(
              iconPath,
              width: 24.r,
              height: 24.r,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 18.w,
            ),
            Text(
              title,
              style: mediumBaseFont.copyWith(
                fontSize: 13.sp,
                color: darkGreyColor,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}