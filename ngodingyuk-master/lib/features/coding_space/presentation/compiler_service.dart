import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'evaluation_data.dart';

class CompilerService {
  static const String _baseUrl = 'https://ce.judge0.com';

  Future<Map<String, dynamic>> runCpp({
    required String sourceCode,
    String stdin = '',
  }) async {
    // 1. Kirim kode C++ ke Judge0
    final createResponse = await http.post(
      Uri.parse(
        '$_baseUrl/submissions?base64_encoded=false&wait=false',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'source_code': sourceCode,
        'language_id': 54,
        'stdin': stdin,
      }),
    );

    if (createResponse.statusCode != 201) {
      throw Exception(
        'Gagal mengirim kode ke compiler. '
            'Status: ${createResponse.statusCode}',
      );
    }

    final createData = jsonDecode(createResponse.body);
    final token = createData['token'];

    if (token == null) {
      throw Exception(
        'Token submission tidak ditemukan.',
      );
    }

    // 2. Tunggu sampai proses compile selesai
    for (int i = 0; i < 20; i++) {
      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      final resultResponse = await http.get(
        Uri.parse(
          '$_baseUrl/submissions/$token?base64_encoded=false',
        ),
      );

      if (resultResponse.statusCode != 200) {
        throw Exception(
          'Gagal mengambil hasil compiler. '
              'Status: ${resultResponse.statusCode}',
        );
      }

      final result = jsonDecode(resultResponse.body);

      final statusId = result['status']?['id'];

      // Status 1 = In Queue
      // Status 2 = Processing
      // Status 3 = Accepted
      // Status lainnya = selesai
      if (statusId != 1 && statusId != 2) {
        return result;
      }
    }

    throw Exception(
      'Compiler terlalu lama merespons.',
    );
  }

  // ============================================================
  // EVALUASI CODING BERDASARKAN TEST CASE
  // ============================================================

  Future<Map<String, dynamic>> evaluateCpp({
    required String sourceCode,
    required List<CodingTestCase> testCases,
  }) async {
    final results = <Map<String, dynamic>>[];

    int passed = 0;

    for (int i = 0; i < testCases.length; i++) {
      final testCase = testCases[i];

      try {
        final result = await runCpp(
          sourceCode: sourceCode,
          stdin: testCase.input,
        );

        final actualOutput =
        _normalizeOutput(
          (result['stdout'] ?? '').toString(),
        );

        final expectedOutput =
        _normalizeOutput(
          testCase.expectedOutput,
        );

        final statusId =
        result['status']?['id'];

        final isAccepted =
            statusId == 3 &&
                actualOutput == expectedOutput;

        if (isAccepted) {
          passed++;
        }

        results.add({
          'testCase': i + 1,
          'input': testCase.input,
          'expected': expectedOutput,
          'actual': actualOutput,
          'passed': isAccepted,
          'status':
          result['status']?['description'] ??
              'Unknown',
          'stderr':
          result['stderr'] ?? '',
          'compileOutput':
          result['compile_output'] ?? '',
        });
      } catch (e) {
        results.add({
          'testCase': i + 1,
          'input': testCase.input,
          'expected':
          _normalizeOutput(
            testCase.expectedOutput,
          ),
          'actual': '',
          'passed': false,
          'status': 'Error',
          'stderr': e.toString(),
          'compileOutput': '',
        });
      }
    }

    final total = testCases.length;

    final score = total == 0
        ? 0
        : ((passed / total) * 100).round();

    return {
      'passed': passed,
      'total': total,
      'score': score,
      'results': results,
    };
  }

  // Membuat perbandingan output lebih aman.
  //
  // Contoh:
  // "Hello\n"
  // dan
  // "Hello"
  //
  // dianggap sama.
  String _normalizeOutput(String output) {
    return output
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .trim();
  }
}