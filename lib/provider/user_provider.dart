import 'package:flutter/material.dart';
import 'package:heaven_canceller_hospital/models/user.dart';
import 'package:heaven_canceller_hospital/services/user_service.dart';

///* Class Provider User
/// Class untuk menghandle state data user

class UserProvider extends ChangeNotifier {
  User _user;

  User get user => _user;

  /// Memuat data user dari service facility service firebase
  void loadResource(String id) async {
    _user = await UserService.getUser(id);

    notifyListeners();
  }
}