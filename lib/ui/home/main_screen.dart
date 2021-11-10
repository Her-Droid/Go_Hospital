import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/provider/navigation_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/ui/booking/booking_screen.dart';
import 'package:heaven_canceller_hospital/ui/home/home_screen.dart';
import 'package:heaven_canceller_hospital/ui/menu/menu_screen.dart';
import 'package:heaven_canceller_hospital/ui/profile/profile_screen.dart';
import 'package:heaven_canceller_hospital/ui/service/service_screen.dart';
import 'package:heaven_canceller_hospital/ui/static/bottom_navbar.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static String routeName = '/main_screen';
  
  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                PageView(
                  controller: navigation.pageIndex,
                  onPageChanged: (index) {
                    navigation.changeIndex(index);
                  },
                  children: [
                    HomeScreen(),
                    ServiceScreen(),
                    BookingScreen(),
                    ProfileScreen(),
                    MenuScreen(),
                  ],
                ),
                BottomNavbar(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}