import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/personal_notification.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/utils/date_time_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPersonalCard extends StatelessWidget {
  final PersonalNotification notification;
  final Function onTap;
  final bool isNew;

  NotificationPersonalCard(
    this.notification, {
    this.onTap,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 1.sw,
        height: 110.r,
        padding: EdgeInsets.symmetric(
          vertical: 12.r,
          horizontal: 20.r,
        ),
        color: (isNew) ? Color(0xFFF2F2F2) : baseColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              notification.imagePath,
              width: 48.r,
              height: 48.r,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: semiBoldBaseFont.copyWith(
                      color: darkGreyColor,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    notification.subtitle,
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    style: regularBaseFont.copyWith(
                      color: darkGreyColor,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateTimeUtil.generateDiffHuman(notification.time),
                        style: regularBaseFont.copyWith(
                          fontSize: 11.sp,
                          color: greyColor,
                        ),
                      ),
                      if (isNew) Container(
                        width: 44.r,
                        height: 20.r,
                        decoration: BoxDecoration(
                          color: orangeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "New",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 10.sp,
                              color: baseColor,
                            ),
                          ),
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