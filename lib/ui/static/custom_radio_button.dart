import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioButton extends StatelessWidget {
  final double size;
  final String value;
  final String groupValue;
  final bool isLabelShow;
  final Function(String) onChange;

  CustomRadioButton({
    this.size,
    this.value,
    this.groupValue,
    this.isLabelShow = true,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: size ?? 15.r,
          height: size ?? 15.r,
          child: Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChange,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: accentColor,
          ),
        ),
        if (isLabelShow) SizedBox(
          width: 8.w,
        ),
        if (isLabelShow) Text(
          value,
          style: regularBaseFont.copyWith(
            fontSize: 12.sp,
            color: greyColor,
          ),
        ),
      ],
    );
  }
}