import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AiTutorWidget extends StatefulWidget {
  const AiTutorWidget({super.key});

  @override
  State<AiTutorWidget> createState() => _AiTutorWidgetState();
}

class _AiTutorWidgetState extends State<AiTutorWidget> {
  final TextEditingController _messageController =
  TextEditingController();

  final List<Map<String, String>> _messages = [
    {
      'sender': 'ai',
      'text':
      'Halo! Saya AI Tutor CraftC++. Ada yang bisa saya bantu dengan kode C++ kamu?',
    },
  ];

  bool _isLoading = false;

   static const String _baseUrl =
      'http://10.205.171.147:3000';

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();

    if (message.isEmpty || _isLoading) {
      return;
    }

    setState(() {
      _messages.add({
        'sender': 'user',
        'text': message,
      });

      _messageController.clear();
      _isLoading = true;
    });

    try {
      debugPrint('Mengirim pertanyaan ke AI...');
      debugPrint('URL: $_baseUrl/api/ai/tutor');

      final response = await http
          .post(
        Uri.parse('$_baseUrl/api/ai/tutor'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'message': message,
          'code': '',
          'chapter': 'Belajar C++',
        }),
      )
          .timeout(
        const Duration(seconds: 60),
      );

      if (!mounted) return;

      debugPrint('HTTP Status: ${response.statusCode}');
      debugPrint('Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _messages.add({
            'sender': 'ai',
            'text': data['answer']?.toString() ??
                'AI tidak memberikan jawaban.',
          });
        });
      } else {
        String errorMessage =
            'Terjadi kesalahan pada server AI.';

        try {
          final data = jsonDecode(response.body);

          if (data['error'] != null) {
            errorMessage = data['error'].toString();
          }

          if (data['detail'] != null) {
            errorMessage +=
            '\n\nDetail:\n${data['detail']}';
          }
        } catch (_) {
          errorMessage =
          'Server mengembalikan error HTTP ${response.statusCode}.';
        }

        setState(() {
          _messages.add({
            'sender': 'ai',
            'text': errorMessage,
          });
        });
      }
    } on TimeoutException {
      if (!mounted) return;

      setState(() {
        _messages.add({
          'sender': 'ai',
          'text':
          'Koneksi ke AI timeout. Pastikan backend Node.js sedang berjalan dan HP serta laptop berada di jaringan yang sama.',
        });
      });
    } catch (e) {
      if (!mounted) return;

      debugPrint('Error AI Tutor: $e');

      setState(() {
        _messages.add({
          'sender': 'ai',
          'text':
          'Tidak dapat terhubung ke server AI.\n\n'
              'Pastikan:\n'
              '1. Backend Node.js sedang berjalan.\n'
              '2. HP dan laptop berada di Wi-Fi yang sama.\n'
              '3. IP backend benar.\n\n'
              'Error: $e',
        });
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildMessageBubble(
      Map<String, String> message,
      ) {
    final bool isUser =
        message['sender'] == 'user';

    return Align(
      alignment: isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 330,
        ),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? Colors.blue[100]
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          message['text'] ?? '',
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blueAccent,
            child: const Row(
              children: [
                Icon(
                  Icons.smart_toy,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'AI Tutor',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(
                  _messages[index],
                );
              },
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'AI sedang berpikir...',
                    ),
                  ],
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    enabled: !_isLoading,
                    textInputAction:
                    TextInputAction.send,
                    decoration:
                    const InputDecoration(
                      hintText:
                      'Tanya AI Tutor...',
                      border:
                      OutlineInputBorder(),
                    ),
                    onSubmitted: (_) {
                      _sendMessage();
                    },
                  ),
                ),

                const SizedBox(width: 4),

                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                  ),
                  onPressed:
                  _isLoading
                      ? null
                      : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}