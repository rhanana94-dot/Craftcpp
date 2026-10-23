import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/chapter.dart';
import '../../../providers/user_progress_provider.dart';
import '../../coding_space/presentation/evaluation_page.dart';
import 'video_bab_page.dart';

class ChapterDetailPage extends StatelessWidget {
  final Chapter chapter;

  const ChapterDetailPage({
    super.key,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    final chapterNumber = int.tryParse(chapter.id) ?? 1;

    // FIX:
    // Harus ditentukan tipe Provider-nya.
    final progressProvider =
    context.watch<UserProgressProvider>();

    final isCompleted =
    progressProvider.isChapterCompleted(chapterNumber);

    final isUnlocked =
    progressProvider.isChapterUnlocked(chapterNumber);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),

      appBar: AppBar(
        title: Text(
          'Bab $chapterNumber',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0B0F19),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                30,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  _ChapterHeaderCard(
                    chapter: chapter,
                    chapterNumber: chapterNumber,
                    isCompleted: isCompleted,
                    isUnlocked: isUnlocked,
                  ),

                  const SizedBox(height: 20),

                  _VideoBannerCard(
                    chapterNumber: chapterNumber,
                    chapter: chapter,
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Materi Pembelajaran',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _ContentBody(
                    content: chapter.content,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          _BottomActionBar(
            chapterNumber: chapterNumber,
            isCompleted: isCompleted,
            isUnlocked: isUnlocked,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HEADER BAB
// ============================================================

class _ChapterHeaderCard extends StatelessWidget {
  final Chapter chapter;
  final int chapterNumber;
  final bool isCompleted;
  final bool isUnlocked;

  const _ChapterHeaderCard({
    required this.chapter,
    required this.chapterNumber,
    required this.isCompleted,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161F30),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C4CF1)
                      .withValues(alpha: 0.2),
                  borderRadius:
                  BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF6C4CF1),
                  ),
                ),
                child: Text(
                  'BAB $chapterNumber',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00E5FF),
                  ),
                ),
              ),

              _StatusBadge(
                isCompleted: isCompleted,
                isUnlocked: isUnlocked,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            chapter.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            chapter.description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF94A3B8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// VIDEO
// ============================================================

class _VideoBannerCard extends StatelessWidget {
  final int chapterNumber;
  final Chapter chapter;

  const _VideoBannerCard({
    required this.chapterNumber,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        color: const Color(0xFF161F30),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white10,
        ),
        image: const DecorationImage(
          image: AssetImage(
            'assets/loading screan.jpeg',
          ),
          opacity: 0.25,
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                BorderRadius.circular(50),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VideoBabPage(
                            bab: chapterNumber,
                            judul: chapter.title,
                            startSeconds:
                            chapter.startSeconds,
                            endSeconds:
                            chapter.endSeconds,
                            videoId:
                            chapter.videoUrl,
                          ),
                    ),
                  );
                },
                child: Container(
                  padding:
                  const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C4CF1)
                        .withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                        const Color(0xFF6C4CF1)
                            .withValues(
                          alpha: 0.4,
                        ),
                        blurRadius: 16,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 44,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Tonton Video Pembelajaran',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STATUS BADGE
// ============================================================

class _StatusBadge extends StatelessWidget {
  final bool isCompleted;
  final bool isUnlocked;

  const _StatusBadge({
    required this.isCompleted,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return Container(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color:
          Colors.green.withValues(alpha: 0.2),
          borderRadius:
          BorderRadius.circular(12),
          border: Border.all(
            color:
            Colors.green.withValues(alpha: 0.4),
          ),
        ),
        child: const Text(
          'Selesai',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
      );
    }

    if (isUnlocked) {
      return Container(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color:
          const Color(0xFF00E5FF)
              .withValues(alpha: 0.2),
          borderRadius:
          BorderRadius.circular(12),
          border: Border.all(
            color:
            const Color(0xFF00E5FF)
                .withValues(alpha: 0.4),
          ),
        ),
        child: const Text(
          'Sedang Dipelajari',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00E5FF),
          ),
        ),
      );
    }

    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius:
        BorderRadius.circular(12),
      ),
      child: const Text(
        'Terkunci',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF94A3B8),
        ),
      ),
    );
  }
}

// ============================================================
// CONTENT MATERI
// ============================================================

