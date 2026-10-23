import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoBabPage extends StatefulWidget {
  final int bab;
  final String judul;
  final int startSeconds;
  final int endSeconds;
  final String videoId;

  const VideoBabPage({
    super.key,
    required this.bab,
    required this.judul,
    required this.startSeconds,
    required this.endSeconds,
    required this.videoId,
  });

  @override
  State<VideoBabPage> createState() => _VideoBabPageState();
}

class _VideoBabPageState extends State<VideoBabPage> {
  late final YoutubePlayerController _controller;

  // ==========================================
  // DAFTAR VIDEO YOUTUBE BAB 1 - 13
  // ==========================================
  static const Map<int, String> videoIds = {
    1: 'KjWbfkWqR4Y',
    2: 'fS-ec0KaGB8',
    3: 'VRqfitH1cLw',
    4: 'goXmjziRwUo',
    5: 'CegiCMF4Ljg',
    6: 't0QmgEFWWTg',
    7: 'fL8-RZ8Lt60',
    8: 'U6ailcItsmQ',
    9: 'uUTJ53sktck',
    10: 'jMau81Jh8JU',
    11: 'MM2JLO6HFmY',
    12: 'CymbNTkakQg',
    13: 'VPzmwIIKKRQ',
  };

  @override
  void initState() {
    super.initState();

    // Ambil video berdasarkan nomor bab.
    // Jika tidak ditemukan, gunakan videoId dari widget.
    final String selectedVideoId =
        videoIds[widget.bab] ?? widget.videoId;

    _controller = YoutubePlayerController.fromVideoId(
      videoId: selectedVideoId,
      autoPlay: false,
      startSeconds: widget.startSeconds.toDouble(),
      endSeconds: widget.endSeconds > widget.startSeconds
          ? widget.endSeconds.toDouble()
          : null,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
        showVideoAnnotations: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Video Bab ${widget.bab}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: YoutubePlayerScaffold(
          controller: _controller,
          aspectRatio: 16 / 9,
          builder: (context, player) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==========================================
                  // VIDEO YOUTUBE
                  // ==========================================
                  Container(
                    width: double.infinity,
                    color: Colors.black,
                    child: player,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==========================================
                        // JUDUL
                        // ==========================================
                        Text(
                          widget.judul,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ==========================================
                        // INFO VIDEO
                        // ==========================================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.ondemand_video_rounded,
                                color: Color(0xFF00E5FF),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Tutorial Video Pembelajaran C++',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ==========================================
                        // PETUNJUK
                        // ==========================================
                        const Text(
                          '💡 Petunjuk Pembelajaran:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.amber,
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          'Video ini menyajikan demonstrasi praktik C++ '
                              'sesuai topik bab ini. Silakan tonton, pahami '
                              'alur penulisan kodenya, kemudian selesaikan '
                              'tugas kuis teori dan praktik di halaman sebelumnya.',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            height: 1.5,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ==========================================
                        // RENTANG VIDEO
                        // ==========================================
                        if (widget.endSeconds > widget.startSeconds)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E2638),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Color(0xFF00E5FF),
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Bagian video: '
                                      '${formatTime(widget.startSeconds)} - '
                                      '${formatTime(widget.endSeconds)}',
                                  style: const TextStyle(
                                    color: Color(0xFFCBD5E1),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}