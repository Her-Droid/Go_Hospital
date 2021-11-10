import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/doctor.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorViewCard extends StatelessWidget {
  final Doctor doctor;
  final Function onTap;

  DoctorViewCard(
    this.doctor, {
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFCCCCCC),
              blurRadius: 20,
              offset: Offset(0, 0),
              spreadRadius: -5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: doctor.photo,
                    height: 130.r,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SpinKitRing(
                      color: accentColor,
                      size: 50.r,
                    ),
                  ),
                  Container(
                    height: 130.r,
                    color: blackColor.withOpacity(0.2),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.r,
              ),
              child: Text(
                doctor.name,
                style: semiBoldBaseFont.copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.r,
              ),
              child: Text(
                doctor.speciality,
                style: mediumBaseFont.copyWith(
                  fontSize: 11.sp,
                  color: lightGreyColor
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.r,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: BoxDecoration(
                          color: (doctor.status == "Online") ? finishColor : orangeColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 4.r,
                      ),
                      Text(
                        doctor.status,
                        style: mediumBaseFont.copyWith(
                          fontSize: 11.sp,
                          color: (doctor.status == "Online") ? finishColor : orangeColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16.r,
                        color: yellowColor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        doctor.star.toString(),
                        style: mediumBaseFont.copyWith(
                          color: darkGreyColor,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}