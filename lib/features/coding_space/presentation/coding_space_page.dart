import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/cpp.dart';

import 'ai_tutor_widget.dart';
import 'compiler_service.dart';

class CodingSpacePage extends StatefulWidget {
  final String? initialCode;
  final String? initialInput;

  const CodingSpacePage({
    super.key,
    this.initialCode,
    this.initialInput,
  });

  @override
  State<CodingSpacePage> createState() => _CodingSpacePageState();
}

class _CodingSpacePageState extends State<CodingSpacePage> {
  CodeController? _codeController;

  final CompilerService _compilerService = CompilerService();
  final TextEditingController _inputController = TextEditingController();

  String _output = '';
  bool _isRunning = false;
  bool _showAiTutor = false;

  @override
  void initState() {
    super.initState();

    _codeController = CodeController(
      text: widget.initialCode ??
          '''#include <iostream>

int main() {
    std::cout << "Hello, CraftC++!" << std::endl;
    return 0;
}''',
      language: cpp,

      // ==========================================================
      // SYNTAX HIGHLIGHTING
      // ==========================================================
      patternMap: monokaiSublimeTheme,
    );

    if (widget.initialInput != null) {
      _inputController.text = widget.initialInput!;
    }
  }

  @override
  void dispose() {
    _codeController?.dispose();
    _inputController.dispose();
    super.dispose();
  }

  // ================================================================
  // RUN CODE
  // ================================================================

