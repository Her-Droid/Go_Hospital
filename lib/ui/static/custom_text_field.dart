import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final String errorValidation;
  final int maxLines;
  final TextInputFormatter inputFormatter;
  final double fontSize;
  final bool enabled;

  CustomTextField({
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.errorValidation,
    this.maxLines,
    this.inputFormatter,
    this.fontSize,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (labelText != null)
              Text(
                labelText,
                style: mediumBaseFont.copyWith(
                  fontSize: 12.sp,
                  color: darkGreyColor,
                ),
              ),
            if (errorValidation != null)
              Text(
                errorValidation,
                style: regularBaseFont.copyWith(
                  color: maroonColor,
                  fontSize: 11.sp,
                ),
              ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        TextField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          style: regularBaseFont.copyWith(fontSize: (fontSize ?? 14.sp) - 1),
          maxLines: (maxLines != null) ? maxLines : 1,
          onChanged: onChanged,
          inputFormatters: (inputFormatter != null) ? [inputFormatter] : null,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: regularBaseFont.copyWith(
              fontSize: (fontSize ?? 14.sp) - 1,
              color: lightGreyColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.r,
              horizontal: 14.r,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: lightGreyColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: darkGreyColor,
              ),
            ),
            suffixIcon: suffixIcon,
            prefix: prefixIcon,
          ),
        ),
      ],
    );
  }
}
