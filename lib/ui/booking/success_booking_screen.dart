import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/provider/booking_provider.dart';
import 'package:heaven_canceller_hospital/provider/navigation_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/home/main_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/accent_raised_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessBookingScreen extends StatelessWidget {
  static String routeName = "/success_booking_screen";

  @override
  Widget build(BuildContext context) {
    final String bookingID = ModalRoute.of(context).settings.arguments;

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
                  child: Center(
                    child: Column(
                      children: [
                        /// SECTION: IMAGE ILLUSTRATION STATE
                        SizedBox(
                          height: 105.h - statusBarHeight(context),
                        ),
                        Container(
                          width: 100.r,
                          height: 100.r,
                          margin: EdgeInsets.only(
                            bottom: 24.r,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/image/check_success.png",
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Booking Sukses!",
                          style: semiBoldBaseFont.copyWith(
                            color: baseColor,
                            fontSize: 24.sp,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          "Kode Booking Anda",
                          style: regularBaseFont.copyWith(
                            color: baseColor,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          bookingID.substring(1, 8).toUpperCase(),
                          style: boldBaseFont.copyWith(
                            color: baseColor,
                            fontSize: 24.sp,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          "Silahkan menunggu antrian untuk berkonsultasi\ndengan dokter kami.",
                          textAlign: TextAlign.center,
                          style: regularBaseFont.copyWith(
                            color: baseColor,
                            fontSize: 12.sp,
                            height: 1.7,
                          ),
                        ),
                        SizedBox(
                          height: 140.h,
                        ),

                        /// SECTION: BUTTON NEXT NAVIGATION
                        AccentRaisedButton(
                          width: 1.sw - 2 * 20.r,
                          height: 44.r,
                          borderRadius: 8,
                          color: baseColor,
                          fontColor: accentColor,
                          fontSize: 14.sp,
                          text: "Lihat Riwayat",
                          onPressed: () {
                            onGoToHistoryPressed(context);
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        GestureDetector(
                          child: Text(
                            "Tidak, Kembali Ke Home",
                            style: regularBaseFont.copyWith(
                              color: baseColor,
                              fontSize: 12.sp,
                            ),
                          ),
                          onTap: () {
                            onGoToHomePressed(context);
                          },
                        ),
                      ],
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

  /// Method ketika tombol "Lihat History" ditekan
  void onGoToHistoryPressed(BuildContext context) {
    Provider
    .of<BookingProvider>(context, listen: false)
    .loadResource();

    Provider
    .of<NavigationProvider>(context, listen: false)
    .changeIndex(3, initialPage: 3);

    Navigator.pushNamedAndRemoveUntil(
      context,
      MainScreen.routeName,
      (Route<dynamic> route) => false,
    );
  }

  /// Method ketika tombol "kembali ke home" ditekan
  void onGoToHomePressed(BuildContext context) {
    Provider
    .of<BookingProvider>(context, listen: false)
    .loadResource();

    Provider
    .of<NavigationProvider>(context, listen: false)
    .changeIndex(0);
    
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainScreen.routeName,
      (Route<dynamic> route) => false,
    );
  }
}