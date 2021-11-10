import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyViewState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/image/empty_state.png",
            width: 120.r,
            height: 120.r,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Tidak Ada Hasil",
            style: mediumBaseFont.copyWith(
              color: darkGreyColor,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}