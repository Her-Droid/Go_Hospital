import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/personal_notification.dart';
import 'package:heaven_canceller_hospital/services/personal_notification_service.dart';

///* Class Provider PersonalNotification
/// Class untuk menghandle state data notifikasi pengguna 

class PersonalNotificationProvider extends ChangeNotifier {
  List<PersonalNotification> _personalNotification;

  List<PersonalNotification> get personalNotification => _personalNotification;

  /// Memuat data notifikasi dari notifikasi service firebase
  void loadResource() async {
    _personalNotification = await PersonalNotificationService.getResource();

    notifyListeners();
  }
}