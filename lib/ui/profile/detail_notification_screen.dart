import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/extensions/date_time_extension.dart';
import 'package:heaven_canceller_hospital/models/personal_notification.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailNotificationScreen extends StatelessWidget {
  static String routeName = '/detail_notification_screen';

  @override
  Widget build(BuildContext context) {
    final PersonalNotification personalNotification = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor,
          ),
          SafeArea(
            child: Stack(
              children: [
                Container(
                  color: baseColor,
                ),
                ListView(
                  children: [
                    /// SECTION: TITLE BACK BUTTON
                    SizedBox(
                      height: 24.h,
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20.r,
                            ),
                            child: GestureDetector(
                              child: Icon(
                                Icons.arrow_back,
                                color: darkGreyColor,
                                size: 28.r,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Align(  
                          alignment: Alignment.center,
                          child: Text(
                            "Detail Notifikasi",
                            style: semiBoldBaseFont.copyWith(
                              fontSize: 18.sp,
                              color: darkGreyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),

                    /// SECTION: TITLE INFO CONTENT
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin.r,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                          Text(
                            personalNotification.type,
                            style: mediumBaseFont.copyWith(
                              color: accentColor,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            personalNotification.title,
                            style: semiBoldBaseFont.copyWith(
                              color: darkGreyColor,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            DateTime
                            .fromMillisecondsSinceEpoch(personalNotification.time)
                            .dateAndtime,
                            style: semiBoldBaseFont.copyWith(
                              color: accentColor,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/image/ic_location.png",
                                width: 12.r,
                                height: 12.r,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "Rumah Sakit Columbia Asia",
                                style: regularBaseFont.copyWith(
                                  color: greyColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          /// SECTION: TEXT DESCRIPTION CONTENT
                          Text(
                            personalNotification.content,
                            style: regularBaseFont.copyWith(
                              fontSize: 12.sp,
                              height: 1.7,
                              color: darkGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}