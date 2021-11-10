import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heaven_canceller_hospital/models/user.dart';

///* Class Service User
/// Class untuk menghandle resource user

class UserService {
  static CollectionReference _userCollection 
  = FirebaseFirestore.instance.collection('users');
  
  /// Melakukakn update data user rumah sakit
  static Future<void> updateUser(User user) async {
    await _userCollection.doc(user.id).set({
      'name': user.name,
      'email': user.email,
      'gender': user.gender,
      'phone_number': user.phoneNumber,
      'insurance_number': user.insuranceNumber,
    });
  }

  /// Mendapatkan data user rumah sakit
  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return User(
      id: id,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      gender: snapshot.data()['gender'],
      phoneNumber: snapshot.data()['phone_number'],
      insuranceNumber: snapshot.data()['insurance_number'],
    );
  }
}