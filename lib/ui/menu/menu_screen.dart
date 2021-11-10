import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/services/auth_service.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:heaven_canceller_hospital/shared/size.dart';
import 'package:heaven_canceller_hospital/ui/menu/about_us_screen.dart';
import 'package:heaven_canceller_hospital/ui/menu/components/more_menu_card.dart';
import 'package:heaven_canceller_hospital/ui/menu/feedback_webview_screen.dart';
import 'package:heaven_canceller_hospital/ui/menu/partner_career_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heaven_canceller_hospital/ui/wrapper.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin.r,
            vertical: 24.r,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SECTION: ICON TITLE HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/image/ic_menu_black.png",
                    width: 28.r,
                    height: 28.r,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "Menu",
                    style: semiBoldBaseFont.copyWith(
                      color: darkGreyColor,
                      fontSize: 24.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),

              /// SECTION: MENU CARD LIST
              Column(
                children: [
                  MoreMenuCard(
                    title: "Tentang Kami",
                    iconPath: "assets/image/ic_menu_user.png",
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        AboutUsScreen.routeName,
                      );
                    },
                  ),
                  MoreMenuCard(
                    title: "Partner & Career",
                    iconPath: "assets/image/ic_menu_partner.png",
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        PartnerCareerScreen.routeName,
                      );
                    },
                  ),
                  MoreMenuCard(
                    title: "Feedback",
                    iconPath: "assets/image/ic_feedback.png",
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        FeedbackWebviewScreen.routeName,
                      );
                    },
                  ),
                  MoreMenuCard(
                    title: "Logout",
                    icon: Icon(
                      Icons.logout,
                      color: accentColor,
                    ),
                    onTap: () {
                      AuthService.logOut().then((_) {
                        Navigator.pushNamedAndRemoveUntil(
                          context, 
                          Wrapper.routeName, 
                          (route) => false,
                        );
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}