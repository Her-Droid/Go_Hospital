import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalInfoCard extends StatelessWidget {
  final String placeName;
  final String address;
  final String regularSchedule;
  final String weekendSchedule;
  final String image;

  HospitalInfoCard({
    this.placeName,
    this.address,
    this.regularSchedule,
    this.weekendSchedule,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultWidth(context),
      margin: EdgeInsets.only(
        bottom: 16.r, 
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.r,
        vertical: 12.r,
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
        children: [
          Image.asset(
            image,
            width: 60.r,
            height: 60.r,
          ),
          Container(
            width: 1.3.r,
            height: 65.r,
            margin: EdgeInsets.symmetric(
              horizontal: 16.r,
            ),
            decoration: BoxDecoration(
              color: lightGreyColor.withOpacity(0.5),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                placeName,
                style: semiBoldBaseFont.copyWith(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                address,
                style: regularBaseFont.copyWith(
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                regularSchedule,
                style: regularBaseFont.copyWith(
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                weekendSchedule,
                style: regularBaseFont.copyWith(
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}