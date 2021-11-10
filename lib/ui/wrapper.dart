import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/provider/booking_provider.dart';
import 'package:heaven_canceller_hospital/provider/doctor_provider.dart';
import 'package:heaven_canceller_hospital/provider/event_promo_provider.dart';
import 'package:heaven_canceller_hospital/provider/news_provider.dart';
import 'package:heaven_canceller_hospital/provider/personal_notification_provider.dart';
import 'package:heaven_canceller_hospital/provider/service_facility_provider.dart';
import 'package:heaven_canceller_hospital/provider/user_provider.dart';
import 'package:heaven_canceller_hospital/provider/vacancy_provider.dart';
import 'package:heaven_canceller_hospital/ui/auth/login_screen.dart';
import 'package:heaven_canceller_hospital/ui/home/main_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static String routeName = "/wrap";

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseUser = FirebaseAuth.instance;

    if (firebaseUser.currentUser == null) {
      return LoginScreen();
    }

    Provider.of<UserProvider>(context).loadResource(firebaseUser.currentUser.uid);
    
    Provider.of<EventPromoProvider>(context).loadResource();
    Provider.of<DoctorProvider>(context).loadResource();
    Provider.of<NewsProvider>(context).loadResource();
    Provider.of<ServiceFacilityProvider>(context).loadResource();
    Provider.of<VacancyProvider>(context).loadResource();
    Provider.of<PersonalNotificationProvider>(context).loadResource();
    Provider.of<BookingProvider>(context).loadResource();

    return Scaffold(
      body: MainScreen(),
    );
  }
}