import 'package:cloud_firestore/cloud_firestore.dart';

class EvaluationFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveEvaluation({
    required String userId,
    required int chapter,
    required int theoryScore,
    required int correctAnswers,
    required int totalQuestions,
    Map<int, int>? selectedAnswers,
    int? codingScore,
    int? codingPassed,
    int? codingTotal,
    Map<String, dynamic>? codingResult,
  }) async {
    final data = <String, dynamic>{
      'chapter': chapter,
      'theoryScore': theoryScore,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'selectedAnswers': selectedAnswers?.map(
        (key, value) => MapEntry(
          key.toString(),
          value,
        ),
      ),
      'codingScore': codingScore,
      'codingPassed': codingPassed,
      'codingTotal': codingTotal,
      'codingResult': codingResult,
      'isCompleted': true,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('evaluations')
        .doc('chapter_$chapter')
        .set(
          data,
          SetOptions(merge: true),
        );
  }

  Future<Map<String, dynamic>?> getEvaluation({
    required String userId,
    required int chapter,
  }) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('evaluations')
        .doc('chapter_$chapter')
        .get();

    if (!snapshot.exists) {
      return null;
    }

    return snapshot.data();
  }

  Future<Map<int, Map<String, dynamic>>> getAllEvaluations(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('evaluations')
        .get();

    final Map<int, Map<String, dynamic>> results = {};
    for (final doc in snapshot.docs) {
      final data = doc.data();
      final chapter = data['chapter'];
      if (chapter is int) {
        results[chapter] = data;
      }
    }
    return results;
  }

  Future<void> saveSumatifEvaluation({
    required String userId,
    required int theoryScore,
    required int correctAnswers,
    required int totalQuestions,
    required Map<int, int> selectedAnswers,
    int? codingScore,
    int? codingPassed,
    int? codingTotal,
    Map<String, dynamic>? codingResult,
    String? repoLink,
  }) async {
    final data = <String, dynamic>{
      'isSumatif': true,
      'theoryScore': theoryScore,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'selectedAnswers': selectedAnswers.map((k, v) => MapEntry(k.toString(), v)),
      'codingScore': codingScore,
      'codingPassed': codingPassed,
      'codingTotal': codingTotal,
      'codingResult': codingResult,
      'repoLink': repoLink,
      'isCompleted': true,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('evaluations')
        .doc('sumatif')
        .set(data, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getSumatifEvaluation(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('evaluations')
        .doc('sumatif')
        .get();

    if (!snapshot.exists) {
      return null;
    }
    return snapshot.data();
  }
}