class _ContentBody extends StatelessWidget {
  final String content;

  const _ContentBody({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final lines = content.split('\n');

    final List<Widget> widgets = [];

    final StringBuffer paragraphBuffer =
    StringBuffer();

    final StringBuffer codeBuffer =
    StringBuffer();

    bool inCodeBlock = false;

    for (final line in lines) {
      final trimmed = line.trim();

      // Pembuka / penutup code block
      if (trimmed.startsWith('```')) {
        if (inCodeBlock) {
          widgets.add(
            _CodeCard(
              code: codeBuffer.toString(),
            ),
          );

          codeBuffer.clear();
          inCodeBlock = false;
        } else {
          if (paragraphBuffer.isNotEmpty) {
            widgets.add(
              _TextParagraph(
                text:
                paragraphBuffer.toString(),
              ),
            );

            paragraphBuffer.clear();
          }

          inCodeBlock = true;
        }
      } else if (inCodeBlock) {
        codeBuffer.writeln(line);
      } else {
        paragraphBuffer.writeln(line);
      }
    }

    // Jika masih ada paragraph
    if (paragraphBuffer.isNotEmpty) {
      widgets.add(
        _TextParagraph(
          text: paragraphBuffer.toString(),
        ),
      );
    }

    // Jika code block belum tertutup
    if (inCodeBlock &&
        codeBuffer.isNotEmpty) {
      widgets.add(
        _CodeCard(
          code: codeBuffer.toString(),
        ),
      );
    }

    if (widgets.isEmpty) {
      widgets.add(
        _TextParagraph(
          text: content,
        ),
      );
    }

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

// ============================================================
// TEXT MATERI
// ============================================================

class _TextParagraph extends StatelessWidget {
  final String text;

  const _TextParagraph({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final cleanedText = text.trim();

    if (cleanedText.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin:
      const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF161F30),
        borderRadius:
        BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: SelectableText(
        cleanedText,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFFE2E8F0),
          height: 1.6,
        ),
      ),
    );
  }
}

// ============================================================
// CODE C++
// ============================================================

class _CodeCard extends StatelessWidget {
  final String code;

  const _CodeCard({
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final cleanedCode = code.trim();

    return Container(
      margin:
      const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color:
          const Color(0xFF00E5FF)
              .withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CONTOH KODE C++',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00E5FF),
                  letterSpacing: 1.0,
                ),
              ),
              Icon(
                Icons.code,
                size: 16,
                color: Color(0xFF00E5FF),
              ),
            ],
          ),

          const Divider(
            color: Colors.white12,
            height: 16,
          ),

          SingleChildScrollView(
            scrollDirection:
            Axis.horizontal,
            child: SelectableText(
              cleanedCode,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFF38BDF8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BOTTOM ACTION
// ============================================================

class _BottomActionBar extends StatelessWidget {
  final int chapterNumber;
  final bool isCompleted;
  final bool isUnlocked;

  const _BottomActionBar({
    required this.chapterNumber,
    required this.isCompleted,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF161F30),
        border: Border(
          top: BorderSide(
            color: Colors.white10,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: isCompleted
                ? const Color(0xFF161F30)
                : isUnlocked
                ? const Color(0xFF6C4CF1)
                : Colors.white10,

            foregroundColor: isCompleted
                ? const Color(0xFF00E5FF)
                : isUnlocked
                ? Colors.white
                : Colors.white38,

            side: isCompleted
                ? const BorderSide(
              color: Color(0xFF00E5FF),
            )
                : BorderSide.none,

            elevation: 0,

            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(16),
            ),
          ),

          icon: Icon(
            isCompleted
                ? Icons.analytics_outlined
                : isUnlocked
                ? Icons.quiz_outlined
                : Icons.lock_outline,
          ),

          label: Text(
            isCompleted
                ? 'Lihat Hasil & Pembahasan Evaluasi'
                : isUnlocked
                ? 'Mulai Kerjakan Evaluasi'
                : chapterNumber == 1
                ? 'Mulai Kerjakan Evaluasi'
                : 'Terkunci (Selesaikan Bab ${chapterNumber - 1})',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          onPressed: isUnlocked
              ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EvaluationPage(
                      chapter: chapterNumber,
                    ),
              ),
            );
          }
              : null,
        ),
      ),
    );
  }
}