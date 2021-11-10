import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heaven_canceller_hospital/models/contact_complaint.dart';

///* Class Service ContactComplaint
/// Class untuk menghandle resource kontak darurat dan komplain pengguna

class ContactComplaintService {
  static CollectionReference _contactComplaintCollection 
  = FirebaseFirestore.instance.collection('contact_complaint');

  /// Melakukan fetch semua data kontak darurat dan komplain
  static Future<List<ContactComplaint>> getResource() async {
    QuerySnapshot snapshot = await _contactComplaintCollection.get();

    List<ContactComplaint> contactComplaint = [];

    for (var document in snapshot.docs) {
      contactComplaint.add(
        ContactComplaint(
          contact: document.data()['contact'],
          iconPath: document.data()['icon'],
          launcher: document.data()['launcher'],
        ),
      );
    }

    return contactComplaint;
  }
}