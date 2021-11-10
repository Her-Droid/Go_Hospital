import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/news.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestNewsCard extends StatelessWidget {
  final News news;
  final Function onTap;

  LatestNewsCard(
    this.news, {
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 196.r,
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
            Container(
              width: 196.r,
              height: 120.r,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: news.imageURL,
                      height: 120.r,
                      width: 196.r,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SpinKitRing(
                        color: accentColor,
                        size: 50.r,
                      ),
                    ),
                    Container(
                      width: 196.r,
                      height: 120.r,
                      color: blackColor.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: semiBoldBaseFont.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    news.content[0],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: mediumBaseFont.copyWith(
                      fontSize: 11.sp,
                      color: lightGreyColor,
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