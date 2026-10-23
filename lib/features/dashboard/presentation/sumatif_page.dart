import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../coding_space/presentation/evaluation_data.dart';
import '../../../providers/user_progress_provider.dart';

class SumatifPage extends StatefulWidget {
  const SumatifPage({super.key});

  @override
  State<SumatifPage> createState() => _SumatifPageState();
}

class _SumatifPageState extends State<SumatifPage> {
  late final List<MultipleChoiceQuestion> questions;
  final Map<int, int> answers = {};
  int current = 0;
  bool submitted = false;
  bool saving = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    questions = [
      for (int chapter = 1; chapter <= 13; chapter++)
        evaluations.firstWhere((e) => e.chapter == chapter).multipleChoiceQuestions.first,
    ];
  }

  void _next() {
    if (!answers.containsKey(current)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih jawaban terlebih dahulu.')));
      return;
    }
    if (current < questions.length - 1) {
      setState(() => current++);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i].correctAnswer) correct++;
    }
    final finalScore = ((correct / questions.length) * 100).round();
    setState(() { saving = true; score = finalScore; });

    try {
      await context.read<UserProgressProvider>().saveSumatifEvaluation(
        theoryScore: finalScore,
        correctAnswers: correct,
        totalQuestions: questions.length,
        selectedAnswers: answers,
      );
    } catch (e) {
      debugPrint('Gagal menyimpan evaluasi semester secara lokal: $e');
    }

    if (!mounted) return;
    setState(() { saving = false; submitted = true; });
  }

  @override
  Widget build(BuildContext context) {
    if (submitted) {
      return Scaffold(
        backgroundColor: const Color(0xFF0B0F19),
        appBar: AppBar(title: const Text('Hasil Evaluasi 1 Semester')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.verified_rounded, color: Colors.greenAccent, size: 90),
                const SizedBox(height: 20),
                const Text('Evaluasi Semester Selesai', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text('Nilai Akhir: $score', style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Materi yang diujikan mencakup Bab 1 sampai Bab 13.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF94A3B8))),
                const SizedBox(height: 28),
                SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Kembali'))),
              ],
            ),
          ),
        ),
      );
    }

    final q = questions[current];
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        title: const Text('Evaluasi 1 Semester'),
        backgroundColor: const Color(0xFF0B0F19),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Soal ${current + 1} dari ${questions.length}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              LinearProgressIndicator(value: (current + 1) / questions.length, minHeight: 8),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF161F30), borderRadius: BorderRadius.circular(12)),
                  child: Text('Materi Bab ${current + 1}', style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 18),
                Text(q.question, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold, height: 1.5)),
                const SizedBox(height: 22),
                ...List.generate(q.options.length, (i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(color: const Color(0xFF161F30), borderRadius: BorderRadius.circular(14), border: Border.all(color: answers[current] == i ? const Color(0xFF6C4CF1) : Colors.white10, width: answers[current] == i ? 2 : 1)),
                    child: RadioListTile<int>(
                      value: i,
                      groupValue: answers[current],
                      onChanged: saving ? null : (v) => setState(() => answers[current] = v!),
                      title: Text('${String.fromCharCode(65 + i)}. ${q.options[i]}', style: const TextStyle(color: Colors.white)),
                    ),
                  );
                }),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: SizedBox(width: double.infinity, height: 52, child: ElevatedButton(onPressed: saving ? null : _next, child: saving ? const CircularProgressIndicator(color: Colors.white) : Text(current == questions.length - 1 ? 'Selesai & Simpan' : 'Lanjut'))),
          ),
        ],
      ),
    );
  }
}
