import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';
import 'package:heaven_canceller_hospital/provider/booking_provider.dart';
import 'package:heaven_canceller_hospital/provider/personal_notification_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/booking/register_account_screen.dart';
import 'package:heaven_canceller_hospital/ui/profile/components/history_personal_card.dart';
import 'package:heaven_canceller_hospital/ui/profile/components/notification_personal_card.dart';
import 'package:heaven_canceller_hospital/ui/profile/detail_notification_screen.dart';
import 'package:heaven_canceller_hospital/ui/report_pdf.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:heaven_canceller_hospital/ui/static/empty_view_state.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNotificationTab = true;

  @override
  Widget build(BuildContext context) {
    final Box<Patient> patientBox = Hive.box('patients');

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
                  color: accentColor,
                ),
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      /// SECTION: TITLE BACK BUTTON
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 24.r,
                            left: 20.r,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/image/ic_profile_white.png",
                                width: 28.r,
                                height: 28.r,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text(
                                "Profile",
                                style: semiBoldBaseFont.copyWith(
                                  color: baseColor,
                                  fontSize: 24.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 1.sw,
                            padding: EdgeInsets.symmetric(
                              vertical: 16.r,
                            ),
                            constraints: BoxConstraints(
                              minHeight: 550.r,
                            ),
                            margin: EdgeInsets.only(
                              top: 160.r,
                              bottom: 44.r,
                            ),
                            decoration: BoxDecoration(
                              color: baseColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: (patientBox.isNotEmpty) ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// SECTION: USER PROFILE CONTENT
                                SizedBox(
                                  height: 50.h,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      patientBox.getAt(0).name,
                                      style: semiBoldBaseFont.copyWith(
                                        fontSize: 14.sp,
                                        color: darkGreyColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      patientBox.getAt(0).gender,
                                      style: regularBaseFont.copyWith(
                                        fontSize: 12,
                                        color: greyColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      patientBox.getAt(0).phoneNumber,
                                      style: regularBaseFont.copyWith(
                                        fontSize: 12.sp,
                                        color: lightGreyColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),

                                /// SECTION: TAB BAR NOTIFICATION
                                Container(
                                  width: defaultWidth(context).r,
                                  height: 43.r,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: defaultMargin.r,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                          child: Container(
                                            height: 35.r,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 4.r,
                                            ),
                                            decoration: BoxDecoration(
                                              color: (isNotificationTab) ? baseColor : Colors.transparent,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Notifikasi",
                                                  style: semiBoldBaseFont.copyWith(
                                                    fontSize: 12.5.sp,
                                                    color: darkGreyColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Container(
                                                  width: 16.w,
                                                  height: 16.w,
                                                  decoration: BoxDecoration(
                                                    color: orangeColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Consumer<PersonalNotificationProvider>(
                                                      builder: (context, notification, _) => Text(
                                                        notification.personalNotification.length.toString(),
                                                        style: semiBoldBaseFont.copyWith(
                                                          fontSize: 10.sp,
                                                          color: baseColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              isNotificationTab = true;
                                            });
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                          child: Container(
                                            height: 35.r,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 4.r,
                                            ),
                                            decoration: BoxDecoration(
                                              color: (!isNotificationTab) ? baseColor : Colors.transparent,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Riwayat",
                                                  style: semiBoldBaseFont.copyWith(
                                                    fontSize: 12.5.sp,
                                                    color: darkGreyColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Container(
                                                  width: 16.r,
                                                  height: 16.r,
                                                  decoration: BoxDecoration(
                                                    color: orangeColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Consumer<BookingProvider>(
                                                      builder: (context, bookingProvider, _) => Text(
                                                        bookingProvider.bookings.length.toString(),
                                                        style: semiBoldBaseFont.copyWith(
                                                          fontSize: 10.sp,
                                                          color: baseColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              isNotificationTab = false;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),

                                /// SECTION: NOTIFICATION CARD LIST
                                if (isNotificationTab) Consumer<PersonalNotificationProvider>(
                                  builder: (context, notification, _) => Column(
                                    children: notification.personalNotification.map((notif) {
                                      return NotificationPersonalCard(
                                        notif,
                                        isNew: true,
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context, 
                                            DetailNotificationScreen.routeName,
                                            arguments: notif,
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),

                                /// SECTION: HISTORY CARD LIST
                                if (!isNotificationTab) Consumer<BookingProvider>(
                                  builder: (context, bookingProvider, _) {
                                    if (bookingProvider.bookings.length != 0) {
                                      return Column(
                                        children: bookingProvider.bookings.map((booking){
                                          return HistoryPersonalCard(
                                            booking,
                                            onTap: () {},
                                            isFinish: booking.reportTime.isBefore(
                                              DateTime.now(),
                                            ),
                                            onOpenReport: () {
                                              reportPDF(
                                                context,
                                                idBooking: booking.id,
                                                patientName: booking.patient.name,
                                                patientGender: booking.patient.gender,
                                                message: (booking.message == null || booking.message == "") ? booking.message : "-",
                                                serviceType: booking.serviceType ?? "-",
                                                purposeType: booking.purposeType,
                                                paymentMethod: booking.paymentMethod,
                                                totalPrice: booking.totalPrice,
                                              );
                                            },
                                          );
                                        }).toList(),
                                      );
                                    }

                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: 55.r,
                                        bottom: 60.r,
                                      ),
                                      child: EmptyViewState(),
                                    );
                                  },
                                ),
                              ],
                            ) : Container(
                              height: 405.r,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/image/unauth.png",
                                    width: 100.r,
                                    height: 100.r,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "Kamu Belum Membuat Akun,\nSilahkan Registrasi",
                                    textAlign: TextAlign.center,
                                    style: mediumBaseFont.copyWith(
                                      fontSize: 13.sp,
                                      color: darkGreyColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  AccentRaisedButton(
                                    width: 180.r,
                                    height: 44.r,
                                    borderRadius: 8,
                                    color: accentColor,
                                    fontColor: baseColor,
                                    fontSize: 13.sp,
                                    text: "Buat Akun",
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context, 
                                        RegisterAccountScreen.routeName,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// SECTION: PHOTO PROFILE CONTENT
                          if (patientBox.isNotEmpty) Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 100.r,
                              height: 100.r,
                              margin: EdgeInsets.only(
                                top: 110.r,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/image/female_placeholder.jpg",
                                  ),
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
        ],
      ),
    );
  }
}