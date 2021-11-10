import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/booking.dart';
import 'package:heaven_canceller_hospital/services/booking_service.dart';

///* Class Provider Booking
/// Class untuk menghandle state data booking

class BookingProvider extends ChangeNotifier {
  List<Booking> _bookings;

  List<Booking> get bookings => _bookings;

  /// Memuat data booking dari booking service firebase
  void loadResource() async {
    _bookings = await BookingService.getResource();

    notifyListeners();
  }
}