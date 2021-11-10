import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heaven_canceller_hospital/models/doctor.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/booking/booking_confirmation_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/components/doctor_schedule_info.dart';
import 'package:heaven_canceller_hospital/ui/booking/register_account_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:hive/hive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailDoctorScreen extends StatelessWidget {
  static String routeName = '/detail_doctor_screen';

  @override
  Widget build(BuildContext context) {
    final Doctor doctor = ModalRoute.of(context).settings.arguments;

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
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      /// SECTION: BACK PHOTO CONTENT
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: doctor.photo,
                            width: 1.sw,
                            height: (getOrientation(context) == Orientation.portrait) 
                            ? 275.r : 600.r,
                            fit: BoxFit.cover,
                            placeholder: (_, url) => SpinKitRing(
                              color: accentColor,
                              size: 50.r,
                            ),
                          ),
                          Container(
                            width: 1.sw,
                            height: 275.r,
                            color: blackColor.withOpacity(0.3),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 24.r,
                            left: 20.r,
                          ),
                          child: GestureDetector(
                            child: Icon(
                              Icons.arrow_back,
                              size: 28.r,
                              color: baseColor,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),

                      /// SECTION: DOCTOR INFO CONTENT
                      Container(
                        width: deviceWidth(context),
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(
                          top: 260.r,
                        ),
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor.name,
                                      style: semiBoldBaseFont.copyWith(
                                        fontSize: 18.sp,
                                        color: darkGreyColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "assets/image/ic_statescope.png",
                                          width: 16.r,
                                          height: 16.r,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          doctor.speciality,
                                          style: regularBaseFont.copyWith(
                                            fontSize: 14.sp,
                                            color: lightGreyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: yellowColor,
                                      size: 30.sp,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      doctor.star.toString(),
                                      style: mediumBaseFont.copyWith(
                                        fontSize: 16.sp,
                                        color: darkGreyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Text(
                              "Jadwal",
                              style: semiBoldBaseFont.copyWith(
                                fontSize: 16.sp,
                                color: accentColor,
                              ),
                            ),
                            Column(
                              children: doctor.doctorSchedule.map((schedule) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    DoctorScheduleInfo(
                                      day: schedule.dayName,
                                      place: schedule.place,
                                      time: schedule.time,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Text(
                              "Biografi",
                              style: semiBoldBaseFont.copyWith(
                                fontSize: 16.sp,
                                color: accentColor,
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              doctor.biography,
                              textAlign: TextAlign.start,
                              style: regularBaseFont.copyWith(
                                fontSize: 12.sp,
                                height: 1.7,
                                color: greyColor,
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Text(
                              "Pendidikan",
                              style: semiBoldBaseFont.copyWith(
                                fontSize: 16.sp,
                                color: accentColor,
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Column(
                              children: doctor.education.map((education) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 6.r,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          education,
                                          style: regularBaseFont.copyWith(
                                            fontSize: 12.sp,
                                            height: 1.7,
                                            color: greyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Text(
                              "Kredensial",
                              style: semiBoldBaseFont.copyWith(
                                fontSize: 16.sp,
                                color: accentColor,
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Column(
                              children: doctor.credential.map((credential) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 6.r,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          credential,
                                          style: regularBaseFont.copyWith(
                                            fontSize: 12.sp,
                                            height: 1.7,
                                            color: greyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 78.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// SECTION: BUTTON NEXT NAVIGATION
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 1.sw,
                    height: 76.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin.r,
                      vertical: 16.r,
                    ),
                    decoration: BoxDecoration(
                      color: baseColor,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFCCCCCC),
                          blurRadius: 20,
                          offset: Offset(0, 0),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: AccentRaisedButton(
                      width: 1.sw,
                      height: 44.r,
                      color: accentColor,
                      borderRadius: 8,
                      text: "Buat Janji",
                      fontSize: 14.sp,
                      onPressed: () async {
                        onSubmitPressed(context, doctor);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Method ketika tombol "buat janji" ditekan
  Future<void> onSubmitPressed(BuildContext context, Doctor doctor) async {
    final Box<Patient> patientBox = Hive.box('patients');

    if (patientBox.length != 0) {
      Navigator.pushNamed(context, BookingConfirmationScreen.routeName,
        arguments: doctor,
      );
    } else {
      Navigator.pushNamed(context, RegisterAccountScreen.routeName,
        arguments: doctor,
      );
    }
  }
}