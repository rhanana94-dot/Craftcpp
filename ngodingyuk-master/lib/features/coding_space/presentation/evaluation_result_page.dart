import 'package:flutter/material.dart';

import 'evaluation_data.dart';
import 'evaluation_review_page.dart';

class EvaluationResultPage extends StatelessWidget {
  final ChapterEvaluation evaluation;

  final int theoryScore;
  final int correctAnswers;
  final int totalQuestions;

  final int? codingScore;
  final int? codingPassed;
  final int? codingTotal;

  final Map<String, dynamic>? codingResult;

  final Map<int, int> selectedAnswers;

  const EvaluationResultPage({
    super.key,
    required this.evaluation,
    required this.theoryScore,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.selectedAnswers,
    this.codingScore,
    this.codingPassed,
    this.codingTotal,
    this.codingResult,
  });

  bool get hasCoding => evaluation.codingQuestion != null;

  int get finalScore {
    if (!hasCoding || codingScore == null) {
      return theoryScore;
    }

    return ((theoryScore + codingScore!) / 2).round();
  }

  String get finalFeedback {
    if (finalScore >= 80) {
      return 'Pemahaman materi dan kemampuan praktik kamu sudah sangat baik! '
          'Tetap pertahankan dan lanjut pelajari bab berikutnya.';
    }

    if (finalScore >= 60) {
      return 'Sebagian besar konsep sudah dipahami dengan baik. '
          'Coba periksa kembali pembahasan soal dan analisis coding untuk memperbaiki kesalahan.';
    }

    return 'Masih ada beberapa konsep yang perlu dipelajari kembali. '
        'Gunakan fitur pembahasan dan analisis coding sebagai panduan belajar.';
  }

  List<String> get recommendations {
    final result = <String>[];

    if (theoryScore < 80) {
      result.add(
        'Pelajari kembali materi yang berkaitan dengan soal pilihan ganda yang masih salah.',
      );
    }

    if (hasCoding && codingScore != null && codingScore! < 80) {
      result.add(
        'Latih kembali konsep ${evaluation.codingQuestion!.concept}.',
      );
    }

    if (hasCoding &&
        codingPassed != null &&
        codingTotal != null &&
        codingPassed! < codingTotal!) {
      result.add(
        'Periksa kembali test case coding yang belum berhasil.',
      );
    }

    if (result.isEmpty) {
      result.add(
        'Kamu siap melanjutkan ke materi bab berikutnya!',
      );
    }

    return result;
  }

