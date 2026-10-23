import 'package:flutter/foundation.dart';
import '../core/utils/local_storage_service.dart';
import '../core/utils/teacher_sync_service.dart';

class UserProgressProvider extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

  String? _currentUserId;
  bool _isInitialized = false;
  Set<String> _completedChapterIds = <String>{};
  Map<String, int> _quizScores = <String, int>{};
  Map<int, Map<String, dynamic>> _evaluations = <int, Map<String, dynamic>>{};
  Map<String, dynamic>? _sumatifData;
  bool _isPreTestDone = false;
  int _preTestScore = 0;
  bool _isSumatifDone = false;
  String _sumatifSubmission = '';

  String? get currentUserId => _currentUserId;
  bool get isInitialized => _isInitialized;
  Set<String> get completedChapterIds => Set.unmodifiable(_completedChapterIds);
  Map<String, int> get quizScores => Map.unmodifiable(_quizScores);
  bool get isPreTestDone => _isPreTestDone;
  int get preTestScore => _preTestScore;
  bool get isSumatifDone => _isSumatifDone;
  String get sumatifSubmission => _sumatifSubmission;

  Future<void> init([String? userId]) async {
    _currentUserId = userId;
    _storage.setUserScope(userId);
    _isInitialized = false;
    _completedChapterIds = <String>{};
    _quizScores = <String, int>{};
    _evaluations = <int, Map<String, dynamic>>{};
    _sumatifData = null;
    _isPreTestDone = false;
    _preTestScore = 0;
    _isSumatifDone = false;
    _sumatifSubmission = '';
    notifyListeners();

    try {
      final data = await _storage.readProgress();
      final completed = data['completedChapterIds'];
      if (completed is Iterable) {
        _completedChapterIds.addAll(completed.map((e) => e.toString()));
      }
      final scores = data['quizScores'];
      if (scores is Map) {
        for (final entry in scores.entries) {
          final value = entry.value;
          if (value is num) _quizScores[entry.key.toString()] = value.toInt();
        }
      }
      _isPreTestDone = data['isPreTestDone'] == true;
      _preTestScore = _asInt(data['preTestScore']);
      _isSumatifDone = data['isSumatifDone'] == true;
      _sumatifSubmission = data['sumatifSubmission']?.toString() ?? '';

      _evaluations = await _storage.readAllEvaluations();
      for (final entry in _evaluations.entries) {
        if (entry.key >= 1 && entry.key <= 13 && entry.value['isCompleted'] == true) {
          _completedChapterIds.add(entry.key.toString());
          final score = entry.value['theoryScore'];
          if (score is num) _quizScores[entry.key.toString()] = score.toInt();
        }
      }

      _sumatifData = await _storage.readSumatif();
      if (_sumatifData?['isCompleted'] == true) {
        _isSumatifDone = true;
        _sumatifSubmission = _sumatifData?['repoLink']?.toString() ?? _sumatifSubmission;
      }
    } catch (e) {
      debugPrint('Gagal memuat progress lokal: $e');
    }

    _isInitialized = true;
    notifyListeners();
  }

  int _asInt(dynamic value) => value is num ? value.toInt() : int.tryParse('$value') ?? 0;

  bool isChapterCompleted(int chapter) => _completedChapterIds.contains(chapter.toString());

  bool isChapterUnlocked(int chapter) => chapter <= 1 || isChapterCompleted(chapter - 1);

  int getCompletedCount() {
    var count = 0;
    for (var i = 1; i <= 13; i++) {
      if (isChapterCompleted(i)) count++;
    }
    return count;
  }

  bool isAllChaptersCompleted() => getCompletedCount() >= 13;

  Future<void> _saveProgress() async {
    await _storage.writeProgress({
      'completedChapterIds': _completedChapterIds.toList(),
      'quizScores': _quizScores,
      'isPreTestDone': _isPreTestDone,
      'preTestScore': _preTestScore,
      'isSumatifDone': _isSumatifDone,
      'sumatifSubmission': _sumatifSubmission,
    });
  }

  Future<void> _syncTeacherSafely() async {
    try {
      await TeacherSyncService().syncProgress(
        completedChapterIds: _completedChapterIds,
        quizScores: _quizScores,
      );
    } catch (e) {
      debugPrint('Sinkronisasi guru dilewati: $e');
    }
  }

  Future<void> markChapterComplete(String chapterId) async {
    final normalized = int.tryParse(chapterId)?.toString() ?? chapterId;
    if (normalized.isEmpty) return;
    _completedChapterIds.add(normalized);
    await _saveProgress();
    notifyListeners();
    await _syncTeacherSafely();
  }

  Future<void> saveQuizScore(String chapterId, int score) async {
    final normalized = int.tryParse(chapterId)?.toString() ?? chapterId;
    _quizScores[normalized] = score;
    await _saveProgress();
    notifyListeners();
    await _syncTeacherSafely();
  }

  Future<void> completePreTest(int score) async {
    _isPreTestDone = true;
    _preTestScore = score;
    await _saveProgress();
    notifyListeners();
    await _syncTeacherSafely();
  }

  Future<void> completeSumatif(String submission) async {
    _isSumatifDone = true;
    _sumatifSubmission = submission;
    await _saveProgress();
    await _storage.writeSumatif({
      'isSumatif': true,
      'isCompleted': true,
      'repoLink': submission,
    });
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getEvaluation({required int chapter}) async {
    final cached = _evaluations[chapter];
    if (cached != null) return Map<String, dynamic>.from(cached);
    final local = await _storage.readEvaluation(chapter);
    if (local != null) _evaluations[chapter] = local;
    return local;
  }

  Future<void> saveEvaluation({
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
      'selectedAnswers': selectedAnswers?.map((k, v) => MapEntry(k.toString(), v)),
      'codingScore': codingScore,
      'codingPassed': codingPassed,
      'codingTotal': codingTotal,
      'codingResult': codingResult,
      'isCompleted': true,
    };
    _evaluations[chapter] = data;
    await _storage.writeEvaluation(chapter, data);
    _completedChapterIds.add(chapter.toString());
    _quizScores[chapter.toString()] = theoryScore;
    await _saveProgress();
    notifyListeners();
    await _syncTeacherSafely();
  }

  Future<Map<String, dynamic>?> getSumatifEvaluation() async {
    _sumatifData ??= await _storage.readSumatif();
    return _sumatifData;
  }

  Future<void> saveSumatifEvaluation({
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
    };
    _sumatifData = data;
    _isSumatifDone = true;
    _sumatifSubmission = repoLink ?? '';
    await _storage.writeSumatif(data);
    await _saveProgress();
    notifyListeners();
    await _syncTeacherSafely();
  }

  double getOverallProgress() => getCompletedCount() / 13.0;

  List<String> getBadges() {
    final badges = <String>[];
    if (_isPreTestDone) badges.add('Starter: Menyelesaikan Pre-Test');
    if (_completedChapterIds.isNotEmpty) badges.add('Pecah Telur: Bab Pertama Selesai');
    if (getCompletedCount() >= 6) badges.add('Pejuang C++: Setengah Jalan');
    if (isAllChaptersCompleted()) badges.add('Master Teori: Semua Bab Selesai');
    if (_isSumatifDone) badges.add('Lulusan CraftC++: Menyelesaikan Sumatif');
    return badges;
  }
}
