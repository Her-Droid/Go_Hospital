import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';
import 'package:heaven_canceller_hospital/provider/booking_provider.dart';
import 'package:heaven_canceller_hospital/provider/doctor_provider.dart';
import 'package:heaven_canceller_hospital/provider/event_promo_provider.dart';
import 'package:heaven_canceller_hospital/provider/navigation_provider.dart';
import 'package:heaven_canceller_hospital/provider/personal_notification_provider.dart';
import 'package:heaven_canceller_hospital/provider/service_facility_provider.dart';
import 'package:heaven_canceller_hospital/shared/color.dart';
import 'package:heaven_canceller_hospital/shared/font.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavbar extends StatelessWidget {
  final BuildContext context;

  BottomNavbar(this.context);

  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context, listen: false);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60.r,
        decoration: BoxDecoration(
          color: baseColor,
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.12),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: navigation.index,
          type: BottomNavigationBarType.fixed, 
          onTap: (index) {
            navigation.changeIndex(index);
            Provider.of<EventPromoProvider>(context, listen: false).resetKeyword();
            Provider.of<ServiceFacilityProvider>(context, listen: false).resetKeyword();
            Provider.of<DoctorProvider>(context, listen: false).resetKeyword();
          },
          selectedLabelStyle: mediumBaseFont.copyWith(
            color: accentColor,
            fontSize: 10.sp,
          ),
          unselectedLabelStyle: mediumBaseFont.copyWith(
            color: navInactiveColor,
            fontSize: 10.sp,
          ),
          items: [
            _buildBottomNavBarItem(
              context,
              label: "Home",
              icon: "assets/image/ic_home.png",
              activeIcon: "assets/image/ic_home_active.png",
            ),
            _buildBottomNavBarItem(
              context,
              label: "Layanan",
              icon: "assets/image/ic_layanan.png",
              activeIcon: "assets/image/ic_layanan_active.png",
            ),
            _buildBottomNavBarItem(
              context,
              label: "Booking",
              icon: "assets/image/ic_booking.png",
              activeIcon: "assets/image/ic_booking_active.png",
            ),
            _buildBottomNavBarItem(
              context,
              label: "Profile",
              icon: "assets/image/ic_profile.png",
              activeIcon: "assets/image/ic_profile_active.png",
            ),
            _buildBottomNavBarItem(
              context,
              label: "More",
              icon: "assets/image/ic_more.png",
              activeIcon: "assets/image/ic_more_active.png",
            ),
          ],
        ),
      ),
    );
  }
}

BottomNavigationBarItem _buildBottomNavBarItem(BuildContext context, {String label, String icon, String activeIcon}) {
  final Box<Patient> patientBox = Hive.box('patients');
  final PersonalNotificationProvider notifProvider = Provider.of<PersonalNotificationProvider>(context);
  final BookingProvider bookingProvider = Provider.of<BookingProvider>(context);

  int notifCount;
  int bookingCount;

  if (notifProvider.personalNotification != null && bookingProvider.bookings != null) {
    notifCount = notifProvider.personalNotification.length;
    bookingCount = bookingProvider.bookings.length;
  } else {
    notifCount = 0;
    bookingCount = 0;
  }

  return BottomNavigationBarItem(
    label: label,
    icon: (label == "Profile") ? Consumer<NavigationProvider>(
      builder: (context, navigationProvider, _) { 
        return Stack(
          children: [
            Container(
              height: 24.r,
              margin: EdgeInsets.only(bottom: 6.r),
              child: Image.asset(
                icon,
              ),
            ),
            if (patientBox.isNotEmpty) Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 12.r,
                height: 12.r,
                decoration: BoxDecoration(
                  color: orangeColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${notifCount + bookingCount}",
                    style: semiBoldBaseFont.copyWith(
                      fontSize: 7.8.sp,
                      color: baseColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ) : Container(
      height: 24.r,
      margin: EdgeInsets.only(bottom: 6.r),
      child: Image.asset(
        icon,
      ),
    ),
    activeIcon: (label == "Profile") ? Consumer<NavigationProvider>(
      builder: (context, navigationProvider, _) { 
        return Stack(
          children: [
            Container(
              height: 24.r,
              margin: EdgeInsets.only(bottom: 6.r),
              child: Image.asset(
                activeIcon,
              ),
            ),
            if (patientBox.isNotEmpty) Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 12.r,
                height: 12.r,
                decoration: BoxDecoration(
                  color: orangeColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${notifCount + bookingCount}",
                    style: semiBoldBaseFont.copyWith(
                      fontSize: 7.8.sp,
                      color: baseColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ) : Container(
      height: 24.r,
      margin: EdgeInsets.only(bottom: 6.r),
      child: Image.asset(
        activeIcon,
      ),
    ),
  );
}