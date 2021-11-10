import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:heaven_canceller_hospital/models/user.dart';
import 'package:heaven_canceller_hospital/services/user_service.dart';

///* FirebaseUser Extension - FirebaseUser Custom Extension
/// Extension untuk menambahkan ekstensi tambahan untuk class FirebaseUser
extension FirebaseUserExtension on auth.User {
  Future<User> fromFireStore() async => await UserService.getUser(this.uid);

  /// Konversi hasil data user menjadi class User
  User convertToUser({
    String name = "-", 
    String phoneNumber = "-",
    String gender,
    String insuranceNumber = "-",
  }) {
    return User(
      id: this.uid,
      email: this.email,
      name: name,
      phoneNumber: phoneNumber,
      gender: gender,
      insuranceNumber: insuranceNumber,
    );
  }
}