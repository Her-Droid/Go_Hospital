import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactComplaintCard extends StatelessWidget {
  final String icon;
  final String content;
  final Function onTap;

  ContactComplaintCard({
    this.icon,
    this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 1.sw / 2 - 28.r,
        height: 45.r,
        padding: EdgeInsets.symmetric(
          horizontal: 14.r,
          vertical: 6.r,
        ),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFCCCCCC),
              blurRadius: 20,
              offset: Offset(0, 0),
              spreadRadius: -5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              icon,
              width: 14.r,
              height: 14.r,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              content,
              style: regularBaseFont.copyWith(
                fontSize: 11.5.sp,
                color: lightGreyColor,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}