import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'compiler_service.dart';
import 'evaluation_data.dart';
import 'evaluation_result_page.dart';
import '../../../providers/user_progress_provider.dart';

class CodingEvaluationPage extends StatefulWidget {
  final CodingQuestion codingQuestion;
  final int chapter;

  // Nilai dari Tes Pemahaman
  final int theoryScore;
  final int correctAnswers;
  final int totalQuestions;
  final Map<int, int> selectedAnswers;

  const CodingEvaluationPage({
    super.key,
    required this.codingQuestion,
    required this.chapter,
    required this.theoryScore,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.selectedAnswers,
  });

  @override
  State<CodingEvaluationPage> createState() =>
      _CodingEvaluationPageState();
}

class _CodingEvaluationPageState extends State<CodingEvaluationPage> {
  late TextEditingController _codeController;
  late TextEditingController _inputController;

  bool _isRunning = false;

  Map<String, dynamic>? _evaluationResult;

  @override
  void initState() {
    super.initState();

    _codeController = TextEditingController(
      text: widget.codingQuestion.starterCode ?? '',
    );

    _inputController = TextEditingController(
      text: widget.codingQuestion.testCases.isNotEmpty
          ? widget.codingQuestion.testCases.first.input
          : '',
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _inputController.dispose();

    super.dispose();
  }

  Future<void> _runEvaluation() async {
    if (_isRunning) return;

    if (_codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Kode C++ belum diisi.',
          ),
        ),
      );

      return;
    }

    setState(() {
      _isRunning = true;
      _evaluationResult = null;
    });

    try {
      final result = await CompilerService().evaluateCpp(
        sourceCode: _codeController.text,
        testCases: widget.codingQuestion.testCases,
      );

      if (!mounted) return;

      setState(() {
        _evaluationResult = result;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Terjadi kesalahan: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isRunning = false;
        });
      }
    }
  }

  void _showCodingAnalysis(Map<String, dynamic> result) {
    final results = (result['results'] as List?) ?? [];

    final failedResults = results
        .where(
          (item) => item is Map && item['passed'] == false,
    )
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (
              context,
              scrollController,
              ) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Analisis Coding',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.codingQuestion.concept,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Test Case yang Belum Berhasil',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (failedResults.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Semua test case berhasil.',
                      ),
                    ),
                  ...failedResults.map(
                        (item) {
                      final data = Map<String, dynamic>.from(
                        item as Map,
                      );

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Test Case ${data['testCase']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _detailBox(
                              'Input',
                              data['input'].toString(),
                            ),
                            const SizedBox(height: 8),
                            _detailBox(
                              'Output yang Diharapkan',
                              data['expected'].toString(),
                            ),
                            const SizedBox(height: 8),
                            _detailBox(
                              'Output Program',
                              data['actual']?.toString().isEmpty == true
                                  ? '(tidak ada output)'
                                  : data['actual'].toString(),
                            ),
                            if (data['status'] != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                'Status: ${data['status']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            if (data['stderr']?.toString().isNotEmpty ==
                                true) ...[
                              const SizedBox(height: 8),
                              _detailBox(
                                'Error',
                                data['stderr'].toString(),
                              ),
                            ],
                            if (data['compileOutput']
                                ?.toString()
                                .isNotEmpty ==
                                true) ...[
                              const SizedBox(height: 8),
                              _detailBox(
                                'Compile Error',
                                data['compileOutput'].toString(),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Konsep yang Perlu Digunakan',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...widget.codingQuestion.expectedConcepts.map(
                        (concept) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 20,
                            color: Color(0xFF102A43),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(concept),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Penjelasan Penyelesaian',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.codingQuestion.solutionExplanation,
                    style: const TextStyle(
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Contoh Solusi',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SelectableText(
                      widget.codingQuestion.solutionCode,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF102A43),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Tutup Analisis',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _detailBox(
      String title,
      String value,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
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
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showFinalResult() async {
    if (_evaluationResult == null) return;

    final codingScore = (_evaluationResult!['score'] ?? 0) as int;
    final codingPassed = (_evaluationResult!['passed'] ?? 0) as int;
    final codingTotal = (_evaluationResult!['total'] ?? 0) as int;

    if (!mounted) return;

    final progressProvider = context.read<UserProgressProvider>();
    await progressProvider.saveEvaluation(
      chapter: widget.chapter,
      theoryScore: widget.theoryScore,
      correctAnswers: widget.correctAnswers,
      totalQuestions: widget.totalQuestions,
      selectedAnswers: widget.selectedAnswers,
      codingScore: codingScore,
      codingPassed: codingPassed,
      codingTotal: codingTotal,
      codingResult: _evaluationResult,
    );

    final evaluation = evaluations.firstWhere(
          (item) => item.chapter == widget.chapter,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EvaluationResultPage(
          evaluation: evaluation,
          theoryScore: widget.theoryScore,
          correctAnswers: widget.correctAnswers,
          totalQuestions: widget.totalQuestions,
          codingScore: codingScore,
          codingPassed: codingPassed,
          codingTotal: codingTotal,
          codingResult: _evaluationResult,
          selectedAnswers: widget.selectedAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.codingQuestion;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tes Praktik Coding - Bab ${widget.chapter}',
        ),
        backgroundColor: const Color(0xFF102A43),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.school,
                          color: Color(0xFF102A43),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Nilai Tes Pemahaman: ${widget.theoryScore}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tugas Coding',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Kode C++',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xFF101820),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _codeController,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Tulis kode C++ di sini...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Contoh Input',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SelectableText(
                      question.testCases.isNotEmpty
                          ? question.testCases.first.input
                          : 'Tidak ada input',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_evaluationResult != null)
                    _buildEvaluationResult(),
                  const SizedBox(height: 20),
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
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isRunning ? null : _runEvaluation,
                icon: _isRunning
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(
                  Icons.play_arrow,
                ),
                label: Text(
                  _isRunning
                      ? 'Menjalankan...'
                      : 'Jalankan & Evaluasi',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF102A43),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvaluationResult() {
    final result = _evaluationResult!;

    final passed = (result['passed'] ?? 0) as int;
    final total = (result['total'] ?? 0) as int;
    final score = (result['score'] ?? 0) as int;

    final results = (result['results'] as List?) ?? [];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hasil Tes Praktik',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _resultCard(
                  title: 'Test Case',
                  value: '$passed/$total',
                  icon: Icons.check_circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _resultCard(
                  title: 'Nilai Coding',
                  value: '$score',
                  icon: Icons.code,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Detail Test Case',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...results.map(
                (item) {
              final data = Map<String, dynamic>.from(
                item as Map,
              );

              final isPassed = data['passed'] == true;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isPassed
                      ? Colors.green.withValues(alpha: 0.06)
                      : Colors.red.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPassed
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: isPassed
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Test Case ${data['testCase']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isPassed ? 'PASS' : 'FAIL',
                            style: TextStyle(
                              color: isPassed
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          if (passed < total)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showCodingAnalysis(result);
                },
                icon: const Icon(
                  Icons.analytics_outlined,
                ),
                label: const Text(
                  'Lihat Analisis Coding',
                ),
              ),
            ),
          if (passed == total)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.verified,
                    color: Colors.green,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Semua test case berhasil. Program kamu menghasilkan output yang sesuai.',
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _showFinalResult,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF102A43),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Lihat Hasil Evaluasi Bab',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resultCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF102A43),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
