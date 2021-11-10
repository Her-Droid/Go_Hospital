import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heaven_canceller_hospital/models/patient.dart';

///* Class Service Patient
/// Class untuk menghandle resource pasien rumah sakit

class PatientService {
  static CollectionReference _patientCollection 
  = FirebaseFirestore.instance.collection('patients');

  /// Melakukan simpan data collection pasien rumah sakit
  static Future<void> storeResource(Patient patient) async {
    await _patientCollection.doc().set({
      'id': patient.id,
      'name': patient.name,
      'gender': patient.gender,
      'email': patient.email,
      'phone_number': patient.phoneNumber,
      'status': patient.status,
    });
  }

  /// Mendapatkan data collection pasien rumah sakit
  static Future<Patient> getSingle(String email) async {
    QuerySnapshot snapshot = await _patientCollection
    .where("email", isEqualTo: email)
    .get();

    return Patient(
      id: snapshot.docs[0].id,
      name: snapshot.docs[0].data()["name"],
      email: snapshot.docs[0].data()["email"],
      gender: snapshot.docs[0].data()["gender"],
      status: snapshot.docs[0].data()["status"],
      phoneNumber: snapshot.docs[0].data()["phone_number"],
    );
  }
}