import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'evaluation_data.dart';
import 'final_project_page.dart';
import 'coding_evaluation_page.dart';
import 'evaluation_review_page.dart';
import 'evaluation_result_page.dart';
import '../../../providers/user_progress_provider.dart';

class EvaluationPage extends StatefulWidget {
  final int chapter;

  const EvaluationPage({
    super.key,
    required this.chapter,
  });

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  static const Color _primaryColor = Color(0xFF102A43);

  int currentQuestion = 0;
  final Map<int, int> selectedAnswers = {};
  bool submitted = false;
  bool _isLoadingCheck = true;

  int theoryScore = 0;
  int correctAnswers = 0;

  ChapterEvaluation get evaluation {
    return evaluations.firstWhere(
          (item) => item.chapter == widget.chapter,
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final progressProvider = context.read<UserProgressProvider>();
      if (!progressProvider.isChapterUnlocked(widget.chapter)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Bab ${widget.chapter} masih terkunci. Selesaikan Bab ${widget.chapter - 1} terlebih dahulu.',
            ),
            backgroundColor: Colors.amber.shade900,
          ),
        );
        Navigator.pop(context);
        return;
      }

      if (evaluation.finalProject != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FinalProjectPage(
              project: evaluation.finalProject!,
            ),
          ),
        );
        return;
      }

      await _checkExistingEvaluation();
    });
  }

  Future<void> _checkExistingEvaluation() async {
    // Loading singkat sebelum soal ditampilkan.
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      // Progress evaluasi sekarang dibaca dari penyimpanan lokal perangkat.
      final existing = await context
          .read<UserProgressProvider>()
          .getEvaluation(chapter: widget.chapter);

      if (!mounted) return;

      if (existing != null && existing['isCompleted'] == true) {
        final Map<int, int> restoredAnswers = {};
        if (existing['selectedAnswers'] is Map) {
          (existing['selectedAnswers'] as Map).forEach((k, v) {
            final keyInt = int.tryParse(k.toString());
            final valInt = v is int ? v : int.tryParse(v.toString());
            if (keyInt != null && valInt != null) {
              restoredAnswers[keyInt] = valInt;
            }
          });
        }

        Map<String, dynamic>? codingResult;
        if (existing['codingResult'] is Map) {
          codingResult = Map<String, dynamic>.from(existing['codingResult'] as Map);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EvaluationResultPage(
              evaluation: evaluation,
              theoryScore: (existing['theoryScore'] as num?)?.toInt() ?? 0,
              correctAnswers: (existing['correctAnswers'] as num?)?.toInt() ?? 0,
              totalQuestions: (existing['totalQuestions'] as num?)?.toInt() ??
                  evaluation.multipleChoiceQuestions.length,
              codingScore: (existing['codingScore'] as num?)?.toInt(),
              codingPassed: (existing['codingPassed'] as num?)?.toInt(),
              codingTotal: (existing['codingTotal'] as num?)?.toInt(),
              codingResult: codingResult,
              selectedAnswers: restoredAnswers,
            ),
          ),
        );
        return;
      }
    } on TimeoutException {
      // Firebase terlalu lama merespons. Tetap tampilkan soal agar pengguna
      // bisa langsung mengerjakan evaluasi.
      debugPrint('Pengecekan evaluasi timeout, lanjut menampilkan soal.');
    } catch (e) {
      // Jika pengecekan gagal, jangan menghalangi pengguna mengerjakan soal.
      debugPrint('Error checking existing evaluation: $e');
    }

    if (mounted) {
      setState(() {
        _isLoadingCheck = false;
      });
    }
  }

  void _selectAnswer(int answer) {
    if (submitted) return;

    setState(() {
      selectedAnswers[currentQuestion] = answer;
    });
  }

  void _nextQuestion() {
    if (!selectedAnswers.containsKey(currentQuestion)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih jawaban terlebih dahulu.'),
        ),
      );
      return;
    }

    if (currentQuestion < evaluation.multipleChoiceQuestions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      _showSubmitDialog();
    }
  }

  void _previousQuestion() {
    if (currentQuestion > 0) {
      setState(() {
        currentQuestion--;
      });
    }
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Selesaikan Evaluasi?'),
          content: const Text(
            'Pastikan semua jawaban sudah diperiksa sebelum mengumpulkan evaluasi.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _submitEvaluation();
              },
              child: const Text('Kumpulkan'),
            ),
          ],
        );
      },
    );
  }

  void _submitEvaluation() {
    int correct = 0;

    for (int i = 0; i < evaluation.multipleChoiceQuestions.length; i++) {
      final selectedAnswer = selectedAnswers[i];
      final correctAnswer = evaluation.multipleChoiceQuestions[i].correctAnswer;

      if (selectedAnswer == correctAnswer) {
        correct++;
      }
    }

    final total = evaluation.multipleChoiceQuestions.length;
    final score = total == 0 ? 0 : ((correct / total) * 100).round();

    setState(() {
      submitted = true;
      correctAnswers = correct;
      theoryScore = score;
    });

    _showResultDialog(correct);
  }

  void _showResultDialog(int correct) {
    final total = evaluation.multipleChoiceQuestions.length;
    final wrong = total - correct;
    final score = total == 0 ? 0 : ((correct / total) * 100).round();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hasil Tes Pemahaman'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.assessment,
                size: 60,
                color: _primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Nilai $score',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _resultItem(
                    icon: Icons.check_circle,
                    label: 'Benar',
                    value: '$correct',
                    iconColor: Colors.green,
                  ),
                  _resultItem(
                    icon: Icons.cancel,
                    label: 'Salah',
                    value: '$wrong',
                    iconColor: Colors.red,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EvaluationReviewPage(
                        evaluation: evaluation,
                        selectedAnswers: Map.from(selectedAnswers),
                      ),
                    ),
                  );
                },
                child: const Text('Lihat Pembahasan'),
              ),
            ),
            if (evaluation.codingQuestion != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    _openCodingEvaluation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Lanjut ke Coding'),
                ),
              ),
            if (evaluation.codingQuestion == null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    _showTheoryOnlyResult();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Lihat Hasil Evaluasi'),
                ),
              ),
          ],
        );
      },
    );
  }

  Future _showTheoryOnlyResult() async {
    if (!mounted) return;

    final progressProvider = context.read<UserProgressProvider>();
    await progressProvider.saveEvaluation(
      chapter: widget.chapter,
      theoryScore: theoryScore,
      correctAnswers: correctAnswers,
      totalQuestions: evaluation.multipleChoiceQuestions.length,
      selectedAnswers: selectedAnswers,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EvaluationResultPage(
          evaluation: evaluation,
          theoryScore: theoryScore,
          correctAnswers: correctAnswers,
          totalQuestions: evaluation.multipleChoiceQuestions.length,
          codingScore: null,
          codingPassed: null,
          codingTotal: null,
          selectedAnswers: Map.from(selectedAnswers),
        ),
      ),
    );
  }

  void _openCodingEvaluation() {
    final codingQuestion = evaluation.codingQuestion;
    if (codingQuestion == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CodingEvaluationPage(
          codingQuestion: codingQuestion,
          chapter: widget.chapter,
          theoryScore: theoryScore,
          correctAnswers: correctAnswers,
          totalQuestions: evaluation.multipleChoiceQuestions.length,
          selectedAnswers: Map.from(selectedAnswers),
        ),
      ),
    );
  }

  Widget _resultItem({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 30,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingCheck) {
      return Scaffold(
        backgroundColor: const Color(0xFF0B0F19),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/loading screan.jpeg',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.menu_book_rounded,
                    size: 90,
                    color: Color(0xFF6C4CF1),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Menyiapkan Evaluasi...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Mohon tunggu, evaluasi sedang dimuat.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(
                width: 180,
                child: LinearProgressIndicator(
                  minHeight: 6,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (evaluation.multipleChoiceQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Evaluasi Bab ${widget.chapter}'),
        ),
        body: const Center(
          child: Text('Belum ada soal evaluasi.'),
        ),
      );
    }

    final question = evaluation.multipleChoiceQuestions[currentQuestion];
    final selectedAnswer = selectedAnswers[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluasi Bab ${widget.chapter}'),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Soal ${currentQuestion + 1} dari ${evaluation.multipleChoiceQuestions.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: (currentQuestion + 1) / evaluation.multipleChoiceQuestions.length,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: List.generate(
                      question.options.length,
                          (index) {
                        final isSelected = selectedAnswer == index;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? _primaryColor
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: RadioListTile<int>(
                            value: index,
                            groupValue: selectedAnswer,
                            onChanged: submitted
                                ? null
                                : (value) {
                              if (value != null) {
                                _selectAnswer(value);
                              }
                            },
                            title: Text(
                              '${String.fromCharCode(65 + index)}. ${question.options[index]}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (currentQuestion > 0) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: submitted ? null : _previousQuestion,
                      child: const Text('Sebelumnya'),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: ElevatedButton(
                    onPressed: submitted ? null : _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      currentQuestion == evaluation.multipleChoiceQuestions.length - 1
                          ? 'Selesai'
                          : 'Berikutnya',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
