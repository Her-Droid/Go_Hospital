import 'package:cloud_firestore/cloud_firestore.dart';

///* Class Service AboutUs
/// Class untuk menghandle resource tentang rumah sakit

class YoutubeService {
  static CollectionReference _youtubeCollection 
  = FirebaseFirestore.instance.collection('youtube_video');
  
  /// Mlakukan fetch single data berdasarkan collection id
  static Stream<DocumentSnapshot> getSingle() {
    Stream<DocumentSnapshot> snapshot = _youtubeCollection
    .doc('YQtyaIS9kmWzbUeFarbt')
    .snapshots();

    return snapshot;
  }
}