import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapAddressCard extends StatelessWidget {
  final String placeName;
  final String address;
  final String image;

  MapAddressCard({
    this.placeName,
    this.address,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 270.r,
        height: 72.r,
        padding: EdgeInsets.all(8.2.r),
        margin: EdgeInsets.only(
          bottom: 17.r,
        ),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              image,
              width: 73.85.r,
              height: 55.38.r,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 12.54.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  placeName,
                  style: semiBoldBaseFont.copyWith(
                    fontSize: 12.sp,
                    color: darkGreyColor,
                  ),
                ),
                Text(
                  address,
                  style: regularBaseFont.copyWith(
                    fontSize: 12.sp,
                    color: lightGreyColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}