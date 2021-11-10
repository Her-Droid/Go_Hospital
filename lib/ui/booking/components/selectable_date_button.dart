import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableDateButton extends StatelessWidget {
  final String date;
  final String dayName;
  final bool isSelected;
  final Function onTap;

  SelectableDateButton({
    this.date,
    this.dayName,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 64.r,
        height: 76.r,
        decoration: BoxDecoration(
          color: isSelected ? accentColor : Color(0xFFEAEAEA),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: semiBoldBaseFont.copyWith(
                  color: isSelected ? baseColor : greyColor, 
                  fontSize: 18.sp,
                ),
              ),
              Text(
                dayName,
                style: regularBaseFont.copyWith(
                  color: isSelected ? baseColor : lightGreyColor,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}