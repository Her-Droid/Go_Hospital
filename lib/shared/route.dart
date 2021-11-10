import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/ui/auth/login_screen.dart';
import 'package:heaven_canceller_hospital/ui/auth/login_screen_otp.dart';
import 'package:heaven_canceller_hospital/ui/auth/register_screen.dart';
import 'package:heaven_canceller_hospital/ui/auth/register_screen_no_hp.dart';
import 'package:heaven_canceller_hospital/ui/auth/register_screen_otp.dart';
import 'package:heaven_canceller_hospital/ui/auth/user_data_otp_screen.dart';
import 'package:heaven_canceller_hospital/ui/auth/user_data_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/add_insurance_number.dart';
import 'package:heaven_canceller_hospital/ui/booking/add_patient_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/booking_confirmation_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/change_patient_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/detail_doctor_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/payment_method_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/register_account_screen.dart';
import 'package:heaven_canceller_hospital/ui/booking/success_booking_screen.dart';
import 'package:heaven_canceller_hospital/ui/home/main_screen.dart';
import 'package:heaven_canceller_hospital/ui/menu/about_us_screen.dart';
import 'package:heaven_canceller_hospital/ui/menu/detail_partner_vacancy_screen.dart';
import 'package:heaven_canceller_hospital/ui/menu/feedback_webview_screen.dart';
import 'package:heaven_canceller_hospital/ui/menu/partner_career_screen.dart';
import 'package:heaven_canceller_hospital/ui/profile/detail_notification_screen.dart';
import 'package:heaven_canceller_hospital/ui/service/covid_service_screen.dart';
import 'package:heaven_canceller_hospital/ui/service/detail_service_screen.dart';
import 'package:heaven_canceller_hospital/ui/service/event_promo_screen.dart';
import 'package:heaven_canceller_hospital/ui/service/latest_news_screen.dart';
import 'package:heaven_canceller_hospital/ui/wrapper.dart';

///* Page Route
/// Berisi map value yang digunakan untuk mendeklarasikan route yang 
/// ada berdasarkan [routeName] yang telah dibuat pada setiap screen.

Map<String, WidgetBuilder> appRoute = {
  Wrapper.routeName: (BuildContext context) => Wrapper(),
  MainScreen.routeName: (BuildContext context) => MainScreen(),
  EventPromoScreen.routeName: (BuildContext context) => EventPromoScreen(),
  AboutUsScreen.routeName: (BuildContext context) => AboutUsScreen(),
  DetailDoctorScreen.routeName: (BuildContext context) => DetailDoctorScreen(),
  LatestNewsScreen.routeName: (BuildContext context) => LatestNewsScreen(),
  DetailServiceScreen.routeName: (BuildContext context) => DetailServiceScreen(),
  RegisterAccountScreen.routeName: (BuildContext context) => RegisterAccountScreen(),
  BookingConfirmationScreen.routeName: (BuildContext context) => BookingConfirmationScreen(),
  ChangePatientScreen.routeName: (BuildContext context) => ChangePatientScreen(),
  AddPatientScreen.routeName: (BuildContext context) => AddPatientScreen(),
  SuccessBookingScreen.routeName: (BuildContext context) => SuccessBookingScreen(),
  FeedbackWebviewScreen.routeName: (BuildContext context) => FeedbackWebviewScreen(),
  PartnerCareerScreen.routeName: (BuildContext context) => PartnerCareerScreen(),
  DetailPartnerVacancyScreen.routeName: (BuildContext context) => DetailPartnerVacancyScreen(),
  DetailNotificationScreen.routeName: (BuildContext context) => DetailNotificationScreen(),
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  RegisterScreen.routeName: (BuildContext context) => RegisterScreen(),
  PaymentMethodScreen.routeName: (BuildContext context) => PaymentMethodScreen(),
  UserDataScreen.routeName: (BuildContext context) => UserDataScreen(),
  AddInsuranceScreen.routeName: (BuildContext context) => AddInsuranceScreen(),
  CovidServiceScreen.routeName: (BuildContext context) => CovidServiceScreen(),
  RegisterOtpScreen.routeName: (BuildContext context) => RegisterOtpScreen(),
  UserDataOtpScreen.routeName: (BuildContext context) => UserDataOtpScreen(),
  RegisterNoHpScreen.routeName: (BuildContext context) => RegisterNoHpScreen(),
  LoginOtpScreen.routeName: (BuildContext context) => LoginOtpScreen(),
};