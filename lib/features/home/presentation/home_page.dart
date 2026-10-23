import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_progress_provider.dart';

class HomePage extends StatelessWidget {
  final Function(int)? onNavigate;

  const HomePage({
    super.key,
    this.onNavigate,
  });

  static const int totalChapters = 13;

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<UserProgressProvider>();

    int completedCount = 0;

    for (int chapter = 1; chapter <= totalChapters; chapter++) {
      if (progressProvider.isChapterCompleted(chapter)) {
        completedCount++;
      }
    }

    final progress = completedCount / totalChapters;
    final percent = (progress * 100).round();

    final nextChapter =
    completedCount >= totalChapters ? null : completedCount + 1;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            // Responsive spacing untuk berbagai ukuran HP.
            final horizontalPadding = width < 360 ? 16.0 : 20.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                18,
                horizontalPadding,
                30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),

                  const SizedBox(height: 24),

                  _buildHeroCard(
                    progress: progress,
                    percent: percent,
                    completedChapters: completedCount,
                    nextChapter: nextChapter,
                  ),

                  const SizedBox(height: 20),

                  _buildContinueLearning(
                    context: context,
                    nextChapter: nextChapter,
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Akses Cepat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Pilih aktivitas belajar yang ingin kamu lakukan.',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 15),

                  _buildQuickActions(context),

                  const SizedBox(height: 28),

                  _buildLearningStatus(
                    completedCount: completedCount,
                    percent: percent,
                  ),

                  const SizedBox(height: 20),

                  _buildMotivation(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ================================================================
  // HEADER
  // ================================================================

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF7C3AED),
                Color(0xFF2563EB),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withValues(alpha: 0.25),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.code_rounded,
            color: Colors.white,
            size: 27,
          ),
        ),

        const SizedBox(width: 14),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang 👋',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'CraftC++',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF151C30),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFFCBD5E1),
            size: 23,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // HERO
  // ================================================================

  Widget _buildHeroCard({
    required double progress,
    required int percent,
    required int completedChapters,
    required int? nextChapter,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7C3AED),
            Color(0xFF2563EB),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.25),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            top: -40,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.07),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            right: 25,
            bottom: -55,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.rocket_launch_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Learning Progress',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 17),

              const Text(
                'Belajar C++\nJadi Lebih Seru 🚀',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                nextChapter == null
                    ? 'Keren! Kamu sudah menyelesaikan semua materi.'
                    : 'Teruskan perjalananmu dan tingkatkan kemampuan C++-mu.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.80),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 9,
                        backgroundColor:
                        Colors.white.withValues(alpha: 0.20),
                        valueColor:
                        const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 13),

                  Text(
                    '$percent%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 9),

              Text(
                '$completedChapters dari $totalChapters bab telah selesai',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.72),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================================================================
  // CONTINUE LEARNING
  // ================================================================

  Widget _buildContinueLearning({
    required BuildContext context,
    required int? nextChapter,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(23),
      onTap: () {
        onNavigate?.call(1);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF151C30),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF22C55E),
                    Color(0xFF16A34A),
                  ],
                ),
                borderRadius: BorderRadius.circular(17),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lanjutkan Belajar',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    nextChapter == null
                        ? 'Semua materi telah selesai 🎉'
                        : 'Buka materi dan lanjutkan pembelajaranmu',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 11,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF64748B),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // QUICK ACTIONS
  // ================================================================

  Widget _buildQuickActions(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Tinggi card dibuat responsive.
    // HP kecil: 145
    // HP normal/besar: 155
    final cardHeight = width < 360 ? 145.0 : 155.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: cardHeight,
      ),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return _QuickActionCard(
              icon: Icons.menu_book_rounded,
              title: 'Materi',
              subtitle: 'Pelajari C++',
              gradient: const [
                Color(0xFF312E81),
                Color(0xFF4338CA),
              ],
              iconColor: const Color(0xFFA5B4FC),
              onTap: () {
                onNavigate?.call(1);
              },
            );

          case 1:
            return _QuickActionCard(
              icon: Icons.code_rounded,
              title: 'Coding Space',
              subtitle: 'Tulis & jalankan kode',
              gradient: const [
                Color(0xFF164E63),
                Color(0xFF0891B2),
              ],
              iconColor: const Color(0xFF67E8F9),
              onTap: () {
                onNavigate?.call(2);
              },
            );

          case 2:
            return _QuickActionCard(
              icon: Icons.emoji_events_rounded,
              title: 'Coding Race',
              subtitle: 'Adu cepat coding',
              gradient: const [
                Color(0xFF78350F),
                Color(0xFFB45309),
              ],
              iconColor: const Color(0xFFFDE68A),
              onTap: () {
                onNavigate?.call(3);
              },
            );

          default:
            return _QuickActionCard(
              icon: Icons.analytics_rounded,
              title: 'Progress',
              subtitle: 'Lihat perkembangan',
              gradient: const [
                Color(0xFF14532D),
                Color(0xFF15803D),
              ],
              iconColor: const Color(0xFF86EFAC),
              onTap: () {
                onNavigate?.call(4);
              },
            );
        }
      },
    );
  }

  // ================================================================
  // LEARNING STATUS
  // ================================================================

  Widget _buildLearningStatus({
    required int completedCount,
    required int percent,
  }) {
    final remaining = totalChapters - completedCount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151C30),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.insights_rounded,
                color: Color(0xFF818CF8),
                size: 22,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Ringkasan Belajar',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.check_circle_rounded,
                  value: '$completedCount',
                  label: 'Bab selesai',
                  iconColor: const Color(0xFF4ADE80),
                ),
              ),

              Container(
                width: 1,
                height: 45,
                color: Colors.white.withValues(alpha: 0.06),
              ),

              Expanded(
                child: _StatItem(
                  icon: Icons.pending_actions_rounded,
                  value: '$remaining',
                  label: 'Bab tersisa',
                  iconColor: const Color(0xFFFBBF24),
                ),
              ),

              Container(
                width: 1,
                height: 45,
                color: Colors.white.withValues(alpha: 0.06),
              ),

              Expanded(
                child: _StatItem(
                  icon: Icons.percent_rounded,
                  value: '$percent%',
                  label: 'Progress',
                  iconColor: const Color(0xFF818CF8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================================================================
  // MOTIVATION
  // ================================================================

  Widget _buildMotivation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF59E0B).withValues(alpha: 0.12),
            const Color(0xFFEF4444).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: Colors.amber.withValues(alpha: 0.15),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💡',
            style: TextStyle(fontSize: 27),
          ),

          SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tips Hari Ini',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Jangan hanya membaca kode. Coba tulis dan jalankan sendiri agar konsep C++ lebih mudah dipahami.',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                    height: 1.5,
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

// ====================================================================
// QUICK ACTION CARD
// ====================================================================

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final Color iconColor;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF151C30),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 3),

              Flexible(
                child: Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ====================================================================
// STAT ITEM
// ====================================================================

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 20,
        ),

        const SizedBox(height: 6),

        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}