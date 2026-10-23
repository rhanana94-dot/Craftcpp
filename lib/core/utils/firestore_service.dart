import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save User Progress
  Future<void> saveUserProgress(String userId, Map<String, dynamic> progressData) async {
    await _db.collection('users').doc(userId).set({
      'progress': progressData,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Load User Progress
  Future<Map<String, dynamic>?> getUserProgress(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      return doc.data()?['progress'] as Map<String, dynamic>?;
    }
    return null;
  }
}
