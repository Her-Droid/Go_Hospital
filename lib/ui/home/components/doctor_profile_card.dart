import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/doctor.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorProfileCard extends StatelessWidget {
  final Doctor doctor;
  final Function onTap;

  DoctorProfileCard(
    this.doctor, {
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 132.r,
        height: 196.r,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(8),
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
                    width: 132.r,
                    height: 120.r,
                    imageUrl: doctor.photo,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SpinKitRing(
                      color: accentColor,
                      size: 50.r,
                    ),
                  ),
                  Container(
                    width: 132.r,
                    height: 120.r,
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
              child: Text(
                Doctor.generateTimeAvailable(doctor.doctorSchedule) ?? "Libur",
                style: mediumBaseFont.copyWith(
                  fontSize: 11.sp,
                  color: (Doctor.generateTimeAvailable(doctor.doctorSchedule) == "Libur") 
                  ? orangeColor : accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}