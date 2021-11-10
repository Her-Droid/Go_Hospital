import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/ui/static/custom_radio_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientRadioOption extends StatelessWidget {
  final String name;
  final String gender;
  final String status;
  final String value;
  final String groupValue;
  final Function(String) onChange;

  PatientRadioOption({
    this.name,
    this.gender,
    this.status,
    this.value,
    this.groupValue,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.r,
        vertical: 18.r,
      ),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: lightGreyColor,
            width: 1.r,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ("Nama: $name").replaceAll(RegExp(r'"'), ""),
                textAlign: TextAlign.start,
                style: regularBaseFont.copyWith(
                  color: greyColor,
                  fontSize: 12.sp,
                  height: 1.7,
                ),
              ),
              Text(
                ("Jenis Kelamin: $gender").replaceAll(RegExp(r'"'), ""),
                textAlign: TextAlign.start,
                style: regularBaseFont.copyWith(
                  color: greyColor,
                  fontSize: 12.sp,
                  height: 1.7,
                ),
              ),
              Text(
                ("Status: $status").replaceAll(RegExp(r'"'), ""),
                textAlign: TextAlign.start,
                style: regularBaseFont.copyWith(
                  color: greyColor,
                  fontSize: 12.sp,
                  height: 1.7,
                ),
              ),
            ],
          ),
          CustomRadioButton(
            isLabelShow: false,
            size: 24.r,
            value: value,
            groupValue: groupValue,
            onChange: onChange,
          ),
        ],
      ),
    );
  }
}