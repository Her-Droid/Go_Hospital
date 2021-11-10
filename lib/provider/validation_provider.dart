import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

///* Class Provider Doctor
/// Class untuk menghandle state data validasi error input form 

class ValidationProvider extends ChangeNotifier {
  String _errorName;
  String _errorEmail;
  String _errorPhoneNumber;
  String _errorPassword;
  String _errorPasswordConfirmation;
  bool _isAcceptTerm = false;

  String get errorName => _errorName;
  String get errorEmail => _errorEmail;
  String get errorPhoneNumber => _errorPhoneNumber;
  String get errorPassword => _errorPassword;
  String get errorPasswordConfirmation => _errorPasswordConfirmation;
  bool get isAcceptTerm => _isAcceptTerm;

  /// Memantau input nama untuk dilakukan validasi
  void changeName(String value) {
    if (value.length == 0) {
      _errorName = "Nama Pasien Harus Diisi";
    } 
    else {
      _errorName = "";
    }

    notifyListeners();
  }

  /// Memantau input email untuk dilakukan validasi
  void changeEmail(String value) {
    if (value.length == 0) {
      _errorEmail = "Email Harus Diisi";
    }
    else if (EmailValidator.validate(value) == false) {
      _errorEmail = "Email Harus Valid";
    }
    else {
      _errorEmail = "";
    }

    notifyListeners();
  }

  /// Memantau input nomor telepon untuk dilakukan validasi
  void changePhoneNumber(String value) {
    if (value.length == 0) {
      _errorPhoneNumber = "No Handphone Harus Diisi";
    }
    else if (value.length < 9) {
      _errorPhoneNumber = "Minimal 9 Karakter";
    }
    else if (value.length > 15) {
      _errorPhoneNumber = "Maksimal 15 Karakter";
    }
    else {
      _errorPhoneNumber = "";
    }

    notifyListeners();
  }

  /// Memantau input password untuk dilakukan validasi
  void changePassword(String value) {
    if (value.length == 0) {
      _errorPassword = "Password Harus Diisikan";
    }
    else if (value.length < 6) {
      _errorPassword = "Password Minimal 6 karakter";
    }
    else {
      _errorPassword = "";
    }

    notifyListeners();
  }

  /// Memantau input konfirmasi untuk dilakukan validasi
  void changePasswordConfirmation(String value, String password) {
    if (value.length == 0) {
      _errorPasswordConfirmation = "Password Harus Diisikan";
    }
    else if (value != password) {
      _errorPasswordConfirmation = "Konfirmasi Tidak Sama";
    }
    else {
      _errorPasswordConfirmation = "";
    }

    notifyListeners();
  }

  /// Memantau checkbox ketentuan layanan untuk dilakukan validasi
  void changeTerm(bool value) {
    _isAcceptTerm = !_isAcceptTerm;

    notifyListeners();
  }

  /// Mengecek apakah semua input telah terisi
  bool isAllValidate() {
    if (_errorName == "" && _errorEmail == "" && _errorPhoneNumber == "") {
      return true;
    }
    else {
      return false;
    }
  }

  /// Mereset semua error input form
  void resetChange() {
    _errorName = null;
    _errorEmail = null;
    _errorPhoneNumber = null;
    _errorPassword = null;
    _errorPasswordConfirmation = null;
    _isAcceptTerm = false;

    notifyListeners();
  }
}