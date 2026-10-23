import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_progress_provider.dart';

class PreTestPage extends StatefulWidget {
  const PreTestPage({super.key});

  @override
  State<PreTestPage> createState() => _PreTestPageState();
}

class _PreTestPageState extends State<PreTestPage> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _isFinished = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': '1. Apa kepanjangan dari IDE dalam pemrograman?',
      'options': [
        'Integrated Development Environment',
        'Internal Data Element',
        'International Design Engine',
        'Interface Device Equipment'
      ],
      'correct': 0
    },
    {
      'question': '2. Tipe data apa yang digunakan untuk menyimpan nilai kebenaran (true/false)?',
      'options': ['int', 'float', 'char', 'bool'],
      'correct': 3
    },
    {
      'question': '3. Karakter apa yang digunakan untuk mengakhiri pernyataan di C++?',
      'options': ['.', ':', ';', ','],
      'correct': 2
    },
    {
      'question': '4. Operator manakah yang digunakan untuk membandingkan kesamaan dua nilai?',
      'options': ['=', '==', '===', '!='],
      'correct': 1
    },
    {
      'question': '5. Sintaks mana yang benar untuk mencetak teks di C++?',
      'options': ['print("Hello");', 'echo "Hello";', 'std::cout << "Hello";', 'System.out.print("Hello");'],
      'correct': 2
    },
    {
      'question': '6. Struktur kontrol apa yang digunakan untuk percabangan?',
      'options': ['for', 'while', 'if-else', 'switch-case saja'],
      'correct': 2
    },
    {
      'question': '7. Indeks array pertama pada mayoritas bahasa pemrograman dimulai dari angka...',
      'options': ['-1', '0', '1', 'Bebas'],
      'correct': 1
    },
    {
      'question': '8. Keyword apa yang digunakan untuk mengembalikan nilai dari fungsi?',
      'options': ['back', 'give', 'exit', 'return'],
      'correct': 3
    },
    {
      'question': '9. Library standar C++ manakah yang digunakan untuk fungsi input/output?',
      'options': ['<iostream>', '<cmath>', '<string>', '<vector>'],
      'correct': 0
    },
    {
      'question': '10. Apa output dari 10 % 3 dalam pemrograman?',
      'options': ['3', '1', '0', '3.33'],
      'correct': 1
    },
  ];

  void _nextQuestion() {
    if (_selectedAnswerIndex == _questions[_currentIndex]['correct']) {
      _score++;
    }

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswerIndex = null;
      });
    } else {
      setState(() {
        _isFinished = true;
      });
      // Save progress to provider
      context.read<UserProgressProvider>().completePreTest(_score);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return Scaffold(
        appBar: AppBar(title: const Text('Hasil Pre-Test')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.assignment_turned_in, color: Colors.deepPurple, size: 80),
                const SizedBox(height: 20),
                const Text(
                  'Pre-Test Selesai!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Skor Anda: $_score / ${_questions.length}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  _score >= 7
                      ? 'Luar biasa! Anda memiliki dasar yang kuat.'
                      : 'Bagus! Mari tingkatkan kemampuan coding Anda bersama CraftC++.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kembali ke Dashboard'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final currentQ = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pre-Test (${_currentIndex + 1}/${_questions.length})'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _questions.length,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            const SizedBox(height: 24),
            Text(
              currentQ['question'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: currentQ['options'].length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: _selectedAnswerIndex == index ? 4 : 1,
                    color: _selectedAnswerIndex == index
                        ? Colors.deepPurple.withOpacity(0.1)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: _selectedAnswerIndex == index
                            ? Colors.deepPurple
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: RadioListTile<int>(
                      title: Text(currentQ['options'][index]),
                      value: index,
                      groupValue: _selectedAnswerIndex,
                      activeColor: Colors.deepPurple,
                      onChanged: (val) {
                        setState(() {
                          _selectedAnswerIndex = val;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                onPressed: _selectedAnswerIndex != null ? _nextQuestion : null,
                child: Text(_currentIndex == _questions.length - 1 ? 'Selesai' : 'Lanjut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
