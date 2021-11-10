import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularLoadingState extends StatelessWidget {
  final double height;
  final String state;
  final Color color;
  final Color fontColor;

  CircularLoadingState({
    this.height,
    this.state,
    this.color = accentColor,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth(context),
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitRing(
              color: color,
              size: 50.r,
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              state,
              style: mediumBaseFont.copyWith(
                fontSize: 13.sp,
                color: fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}