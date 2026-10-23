import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task.dart';
import '../../../providers/user_progress_provider.dart';

class TaskPage extends StatefulWidget {
  final String chapterId;
  final List<Task> tasks;

  const TaskPage({super.key, required this.chapterId, required this.tasks});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final Map<int, int?> _answers = {};
  final Map<int, String> _practiceSubmissions = {};
  bool _isFinished = false;

  Future<void> _nextPage() async {
    if (_currentIndex < widget.tasks.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      int score = 0;
      for (int i = 0; i < widget.tasks.length; i++) {
        final task = widget.tasks[i];
        if (task is QuizTask) {
          if (_answers[i] == task.correctIndex) {
            score++;
          }
        }
      }
      
      // Update provider progress
      final progressProvider = context.read<UserProgressProvider>();
      // Simpan progress ke Firestore dan tunggu sampai benar-benar selesai.
      // Jadi Bab berikutnya bisa langsung terbuka tanpa harus keluar halaman.
      await progressProvider.markChapterComplete(widget.chapterId);
      await progressProvider.saveQuizScore(widget.chapterId, score);

      if (!mounted) return;
      setState(() {
        _isFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return _buildResultPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas - Step ${_currentIndex + 1}/${widget.tasks.length}'),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          final task = widget.tasks[index];
          if (task is QuizTask) {
            return _buildQuizStep(task, index);
          } else if (task is PracticeTask) {
            return _buildPracticeStep(task, index);
          }
          return const Center(child: Text('Unknown Task Type'));
        },
      ),
    );
  }

  Widget _buildQuizStep(QuizTask task, int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: task.options.length,
              itemBuilder: (context, optIndex) {
                return RadioListTile<int>(
                  title: Text(task.options[optIndex]),
                  value: optIndex,
                  groupValue: _answers[index],
                  onChanged: (value) {
                    setState(() {
                      _answers[index] = value;
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: _answers[index] != null ? _nextPage : null,
              child: Text(_currentIndex == widget.tasks.length - 1 ? 'Selesai' : 'Lanjut'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeStep(PracticeTask task, int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.description,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Ketik kode C++ Anda di sini:'),
          const SizedBox(height: 8),
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '// Tulis kode di sini...',
              ),
              onChanged: (value) {
                _practiceSubmissions[index] = value;
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                _nextPage();
              },
              child: const Text('Jalankan & Selesai'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultPage() {
    int score = 0;
    int totalQuiz = 0;

    for (int i = 0; i < widget.tasks.length; i++) {
      final task = widget.tasks[i];
      if (task is QuizTask) {
        totalQuiz++;
        if (_answers[i] == task.correctIndex) {
          score++;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Evaluasi')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              const Text(
                'Selamat!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Anda telah menyelesaikan tugas ini.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              if (totalQuiz > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Skor Quiz: $score / $totalQuiz',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali ke Materi'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