  Future<void> _runCode() async {
    if (_codeController == null || _isRunning) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isRunning = true;
      _output = 'Menjalankan program...';
    });

    try {
      final sourceCode = _codeController!.text;
      final stdin = _inputController.text;

      final result = await _compilerService.runCpp(
        sourceCode: sourceCode,
        stdin: stdin,
      );

      final status =
          result['status']?['description']?.toString() ?? 'Unknown';

      final stdout = result['stdout']?.toString() ?? '';
      final stderr = result['stderr']?.toString() ?? '';
      final compileOutput =
          result['compile_output']?.toString() ?? '';

      final buffer = StringBuffer();

      if (stdout.trim().isNotEmpty) {
        buffer.writeln(stdout.trimRight());
      }

      if (compileOutput.trim().isNotEmpty) {
        if (buffer.isNotEmpty) {
          buffer.writeln();
        }

        buffer.writeln('COMPILER ERROR');
        buffer.writeln(compileOutput.trimRight());
      }

      if (stderr.trim().isNotEmpty) {
        if (buffer.isNotEmpty) {
          buffer.writeln();
        }

        buffer.writeln('RUNTIME ERROR');
        buffer.writeln(stderr.trimRight());
      }

      if (buffer.isEmpty) {
        buffer.write('Program tidak menghasilkan output.');
      }

      if (!mounted) return;

      setState(() {
        _output =
        '${buffer.toString()}\n\nStatus: $status';
        _isRunning = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _output = 'Terjadi kesalahan:\n$e';
        _isRunning = false;
      });
    }
  }

  // ================================================================
  // CLEAR OUTPUT
  // ================================================================

  void _clearOutput() {
    setState(() {
      _output = '';
    });
  }

  // ================================================================
  // BUILD
  // ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),

      // ============================================================
      // APP BAR
      // ============================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,

        title: const Row(
          children: [
            Icon(
              Icons.code_rounded,
              color: Color(0xFF60A5FA),
              size: 23,
            ),
            SizedBox(width: 9),
            Text(
              'Coding Space',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),

        actions: [
          // ========================================================
          // CLEAR
          // ========================================================

          IconButton(
            onPressed: _clearOutput,
            tooltip: 'Clear Output',
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 21,
            ),
          ),

          const SizedBox(width: 4),

          // ========================================================
          // RUN
          // ========================================================

          Padding(
            padding: const EdgeInsets.only(
              right: 12,
              top: 8,
              bottom: 8,
            ),
            child: FilledButton.icon(
              onPressed: _isRunning ? null : _runCode,

              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                disabledBackgroundColor:
                const Color(0xFF334155),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              icon: _isRunning
                  ? const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Icon(
                Icons.play_arrow_rounded,
                size: 20,
              ),

              label: Text(
                _isRunning ? 'Running' : 'Run',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),

      // ============================================================
      // BODY
      // ============================================================

      body: Stack(
        children: [
          Column(
            children: [
              // ======================================================
              // EDITOR HEADER
              // ======================================================

              Container(
                height: 40,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF161D2D),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF252E42),
                    ),
                  ),
                ),

                child: const Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color(0xFF22C55E),
                      size: 8,
                    ),
                    SizedBox(width: 8),

                    Text(
                      'main.cpp',
                      style: TextStyle(
                        color: Color(0xFFCBD5E1),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(width: 8),

                    Text(
                      'C++',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              // ======================================================
              // CODE EDITOR
              // ======================================================

              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFF0D1117),

                  child: _codeController == null
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : CodeField(
                    controller: _codeController!,

                    expands: true,

                    wrap: false,

                    // ==================================================
                    // NOMOR BARIS
                    // ==================================================

                    lineNumberStyle:
                    const LineNumberStyle(
                      width: 48,
                      textStyle: TextStyle(
                        color: Color(0xFF4B5563),
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                      background:
                      Color(0xFF0D1117),
                    ),

                    // ==================================================
                    // FONT
                    // ==================================================

                    textStyle: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.55,
                    ),

                    cursorColor:
                    const Color(0xFF60A5FA),

                    background:
                    const Color(0xFF0D1117),

                    padding: const EdgeInsets.only(
                      top: 12,
                      right: 14,
                      bottom: 20,
                    ),
                  ),
                ),
              ),

              // ======================================================
              // INPUT HEADER
              // ======================================================

              Container(
                height: 42,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF161D2D),
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF252E42),
                    ),
                    bottom: BorderSide(
                      color: Color(0xFF252E42),
                    ),
                  ),
                ),

                child: const Row(
                  children: [
                    Icon(
                      Icons.input_rounded,
                      color: Color(0xFFFBBF24),
                      size: 18,
                    ),
                    SizedBox(width: 8),

                    Text(
                      'INPUT',
                      style: TextStyle(
                        color: Color(0xFFE2E8F0),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    SizedBox(width: 8),

                    Text(
                      'Data untuk cin / getline',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              // ======================================================
              // INPUT FIELD
              // ======================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: const Color(0xFF0B0F19),

                child: TextField(
                  controller: _inputController,
                  maxLines: 3,
                  minLines: 2,

                  style: const TextStyle(
                    color: Color(0xFFE5E7EB),
                    fontFamily: 'monospace',
                    fontSize: 13,
                  ),

                  cursorColor:
                  const Color(0xFF60A5FA),

                  decoration: InputDecoration(
                    hintText:
                    'Contoh: 10 20 atau masukkan input program...',

                    hintStyle: const TextStyle(
                      color: Color(0xFF475569),
                      fontSize: 11,
                    ),

                    filled: true,

                    fillColor:
                    const Color(0xFF111827),

                    contentPadding:
                    const EdgeInsets.all(11),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF263248),
                      ),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF263248),
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF3B82F6),
                        width: 1.2,
                      ),
                    ),
                  ),
                ),
              ),

              // ======================================================
              // OUTPUT HEADER
              // ======================================================

              Container(
                height: 42,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),

                decoration: const BoxDecoration(
                  color: Color(0xFF161D2D),
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF252E42),
                    ),
                    bottom: BorderSide(
                      color: Color(0xFF252E42),
                    ),
                  ),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.terminal_rounded,
                      color: Color(0xFF4ADE80),
                      size: 18,
                    ),

                    const SizedBox(width: 8),

                    const Text(
                      'OUTPUT',
                      style: TextStyle(
                        color: Color(0xFFE2E8F0),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const Spacer(),

                    if (_isRunning)
                      const Text(
                        'Running...',
                        style: TextStyle(
                          color: Color(0xFFFBBF24),
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ),

              // ======================================================
              // OUTPUT CONSOLE
              // ======================================================

              Expanded(
                flex: 2,

                child: Container(
                  width: double.infinity,
                  color: const Color(0xFF05070B),

                  padding: const EdgeInsets.fromLTRB(
                    14,
                    12,
                    14,
                    18,
                  ),

                  child: SingleChildScrollView(
                    physics:
                    const BouncingScrollPhysics(),

                    child: SelectableText(
                      _output.isEmpty
                          ? 'Output program akan muncul di sini...'
                          : _output,

                      style: TextStyle(
                        color: _output.isEmpty
                            ? const Color(0xFF475569)
                            : const Color(0xFF86EFAC),

                        fontFamily: 'monospace',
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ============================================================
          // AI TUTOR
          // ============================================================

          if (_showAiTutor)
            Positioned.fill(
              child: Material(
                color:
                Colors.black.withValues(alpha: 0.35),

                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,

                      width:
                      MediaQuery.sizeOf(context)
                          .width *
                          0.82,

                      child: Material(
                        elevation: 20,
                        color:
                        const Color(0xFF111827),

                        child: SafeArea(
                          child: Column(
                            children: [
                              Container(
                                height: 55,

                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 15,
                                ),

                                decoration:
                                const BoxDecoration(
                                  color:
                                  Color(0xFF161D2D),
                                  border: Border(
                                    bottom:
                                    BorderSide(
                                      color:
                                      Color(0xFF263248),
                                    ),
                                  ),
                                ),

                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons
                                          .smart_toy_rounded,
                                      color:
                                      Color(0xFF60A5FA),
                                    ),

                                    const SizedBox(
                                      width: 9,
                                    ),

                                    const Expanded(
                                      child: Text(
                                        'AI Tutor',
                                        style:
                                        TextStyle(
                                          color:
                                          Colors.white,
                                          fontWeight:
                                          FontWeight
                                              .w800,
                                        ),
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _showAiTutor =
                                          false;
                                        });
                                      },

                                      icon: const Icon(
                                        Icons
                                            .close_rounded,
                                        color:
                                        Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Expanded(
                                child:
                                AiTutorWidget(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),

      // ================================================================
      // AI BUTTON
      // ================================================================

      floatingActionButton: _showAiTutor
          ? null
          : FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _showAiTutor = true;
          });
        },

        backgroundColor:
        const Color(0xFF2563EB),

        foregroundColor: Colors.white,

        icon: const Icon(
          Icons.smart_toy_rounded,
        ),

        label: const Text(
          'AI Tutor',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}