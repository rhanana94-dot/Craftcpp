import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../core/data/sample_materi.dart';
import '../../../providers/user_progress_provider.dart';
import 'sumatif_page.dart';
import '../../materi/presentation/chapter_detail_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const int totalChapters = 13;

  static const List<String> chapterTitles = [
    'Pengenalan Bahasa Pemrograman C++',
    'Struktur Dasar Program C++ yang Harus Dipahami',
    'Fungsi Input dan Output',
    'Variabel, Konstanta, dan Tipe Data',
    'Operator',
    'Percabangan',
    'Perulangan',
    'Struktur Data Array',
    'Prosedur dan Fungsi',
    'Tipe Data Enum',
    'Tipe Data Structure',
    'Tipe Data Union',
    'Ujian Akhir Bab 13',
  ];

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<UserProgressProvider>();

    final completedChapters = <int>{};
    for (int chapter = 1; chapter <= totalChapters; chapter++) {
      if (progressProvider.isChapterCompleted(chapter)) {
        completedChapters.add(chapter);
      }
    }

    final completedCount = completedChapters.length;
    final progress = completedCount / totalChapters;
    final progressPercent = (progress * 100).round();
    final lockedCount = totalChapters - completedCount;

    return Scaffold(
      backgroundColor: const Color(0xFF070B16),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 28),
              _buildSummary(
                completedCount: completedCount,
                progress: progress,
                progressPercent: progressPercent,
                lockedCount: lockedCount,
              ),
              const SizedBox(height: 32),
              const Text(
                'Daftar Bab Pembelajaran',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
              ),
              const SizedBox(height: 16),
              ...List.generate(totalChapters, (index) {
                final chapter = index + 1;
                final isCompleted = completedChapters.contains(chapter);
                final isUnlocked = chapter == 1 || isCompleted || completedChapters.contains(chapter - 1);

                return _buildChapterCard(
                  context: context,
                  chapter: chapter,
                  title: chapterTitles[index],
                  isCompleted: isCompleted,
                  isUnlocked: isUnlocked,
                  score: progressProvider.quizScores[chapter.toString()] ?? 0,
                );
              }),
              if (progressProvider.isChapterCompleted(13)) ...[
                const SizedBox(height: 16),
                _buildSemesterEvaluationCard(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSemesterEvaluationCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C4CF1), Color(0xFF4338CA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.school_rounded, color: Colors.amber, size: 28),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Evaluasi 1 Semester',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Ujian Bab 13 sudah selesai. Sekarang kerjakan evaluasi akhir yang mencakup materi Bab 1 sampai Bab 13.',
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SumatifPage()));
              },
              icon: const Icon(Icons.assignment_rounded),
              label: const Text('Mulai Evaluasi 1 Semester'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF4338CA),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress Belajar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Selesaikan evaluasi secara bertahap untuk membuka bab berikutnya.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF94A3B8),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF6C4CF1).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.rocket_launch_rounded,
            color: Color(0xFF818CF8),
            size: 34,
          ),
        ),
      ],
    );
  }

  Widget _buildSummary({
    required int completedCount,
    required double progress,
    required int progressPercent,
    required int lockedCount,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111C31),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF1D4ED8).withValues(alpha: 0.45),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 92,
                height: 92,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: const Color(0xFF25334D),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF6366F1),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$completedCount / $totalChapters',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Bab Selesai',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progress Keseluruhan',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$progressPercent%',
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFF25334D),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF6366F1),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [
                    _statusChip(
                      icon: Icons.check_circle,
                      text: '$completedCount Selesai',
                      color: const Color(0xFF10B981),
                    ),
                    _statusChip(
                      icon: Icons.lock,
                      text: '$lockedCount Terkunci',
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterCard({
    required BuildContext context,
    required int chapter,
    required String title,
    required bool isCompleted,
    required bool isUnlocked,
    required int? score,
  }) {
    final isLocked = !isUnlocked;

    final Color accentColor;
    final Color cardColor;

    if (isCompleted) {
      accentColor = const Color(0xFF10B981);
      cardColor = const Color(0xFF0D1B2A);
    } else if (isUnlocked) {
      accentColor = const Color(0xFF6366F1);
      cardColor = const Color(0xFF101936);
    } else {
      accentColor = const Color(0xFF64748B);
      cardColor = const Color(0xFF111827);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted
              ? const Color(0xFF10B981).withValues(alpha: 0.35)
              : isUnlocked
                  ? const Color(0xFF6366F1).withValues(alpha: 0.5)
                  : const Color(0xFF1F2937),
          width: 1.3,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (!isUnlocked) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Bab $chapter masih terkunci. Selesaikan Bab ${chapter - 1} terlebih dahulu.',
                  ),
                  backgroundColor: Colors.amber.shade900,
                ),
              );
              return;
            }

            if (chapter <= sampleChapters.length) {
              final chapterData = sampleChapters[chapter - 1];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterDetailPage(chapter: chapterData),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(
                      alpha: isLocked ? 0.18 : 0.85,
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  alignment: Alignment.center,
                  child: isLocked
                      ? const Icon(
                          Icons.lock,
                          color: Color(0xFF94A3B8),
                          size: 20,
                        )
                      : Text(
                          '$chapter',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bab $chapter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isLocked
                              ? Colors.white.withValues(alpha: 0.45)
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: isLocked
                              ? Colors.white.withValues(alpha: 0.25)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            isCompleted
                                ? Icons.check_circle
                                : isUnlocked
                                    ? Icons.lock_open_rounded
                                    : Icons.lock,
                            size: 14,
                            color: isCompleted
                                ? const Color(0xFF10B981)
                                : isUnlocked
                                    ? const Color(0xFF818CF8)
                                    : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            isCompleted
                                ? 'Selesai Evaluasi'
                                : isUnlocked
                                    ? 'Siap dikerjakan'
                                    : 'Terkunci',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isCompleted
                                  ? const Color(0xFF34D399)
                                  : isUnlocked
                                      ? const Color(0xFF818CF8)
                                      : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? const Color(0xFF10B981).withValues(alpha: 0.15)
                            : isUnlocked
                                ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                                : const Color(0xFF64748B).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        isCompleted
                            ? 'Selesai'
                            : isUnlocked
                                ? 'Terbuka'
                                : 'Terkunci',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isCompleted
                              ? const Color(0xFF34D399)
                              : isUnlocked
                                  ? const Color(0xFF818CF8)
                                  : const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                    if (isCompleted && score != null) ...[
                      const SizedBox(height: 7),
                      Text(
                        '$score / 100',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(width: 5),
                Icon(
                  isLocked ? Icons.lock_outline : Icons.chevron_right,
                  color: isLocked
                      ? const Color(0xFF475569)
                      : const Color(0xFF94A3B8),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int? _getFinalScore(Map<String, dynamic>? data) {
    if (data == null) return null;

    final theory = data['theoryScore'];
    final coding = data['codingScore'];

    if (theory is num && coding is num) {
      return ((theory + coding) / 2).round();
    }

    if (theory is num) {
      return theory.toInt();
    }

    return null;
  }
}
