import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableBoxButton extends StatelessWidget {
  final double borderRadius;
  final double thickBorder;
  final String content;
  final bool isSelected;
  final Color borderColor;
  final Color fontColor;
  final bool isMarginRight;
  final Function onTap;

  SelectableBoxButton({
    this.borderRadius,
    this.thickBorder,
    this.content,
    this.isSelected = false,
    this.borderColor = accentColor,
    this.fontColor = accentColor,
    this.isMarginRight = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          right: isMarginRight ? 12.r : 0,
          bottom: 10.r,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.r,
          vertical: 4.r,
        ),
        decoration: BoxDecoration(
          color: isSelected ? accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isSelected ? accentColor : borderColor,
            width: thickBorder,
          ),
        ),
        child: Text(
          content,
          style: mediumBaseFont.copyWith(
            color: isSelected ? baseColor : fontColor,
            fontSize: 11.sp,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}