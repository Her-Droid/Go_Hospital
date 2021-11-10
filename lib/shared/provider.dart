import 'package:heaven_canceller_hospital/provider/booking_provider.dart';
import 'package:heaven_canceller_hospital/provider/carousel_provider.dart';
import 'package:heaven_canceller_hospital/provider/doctor_provider.dart';
import 'package:heaven_canceller_hospital/provider/event_promo_provider.dart';
import 'package:heaven_canceller_hospital/provider/navigation_provider.dart';
import 'package:heaven_canceller_hospital/provider/news_provider.dart';
import 'package:heaven_canceller_hospital/provider/patient_provider.dart';
import 'package:heaven_canceller_hospital/provider/personal_notification_provider.dart';
import 'package:heaven_canceller_hospital/provider/service_facility_provider.dart';
import 'package:heaven_canceller_hospital/provider/user_provider.dart';
import 'package:heaven_canceller_hospital/provider/vacancy_provider.dart';
import 'package:heaven_canceller_hospital/provider/validation_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

///* Provider List
/// Berisi daftar provider class yang digunakan untuk menghandle state 
/// management pada aplikasi ini yang dipanggil pada root class.

List<SingleChildWidget> appProvider = [
  ChangeNotifierProvider(create: (_) => NavigationProvider()),
  ChangeNotifierProvider(create: (_) => CarouselProvider()),
  ChangeNotifierProvider(create: (_) => EventPromoProvider()),
  ChangeNotifierProvider(create: (_) => DoctorProvider()),
  ChangeNotifierProvider(create: (_) => NewsProvider()),
  ChangeNotifierProvider(create: (_) => ServiceFacilityProvider()),
  ChangeNotifierProvider(create: (_) => ValidationProvider()),
  ChangeNotifierProvider(create: (_) => PatientProvider()),
  ChangeNotifierProvider(create: (_) => VacancyProvider()),
  ChangeNotifierProvider(create: (_) => PersonalNotificationProvider()),
  ChangeNotifierProvider(create: (_) => BookingProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
];