import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/vacancy.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VacancyJobCard extends StatelessWidget {
  final Vacancy vacancy;
  final Function onTap;

  VacancyJobCard(
    this.vacancy, {
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 1.sw,
        height: 218.r,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(6),
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
            Container(
              width: 1.sw,
              height: 120.r,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: vacancy.imageURL,
                      height: 120.r,
                      width: 1.sw,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SpinKitRing(
                        color: accentColor,
                        size: 50.r,
                      ),
                    ),
                    Container(
                      width: 1.sw,
                      height: 120.r,
                      color: blackColor.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.r,
                vertical: 10.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Lowongan",
                    style: mediumBaseFont.copyWith(
                      fontSize: 11.sp,
                      color: accentColor,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    vacancy.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: semiBoldBaseFont.copyWith(
                      fontSize: 12.sp,
                      color: darkGreyColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    vacancy.content[0],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: regularBaseFont.copyWith(
                      fontSize: 11.sp,
                      color: greyColor,
                    ),
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