  void _openReview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EvaluationReviewPage(
          evaluation: evaluation,
          selectedAnswers: selectedAnswers,
        ),
      ),
    );
  }

  void _showCodingSummary(BuildContext context) {
    if (!hasCoding) return;

    final results =
        (codingResult?['results'] as List?)?.cast<Map<String, dynamic>>() ??
            [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161F30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Analisis Tes Praktik Coding',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _infoCard(
                        icon: Icons.code,
                        title: 'Nilai Coding',
                        value: '${codingScore ?? 0}',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _infoCard(
                        icon: Icons.check_circle,
                        title: 'Berhasil',
                        value: '${codingPassed ?? 0}/${codingTotal ?? 0}',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  'Hasil Test Case',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                if (results.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B0F19),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Detail test case belum tersedia.',
                      style: TextStyle(color: Color(0xFF94A3B8)),
                    ),
                  )
                else
                  ...results.map(
                    (result) => _buildTestCaseCard(result),
                  ),

                const SizedBox(height: 24),

                const Text(
                  'Konsep yang Dinilai',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  evaluation.codingQuestion!.concept,
                  style: const TextStyle(
                    height: 1.5,
                    color: Color(0xFFE2E8F0),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Konsep yang Diharapkan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                ...evaluation.codingQuestion!.expectedConcepts.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: Color(0xFF00E5FF),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Penjelasan Penyelesaian',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  evaluation.codingQuestion!.solutionExplanation,
                  style: const TextStyle(
                    height: 1.5,
                    color: Color(0xFFE2E8F0),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Contoh Solusi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B0F19),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: SelectableText(
                    evaluation.codingQuestion!.solutionCode,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      height: 1.5,
                      color: Color(0xFF00E5FF),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C4CF1),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Tutup'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestCaseCard(Map<String, dynamic> result) {
    final passed = result['passed'] == true;
    final testCase = result['testCase']?.toString() ?? '-';
    final input = result['input']?.toString() ?? '';
    final expected = result['expected']?.toString() ?? '';
    final actual = result['actual']?.toString() ?? '';
    final status = result['status']?.toString() ?? 'Unknown';
    final stderr = result['stderr']?.toString() ?? '';
    final compileOutput = result['compileOutput']?.toString() ?? '';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: passed
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: passed
              ? Colors.green.withValues(alpha: 0.3)
              : Colors.red.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                passed ? Icons.check_circle : Icons.cancel,
                color: passed ? Colors.greenAccent : Colors.redAccent,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Test Case $testCase',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                passed ? 'PASS' : 'FAIL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: passed ? Colors.greenAccent : Colors.redAccent,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          _resultBlock(
            'Input',
            input.isEmpty ? '(tidak ada input)' : input,
          ),

          const SizedBox(height: 10),

          _resultBlock(
            'Expected Output',
            expected,
          ),

          const SizedBox(height: 10),

          _resultBlock(
            'Actual Output',
            actual.isEmpty ? '(tidak ada output)' : actual,
          ),

          const SizedBox(height: 10),

          _resultBlock(
            'Status',
            status,
          ),

          if (stderr.isNotEmpty) ...[
            const SizedBox(height: 10),
            _resultBlock(
              'Error Output',
              stderr,
              error: true,
            ),
          ],

          if (compileOutput.isNotEmpty) ...[
            const SizedBox(height: 10),
            _resultBlock(
              'Compile Output',
              compileOutput,
              error: true,
            ),
          ],

          if (!passed) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Test case ini belum berhasil. '
                      'Bandingkan Expected Output dengan Actual Output '
                      'untuk melihat bagian kode C++ yang perlu diperbaiki.',
                      style: TextStyle(
                        height: 1.4,
                        color: Color(0xFFE2E8F0),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _resultBlock(
    String title,
    String value, {
    bool error = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: error
            ? Colors.red.withValues(alpha: 0.15)
            : const Color(0xFF0B0F19),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: error
              ? Colors.red.withValues(alpha: 0.3)
              : Colors.white12,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: error ? Colors.redAccent : const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 6),
          SelectableText(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161F30),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: const Color(0xFF00E5FF),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int percentCorrect = totalQuestions == 0
        ? 0
        : ((correctAnswers / totalQuestions) * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        title: Text(
          'Hasil Evaluasi Bab ${evaluation.chapter}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0B0F19),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Keluar',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C4CF1), Color(0xFF4A2EC5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C4CF1).withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    size: 56,
                    color: Colors.amberAccent,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Nilai Akhir Evaluasi',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$finalScore',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bab ${evaluation.chapter} • ${evaluation.title}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xE6FFFFFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Ringkasan Nilai',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    icon: Icons.menu_book,
                    title: 'Tes Pemahaman',
                    value: '$theoryScore',
                  ),
                ),
                if (hasCoding) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: _infoCard(
                      icon: Icons.code,
                      title: 'Tes Coding',
                      value: '${codingScore ?? 0}',
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Pembahasan & Analisis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  _openReview(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00E5FF),
                  side: const BorderSide(color: Color(0xFF00E5FF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.menu_book_outlined),
                label: const Text(
                  'Lihat Pembahasan Tes Pemahaman',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            if (hasCoding) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showCodingSummary(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF00E5FF),
                    side: const BorderSide(color: Color(0xFF00E5FF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.analytics_outlined),
                  label: const Text(
                    'Lihat Analisis Tes Coding',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            const Text(
              'Feedback Pembelajaran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF161F30),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Text(
                finalFeedback,
                style: const TextStyle(
                  height: 1.5,
                  color: Color(0xFFE2E8F0),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Rekomendasi Belajar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            ...recommendations.map(
              (item) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF161F30),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      size: 22,
                      color: Color(0xFF00E5FF),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          height: 1.4,
                          color: Color(0xFFE2E8F0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Statistik Tes Pemahaman',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    'Benar',
                    '$correctAnswers',
                    Colors.greenAccent,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    'Salah',
                    '${totalQuestions - correctAnswers}',
                    Colors.redAccent,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    'Akurasi',
                    '$percentCorrect%',
                    const Color(0xFF00E5FF),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Prominent Exit Button ("Keluar")
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text(
                  'Keluar ke Daftar Materi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C4CF1),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF161F30),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
