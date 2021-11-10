import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorScheduleInfo extends StatelessWidget {
  final String day;
  final String time;
  final String place;

  DoctorScheduleInfo({
    this.day,
    this.time,
    this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: semiBoldBaseFont.copyWith(
                fontSize: 14.sp,
                color: darkGreyColor,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              time,
              style: mediumBaseFont.copyWith(
                fontSize: 11.sp,
                color: accentColor,
              ),
            ),
          ],
        ),
        Text(
          place,
          style: regularBaseFont.copyWith(
            fontSize: 13.sp,
            color: greyColor,
          ),
        ),
      ],
    );
  }
}