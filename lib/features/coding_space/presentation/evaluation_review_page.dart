import 'package:flutter/material.dart';

import 'evaluation_data.dart';

class EvaluationReviewPage extends StatelessWidget {
  final ChapterEvaluation evaluation;
  final Map<int, int> selectedAnswers;

  const EvaluationReviewPage({
    super.key,
    required this.evaluation,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        title: const Text(
          'Pembahasan Evaluasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0B0F19),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: evaluation.multipleChoiceQuestions.length,
              itemBuilder: (context, index) {
                final question = evaluation.multipleChoiceQuestions[index];
                final selectedAnswer = selectedAnswers[index];
                final isCorrect = selectedAnswer == question.correctAnswer;

                return _QuestionReviewCard(
                  number: index + 1,
                  question: question,
                  selectedAnswer: selectedAnswer,
                  isCorrect: isCorrect,
                );
              },
            ),
          ),

          // Bottom Exit Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF161F30),
              border: Border(top: BorderSide(color: Colors.white10)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text(
                  'Keluar ke Hasil Evaluasi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C4CF1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionReviewCard extends StatelessWidget {
  final int number;
  final MultipleChoiceQuestion question;
  final int? selectedAnswer;
  final bool isCorrect;

  const _QuestionReviewCard({
    required this.number,
    required this.question,
    required this.selectedAnswer,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      color: const Color(0xFF161F30),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isCorrect
              ? Colors.green.withValues(alpha: 0.3)
              : Colors.red.withValues(alpha: 0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? Colors.green.withValues(alpha: 0.2)
                        : Colors.red.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCorrect ? Icons.check : Icons.close,
                    color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Soal $number',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  isCorrect ? 'BENAR' : 'SALAH',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // PERTANYAAN
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            // JAWABAN SISWA
            _AnswerBox(
              title: 'Jawaban kamu',
              text: selectedAnswer == null
                  ? 'Tidak dijawab'
                  : '${String.fromCharCode(65 + selectedAnswer!)}. '
                      '${question.options[selectedAnswer!]}',
              color: isCorrect ? Colors.greenAccent : Colors.redAccent,
              icon: isCorrect ? Icons.check_circle : Icons.cancel,
            ),

            const SizedBox(height: 10),

            // JAWABAN BENAR
            _AnswerBox(
              title: 'Jawaban benar',
              text:
                  '${String.fromCharCode(65 + question.correctAnswer)}. '
                  '${question.options[question.correctAnswer]}',
              color: const Color(0xFF00E5FF),
              icon: Icons.check_circle,
            ),

            const SizedBox(height: 20),

            // PEMBAHASAN
            const Text(
              'Pembahasan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              question.explanation,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFFE2E8F0),
              ),
            ),

            const SizedBox(height: 20),

            // PENJELASAN SETIAP PILIHAN
            const Text(
              'Penjelasan Pilihan Jawaban',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            ...List.generate(
              question.options.length,
              (optionIndex) {
                final optionIsCorrect =
                    optionIndex == question.correctAnswer;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: optionIsCorrect
                        ? Colors.green.withValues(alpha: 0.1)
                        : const Color(0xFF0B0F19),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: optionIsCorrect
                          ? Colors.green.withValues(alpha: 0.4)
                          : Colors.white12,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            optionIsCorrect
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            size: 18,
                            color: optionIsCorrect
                                ? Colors.greenAccent
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${String.fromCharCode(65 + optionIndex)}. '
                              '${question.options[optionIndex]}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: optionIsCorrect
                                    ? Colors.greenAccent
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        question.optionExplanations[optionIndex],
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            // KONSEP
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B0F19),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: Color(0xFF00E5FF),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Konsep: ${question.concept}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}

class _AnswerBox extends StatelessWidget {
  final String title;
  final String text;
  final Color color;
  final IconData icon;

  const _AnswerBox({
    required this.title,
    required this.text,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.white,
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
