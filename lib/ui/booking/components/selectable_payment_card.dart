import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectablePaymentCard extends StatelessWidget {
  final String optionName;
  final String optionDescription;
  final String optionImage;
  final int selectedOption;
  final int option;
  final Function(dynamic) onChanged;
  final bool isSelected;
  final Widget inputDesc;
  final String paymentNumber;
  final void Function() onTap;

  SelectablePaymentCard({
    this.optionName,
    this.optionDescription,
    this.optionImage,
    this.selectedOption, 
    this.option,
    this.onChanged, 
    this.isSelected = false,
    this.inputDesc,
    this.paymentNumber,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: 20.r,
            vertical: 14.r,
          ),
          decoration: BoxDecoration(
            color: isSelected ? greenSecondary : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? Border.all(
              color: greenPrimary,
            ) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                offset: Offset(0, 7),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 14.r,
                height: 14.r,
                child: Radio(
                  value: option,
                  groupValue: selectedOption,
                  toggleable: true,
                  activeColor: greenPrimary,
                  onChanged: onChanged,
                ),
              ),
              SizedBox(
                width: 18.w,
              ),
              Row(
                children: [
                  Image.asset(
                    optionImage,
                    width: 30.r,
                    height: 30.r,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        optionName,
                        overflow: TextOverflow.ellipsis,
                        style: boldBaseFont.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      // ignore: unnecessary_null_comparison
                      optionDescription != null ? SizedBox(
                        height: 2.h,
                      ) : SizedBox(),
                      // ignore: unnecessary_null_comparison
                      !(inputDesc != null) ? optionDescription != null ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            optionDescription ?? "",
                            style: regularBaseFont.copyWith(
                              fontSize: 10.sp,
                            ),
                          ),
                          (paymentNumber != "" && paymentNumber != null) ? Text(
                            " - Linked",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 10.sp,
                              color: accentColor,
                            ),
                          ) : SizedBox(),
                        ],
                      ) : SizedBox() : inputDesc,
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}