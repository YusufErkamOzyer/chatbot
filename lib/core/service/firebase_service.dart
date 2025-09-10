import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final firestore = FirebaseFirestore.instance;
  Future<void> addNewMessage(String text, String sender) async {
    await firestore
        .collection('chats')
        .doc('HDzEaDTOYUMPIXukoIbT')
        .collection('messages')
        .add({"message": text, "sender": sender, "timestamp": Timestamp.now()});
  }

  Stream<List<Map<String, dynamic>>>? getMessagesStream() {
    return firestore
        .collection('chats')
        .doc('HDzEaDTOYUMPIXukoIbT')
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
