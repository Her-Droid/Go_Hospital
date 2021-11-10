import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/hospital_contact.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsCard extends StatelessWidget {
  final HospitalContact hospitalContact;

  AboutUsCard(this.hospitalContact);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultWidth(context),
      margin: EdgeInsets.only(
        bottom: 16.r,
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
          Padding(
            padding: EdgeInsets.only(
              left: 8.r,
              right: 8.r,
              bottom: 14.r,
            ),
            child: Column(
              children: [
                Image.asset(
                  hospitalContact.iconPath,
                  width: 100.r,
                  height: 100.r,
                  fit: BoxFit.cover,
                ),
                Text(
                  hospitalContact.title,
                  style: boldBaseFont.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1.3.r,
            height: 110.r,
            margin: EdgeInsets.only(
              right: 2.r,
            ),
            decoration: BoxDecoration(
              color: lightGreyColor.withOpacity(0.5),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 14.r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospitalContact.firstContact[0],
                  textAlign: TextAlign.start,
                  style: semiBoldBaseFont.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  hospitalContact.firstContact[1],
                  textAlign: TextAlign.start,
                  style: regularBaseFont.copyWith(
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  hospitalContact.secondContact[0],
                  textAlign: TextAlign.start,
                  style: semiBoldBaseFont.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  hospitalContact.secondContact[1],
                  textAlign: TextAlign.start,
                  style: regularBaseFont.copyWith(
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  hospitalContact.thirdContact[0],
                  textAlign: TextAlign.start,
                  style: semiBoldBaseFont.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  hospitalContact.thirdContact[1],
                  textAlign: TextAlign.start,
                  style: regularBaseFont.copyWith(
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}