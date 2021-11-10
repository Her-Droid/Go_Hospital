import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heaven_canceller_hospital/models/doctor.dart';
import 'package:heaven_canceller_hospital/models/doctor_schedule.dart';
import 'package:heaven_canceller_hospital/models/user.dart';

///* Class Service Doctor
/// Class untuk menghandle resource dokter rumah sakit

class LoginOTPService {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  /// Melakukan pengecekan phone number
  static Future<bool> checkRegisteredPhoneNumber(String phone) async {
    QuerySnapshot snapshot = await _userCollection.get();

    for (var document in snapshot.docs) {
      String phone_db = document.data()['phone_number'];
      if (phone_db == phone) {
        return true;
      }
    }
    return false;
  }
}
