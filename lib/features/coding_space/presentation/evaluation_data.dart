class MultipleChoiceQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;

  // Penjelasan umum mengenai soal.
  final String explanation;

  // Penjelasan untuk setiap pilihan A, B, C, D.
  final List<String> optionExplanations;

  // Konsep/materi yang sedang diuji.
  final String concept;

  const MultipleChoiceQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.optionExplanations,
    required this.concept,
  });
}

class CodingTestCase {
  final String input;
  final String expectedOutput;

  const CodingTestCase({
    required this.input,
    required this.expectedOutput,
  });
}

class CodingQuestion {
  final String question;
  final String? starterCode;
  final List<CodingTestCase> testCases;

  // Konsep utama yang diuji oleh tugas coding.
  final String concept;

  // Konsep/fungsi yang diharapkan digunakan.
  final List<String> expectedConcepts;

  // Contoh solusi yang menjadi acuan pembelajaran.
  final String solutionCode;

  // Penjelasan mengenai cara kerja solusi.
  final String solutionExplanation;

  const CodingQuestion({
    required this.question,
    this.starterCode,
    required this.testCases,
    required this.concept,
    required this.expectedConcepts,
    required this.solutionCode,
    required this.solutionExplanation,
  });
}

class FinalProject {
  final String title;
  final String description;
  final List<String> requirements;

  const FinalProject({
    required this.title,
    required this.description,
    required this.requirements,
  });
}

class ChapterEvaluation {
  final int chapter;
  final String title;
  final List<MultipleChoiceQuestion> multipleChoiceQuestions;
  final CodingQuestion? codingQuestion;
  final FinalProject? finalProject;

  const ChapterEvaluation({
    required this.chapter,
    required this.title,
    required this.multipleChoiceQuestions,
    this.codingQuestion,
    this.finalProject,
  });
}

const List<ChapterEvaluation> evaluations = [
  // ============================================================
  // BAB 1
  // ============================================================
  ChapterEvaluation(
    chapter: 1,
    title: 'Pengenalan Bahasa Pemrograman C++',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'Bahasa C++ termasuk ke dalam jenis bahasa pemrograman ...',
          options: [
            'Bahasa markup',
            'Bahasa pemrograman',
            'Bahasa basis data',
            'Bahasa desain grafis',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Bahasa pemrograman\' sesuai dengan konsep Pengenalan Bahasa Pemrograman C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. Bahasa markup tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Bahasa pemrograman merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Bahasa basis data tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Bahasa desain grafis tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Pengenalan Bahasa Pemrograman C++'),
      MultipleChoiceQuestion(
          question:
          'Salah satu kelebihan C++ adalah ...',
          options: [
            'Hanya dapat digunakan untuk membuat halaman web',
            'Tidak dapat menggunakan fungsi',
            'Mendukung pemrograman prosedural dan berorientasi objek',
            'Tidak dapat melakukan operasi matematika',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'Mendukung pemrograman prosedural dan berorientasi objek\' sesuai dengan konsep Pengenalan Bahasa Pemrograman C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. Hanya dapat digunakan untuk membuat halaman web tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Tidak dapat menggunakan fungsi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Mendukung pemrograman prosedural dan berorientasi objek merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Tidak dapat melakukan operasi matematika tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Pengenalan Bahasa Pemrograman C++'),
      MultipleChoiceQuestion(
          question:
          'Berikut yang merupakan ekstensi file source code C++ adalah ...',
          options: [
            '.html',
            '.css',
            '.cpp',
            '.java',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'.cpp\' sesuai dengan konsep Pengenalan Bahasa Pemrograman C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. .html tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. .css tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. .cpp merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. .java tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Pengenalan Bahasa Pemrograman C++'),
      MultipleChoiceQuestion(
          question:
          'Compiler pada pemrograman C++ digunakan untuk ...',
          options: [
            'Mengubah source code menjadi program yang dapat dijalankan',
            'Membuat desain antarmuka',
            'Menghapus source code',
            'Membuat koneksi internet',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Mengubah source code menjadi program yang dapat dijalankan\' sesuai dengan konsep Pengenalan Bahasa Pemrograman C++ yang sedang diuji.',
          optionExplanations: [
            'Benar. Mengubah source code menjadi program yang dapat dijalankan merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Membuat desain antarmuka tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghapus source code tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Membuat koneksi internet tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Pengenalan Bahasa Pemrograman C++'),
      MultipleChoiceQuestion(
          question:
          'Fungsi main() pada program C++ adalah ...',
          options: [
            'Menampilkan library',
            'Menjadi titik awal eksekusi program',
            'Menyimpan data pengguna',
            'Menghentikan compiler',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Menjadi titik awal eksekusi program\' sesuai dengan konsep Pengenalan Bahasa Pemrograman C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. Menampilkan library tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Menjadi titik awal eksekusi program merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Menyimpan data pengguna tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghentikan compiler tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Pengenalan Bahasa Pemrograman C++'),
    ],
    codingQuestion: null,
  ),

  // ============================================================
  // BAB 2
  // ============================================================
  ChapterEvaluation(
    chapter: 2,
    title: 'Struktur Dasar Program C++ yang Harus Dipahami',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'Bagian program C++ yang digunakan sebagai titik awal eksekusi program adalah ...',
          options: [
            '#include',
            'main()',
            'cout',
            'return',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'main()\' sesuai dengan konsep Struktur Dasar Program C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. #include tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. main() merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. cout tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. return tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struktur Dasar Program C++'),
      MultipleChoiceQuestion(
          question:
          'Fungsi dari #include <iostream> adalah ...',
          options: [
            'Menjalankan program',
            'Mengakhiri program',
            'Memasukkan library untuk operasi input dan output',
            'Menampilkan teks ke layar',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'Memasukkan library untuk operasi input dan output\' sesuai dengan konsep Struktur Dasar Program C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. Menjalankan program tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Mengakhiri program tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Memasukkan library untuk operasi input dan output merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Menampilkan teks ke layar tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struktur Dasar Program C++'),
      MultipleChoiceQuestion(
          question:
          'Perintah return 0; pada fungsi main() menunjukkan bahwa ...',
          options: [
            'Program menghasilkan error',
            'Program selesai dengan status berhasil',
            'Program akan mengulang dari awal',
            'Program menampilkan angka 0',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Program selesai dengan status berhasil\' sesuai dengan konsep Struktur Dasar Program C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. Program menghasilkan error tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Program selesai dengan status berhasil merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Program akan mengulang dari awal tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Program menampilkan angka 0 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struktur Dasar Program C++'),
      MultipleChoiceQuestion(
          question:
          'Fungsi std::cout << "Hello World"; adalah ...',
          options: [
            'Menerima input dari pengguna',
            'Menampilkan teks ke layar',
            'Membuat variabel',
            'Menghentikan program',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Menampilkan teks ke layar\' sesuai dengan konsep Struktur Dasar Program C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. Menerima input dari pengguna tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Menampilkan teks ke layar merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Membuat variabel tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghentikan program tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struktur Dasar Program C++'),
      MultipleChoiceQuestion(
          question:
          'Apa kesalahan pada kode int angka = 10 tanpa tanda titik koma?',
          options: [
            'main() tidak boleh digunakan',
            'Variabel tidak boleh bernama angka',
            'Kurang tanda titik koma (;)',
            'return 0 harus dihapus',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'Kurang tanda titik koma (;)\' sesuai dengan konsep Struktur Dasar Program C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. main() tidak boleh digunakan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Variabel tidak boleh bernama angka tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Kurang tanda titik koma (;) merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. return 0 harus dihapus tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struktur Dasar Program C++'),
    ],
    codingQuestion: null,
  ),

  // ============================================================
  // BAB 3
  // ============================================================
  ChapterEvaluation(
    chapter: 3,
    title: 'Fungsi Input dan Output',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'Dalam C++, perintah yang digunakan untuk menerima input dari pengguna adalah ...',
          options: [
            'cout',
            'cin',
            'print',
            'input',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'cin\' sesuai dengan konsep Input dan Output C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. cout tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. cin merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. print tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. input tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Input dan Output C++'),
      MultipleChoiceQuestion(
          question:
          'Fungsi cin >> umur; adalah ...',
          options: [
            'Menampilkan nilai umur',
            'Menghapus nilai umur',
            'Menerima input dan menyimpannya ke variabel umur',
            'Membuat variabel baru bernama umur',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'Menerima input dan menyimpannya ke variabel umur\' sesuai dengan konsep Input dan Output C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. Menampilkan nilai umur tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghapus nilai umur tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Menerima input dan menyimpannya ke variabel umur merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Membuat variabel baru bernama umur tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Input dan Output C++'),
      MultipleChoiceQuestion(
          question:
          'Perintah cout biasanya digunakan bersama operator ...',
          options: [
            '>>',
            '<<',
            '==',
            '&&',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'<<\' sesuai dengan konsep Input dan Output C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. >> tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. << merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. == tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. && tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Input dan Output C++'),
      MultipleChoiceQuestion(
          question:
          'Jika nama berisi "Budi", output dari cout << "Halo " << nama; adalah ...',
          options: [
            'Budi Halo',
            'Halo',
            'Halo Budi',
            'nama = Budi',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'Halo Budi\' sesuai dengan konsep Input dan Output C++ yang sedang diuji.',
          optionExplanations: [
            'Salah. Budi Halo tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Halo tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Halo Budi merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. nama = Budi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Input dan Output C++'),
      MultipleChoiceQuestion(
          question:
          'Keunggulan getline() dibandingkan cin >> nama adalah ...',
          options: [
            'Dapat membaca input yang terdiri dari beberapa kata',
            'Hanya dapat membaca angka',
            'Tidak membutuhkan variabel',
            'Digunakan untuk menampilkan output',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Dapat membaca input yang terdiri dari beberapa kata\' sesuai dengan konsep Input dan Output C++ yang sedang diuji.',
          optionExplanations: [
            'Benar. Dapat membaca input yang terdiri dari beberapa kata merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Hanya dapat membaca angka tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Tidak membutuhkan variabel tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Digunakan untuk menampilkan output tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Input dan Output C++'),
    ],
    codingQuestion: CodingQuestion(
        question:
        'Buat program C++ yang menerima input berupa nama dan umur, '
            'kemudian menampilkan kembali nama dan umur tersebut.',
        testCases: [
          CodingTestCase(
            input: 'Budi\n17',
            expectedOutput: 'Nama: Budi\nUmur: 17',
          ),
          CodingTestCase(
            input: 'Siti\n16',
            expectedOutput: 'Nama: Siti\nUmur: 16',
          ),
          CodingTestCase(
            input: 'Andi\n18',
            expectedOutput: 'Nama: Andi\nUmur: 18',
          ),
        ],
        concept: 'Input dan Output C++',
        expectedConcepts: [
          'cin',
          'getline',
          'cout',
          'string',
          'int',
        ],
        solutionCode: '#include <iostream>\n#include <string>\nusing namespace std;\n\nint main() {\n    string nama;\n    int umur;\n\n    getline(cin, nama);\n    cin >> umur;\n\n    cout << "Nama: " << nama << \'\\n\';\n    cout << "Umur: " << umur;\n\n    return 0;\n}',
        solutionExplanation: 'Program membaca nama menggunakan getline agar input teks dapat dibaca dengan baik, kemudian membaca umur dengan cin. Setelah itu cout digunakan untuk menampilkan kembali kedua data dengan format yang diminta.'),
  ),

  // ============================================================
  // BAB 4
  // ============================================================
  ChapterEvaluation(
    chapter: 4,
    title: 'Variabel, Konstanta, dan Tipe Data',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question: 'Dalam C++, variabel digunakan untuk ...',
          options: [
            'Menyimpan data yang nilainya dapat berubah',
            'Menjalankan compiler',
            'Menghapus program',
            'Menampilkan library',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Menyimpan data yang nilainya dapat berubah\' sesuai dengan konsep Variabel, Konstanta, dan Tipe Data yang sedang diuji.',
          optionExplanations: [
            'Benar. Menyimpan data yang nilainya dapat berubah merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Menjalankan compiler tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghapus program tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menampilkan library tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Variabel, Konstanta, dan Tipe Data'),
      MultipleChoiceQuestion(
          question:
          'Pernyataan yang benar untuk membuat variabel bertipe integer adalah ...',
          options: [
            'integer angka = 10;',
            'int angka = 10;',
            'angka int = 10;',
            'num angka = 10;',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'int angka = 10;\' sesuai dengan konsep Variabel, Konstanta, dan Tipe Data yang sedang diuji.',
          optionExplanations: [
            'Salah. integer angka = 10; tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. int angka = 10; merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. angka int = 10; tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. num angka = 10; tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Variabel, Konstanta, dan Tipe Data'),
      MultipleChoiceQuestion(
          question:
          'Tipe data yang digunakan untuk menyimpan bilangan pecahan adalah ...',
          options: [
            'int',
            'char',
            'float',
            'bool',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'float\' sesuai dengan konsep Variabel, Konstanta, dan Tipe Data yang sedang diuji.',
          optionExplanations: [
            'Salah. int tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. char tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. float merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. bool tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Variabel, Konstanta, dan Tipe Data'),
      MultipleChoiceQuestion(
          question:
          'Kata kunci const menunjukkan bahwa ...',
          options: [
            'Nilai dapat diubah kapan saja',
            'Nilai tidak dapat diubah setelah ditetapkan',
            'Variabel merupakan fungsi',
            'Variabel merupakan tipe data',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Nilai tidak dapat diubah setelah ditetapkan\' sesuai dengan konsep Variabel, Konstanta, dan Tipe Data yang sedang diuji.',
          optionExplanations: [
            'Salah. Nilai dapat diubah kapan saja tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Nilai tidak dapat diubah setelah ditetapkan merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Variabel merupakan fungsi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Variabel merupakan tipe data tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Variabel, Konstanta, dan Tipe Data'),
      MultipleChoiceQuestion(
          question:
          'Variabel yang menggunakan tipe data char adalah ...',
          options: [
            'int umur',
            'double tinggi',
            'char kelas',
            'bool aktif',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'char kelas\' sesuai dengan konsep Variabel, Konstanta, dan Tipe Data yang sedang diuji.',
          optionExplanations: [
            'Salah. int umur tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. double tinggi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. char kelas merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. bool aktif tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Variabel, Konstanta, dan Tipe Data'),
    ],
    codingQuestion: CodingQuestion(
        question:
        'Buat program C++ yang menerima harga satu barang dan jumlah barang, '
            'kemudian menghitung total harga.',
        testCases: [
          CodingTestCase(
            input: '15000.5\n3',
            expectedOutput: 'Total: 45001.5',
          ),
          CodingTestCase(
            input: '2500\n4',
            expectedOutput: 'Total: 10000',
          ),
          CodingTestCase(
            input: '12500\n2',
            expectedOutput: 'Total: 25000',
          ),
        ],
        concept: 'Variabel, Tipe Data, dan Operasi Aritmatika',
        expectedConcepts: [
          'double atau float',
          'int',
          'cin',
          'cout',
          'operator *',
        ],
        solutionCode: '#include <iostream>\nusing namespace std;\n\nint main() {\n    double harga;\n    int jumlah;\n\n    cin >> harga;\n    cin >> jumlah;\n\n    double total = harga * jumlah;\n\n    cout << "Total: " << total;\n\n    return 0;\n}',
        solutionExplanation: 'Harga menggunakan tipe pecahan agar nilai seperti 15000.5 dapat diproses. Jumlah menggunakan int. Total diperoleh dengan mengalikan harga dan jumlah.'),
  ),

  // ============================================================
  // BAB 5
  // ============================================================
  ChapterEvaluation(
    chapter: 5,
    title: 'Operator',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'Operator yang digunakan untuk melakukan penjumlahan adalah ...',
          options: [
            '-',
            '*',
            '+',
            '/',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'+\' sesuai dengan konsep Operator yang sedang diuji.',
          optionExplanations: [
            'Salah. - tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. * tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. + merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. / tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Operator'),
      MultipleChoiceQuestion(
          question:
          'Jika a = 10 dan b = 3, maka hasil dari a % b adalah ...',
          options: [
            '1',
            '2',
            '3',
            '3.33',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'1\' sesuai dengan konsep Operator yang sedang diuji.',
          optionExplanations: [
            'Benar. 1 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 2 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 3 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 3.33 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Operator'),
      MultipleChoiceQuestion(
          question:
          'Operator yang digunakan untuk membandingkan apakah dua nilai sama adalah ...',
          options: [
            '=',
            '==',
            '!=',
            '>=',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'==\' sesuai dengan konsep Operator yang sedang diuji.',
          optionExplanations: [
            'Salah. = tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. == merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. != tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. >= tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Operator'),
      MultipleChoiceQuestion(
          question:
          'Jika a = 8 dan b = 5, maka hasil dari (a > b) adalah ...',
          options: [
            '0',
            '1',
            '5',
            '8',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'1\' sesuai dengan konsep Operator yang sedang diuji.',
          optionExplanations: [
            'Salah. 0 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 1 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 5 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 8 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Operator'),
      MultipleChoiceQuestion(
          question:
          'Jika int nilai = 70; kemudian nilai += 10;, maka nilai menjadi ...',
          options: [
            '60',
            '70',
            '80',
            '710',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'80\' sesuai dengan konsep Operator yang sedang diuji.',
          optionExplanations: [
            'Salah. 60 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 70 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 80 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 710 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Operator'),
    ],
    codingQuestion: CodingQuestion(
        question:
        'Buat program C++ yang menerima dua bilangan bulat, kemudian '
            'menghitung penjumlahan, pengurangan, perkalian, dan sisa pembagian.',
        testCases: [
          CodingTestCase(
            input: '12\n5',
            expectedOutput:
            'Penjumlahan: 17\n'
                'Pengurangan: 7\n'
                'Perkalian: 60\n'
                'Sisa: 2',
          ),
          CodingTestCase(
            input: '20\n6',
            expectedOutput:
            'Penjumlahan: 26\n'
                'Pengurangan: 14\n'
                'Perkalian: 120\n'
                'Sisa: 2',
          ),
          CodingTestCase(
            input: '15\n4',
            expectedOutput:
            'Penjumlahan: 19\n'
                'Pengurangan: 11\n'
                'Perkalian: 60\n'
                'Sisa: 3',
          ),
        ],
        concept: 'Operator Aritmatika',
        expectedConcepts: [
          'int',
          'operator +',
          'operator -',
          'operator *',
          'operator %',
        ],
        solutionCode: '#include <iostream>\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a >> b;\n\n    cout << "Penjumlahan: " << a + b << \'\\n\';\n    cout << "Pengurangan: " << a - b << \'\\n\';\n    cout << "Perkalian: " << a * b << \'\\n\';\n    cout << "Sisa: " << a % b;\n\n    return 0;\n}',
        solutionExplanation: 'Program menggunakan operator +, -, *, dan % untuk menghitung empat operasi yang diminta. Operator % menghasilkan sisa pembagian bilangan bulat.'),
  ),

  // ============================================================
  // BAB 6
  // ============================================================
  ChapterEvaluation(
    chapter: 6,
    title: 'Percabangan',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'Struktur if dalam C++ digunakan untuk ...',
          options: [
            'Mengulang program',
            'Menentukan tindakan berdasarkan suatu kondisi',
            'Menyimpan banyak data',
            'Membuat fungsi baru',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Menentukan tindakan berdasarkan suatu kondisi\' sesuai dengan konsep Percabangan yang sedang diuji.',
          optionExplanations: [
            'Salah. Mengulang program tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Menentukan tindakan berdasarkan suatu kondisi merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Menyimpan banyak data tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Membuat fungsi baru tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Percabangan'),
      MultipleChoiceQuestion(
          question:
          'Jika nilai = 80 dan kondisi nilai >= 75, output yang dihasilkan adalah ...',
          options: [
            'Tidak Lulus',
            '75',
            'Lulus',
            'Tidak menghasilkan output',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'Lulus\' sesuai dengan konsep Percabangan yang sedang diuji.',
          optionExplanations: [
            'Salah. Tidak Lulus tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 75 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Lulus merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Tidak menghasilkan output tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Percabangan'),
      MultipleChoiceQuestion(
          question:
          'Struktur yang digunakan ketika terdapat dua kemungkinan kondisi adalah ...',
          options: [
            'if - else',
            'for - while',
            'switch - case saja',
            'do - while',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'if - else\' sesuai dengan konsep Percabangan yang sedang diuji.',
          optionExplanations: [
            'Benar. if - else merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. for - while tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. switch - case saja tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. do - while tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Percabangan'),
      MultipleChoiceQuestion(
          question:
          'Jika angka = 7 dan program mengecek angka % 2 == 0, hasilnya adalah ...',
          options: [
            'Genap',
            'Ganjil',
            '7',
            '0',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Ganjil\' sesuai dengan konsep Percabangan yang sedang diuji.',
          optionExplanations: [
            'Salah. Genap tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Ganjil merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 7 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 0 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Percabangan'),
      MultipleChoiceQuestion(
          question:
          'Struktur switch dalam C++ biasanya digunakan untuk ...',
          options: [
            'Melakukan percabangan berdasarkan beberapa pilihan nilai',
            'Mengulang kode tanpa batas',
            'Menyimpan data dalam array',
            'Mendeklarasikan pointer',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Melakukan percabangan berdasarkan beberapa pilihan nilai\' sesuai dengan konsep Percabangan yang sedang diuji.',
          optionExplanations: [
            'Benar. Melakukan percabangan berdasarkan beberapa pilihan nilai merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Mengulang kode tanpa batas tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menyimpan data dalam array tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Mendeklarasikan pointer tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Percabangan'),
    ],
    codingQuestion: CodingQuestion(
        question:
        'Buat program C++ yang menerima sebuah bilangan bulat. '
            'Program harus menentukan apakah bilangan tersebut positif, negatif, atau nol.',
        testCases: [
          CodingTestCase(
            input: '15',
            expectedOutput: 'Positif',
          ),
          CodingTestCase(
            input: '-8',
            expectedOutput: 'Negatif',
          ),
          CodingTestCase(
            input: '0',
            expectedOutput: 'Nol',
          ),
          CodingTestCase(
            input: '42',
            expectedOutput: 'Positif',
          ),
          CodingTestCase(
            input: '-25',
            expectedOutput: 'Negatif',
          ),
        ],
        concept: 'Percabangan if-else',
        expectedConcepts: [
          'if',
          'else if',
          'else',
          'operator > dan <',
          'perbandingan dengan 0',
        ],
        solutionCode: '#include <iostream>\nusing namespace std;\n\nint main() {\n    int angka;\n    cin >> angka;\n\n    if (angka > 0) {\n        cout << "Positif";\n    } else if (angka < 0) {\n        cout << "Negatif";\n    } else {\n        cout << "Nol";\n    }\n\n    return 0;\n}',
        solutionExplanation: 'Program membandingkan bilangan dengan 0. Jika lebih besar dari 0, hasilnya Positif; jika lebih kecil dari 0, hasilnya Negatif; selain itu berarti nilainya 0 sehingga hasilnya Nol.'),
  ),

  // ============================================================
  // BAB 7
  // ============================================================
  ChapterEvaluation(
    chapter: 7,
    title: 'Perulangan',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'Struktur perulangan digunakan dalam program untuk ...',
          options: [
            'Menjalankan suatu perintah secara berulang',
            'Membuat variabel baru',
            'Menghapus data',
            'Menghentikan compiler',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Menjalankan suatu perintah secara berulang\' sesuai dengan konsep Perulangan yang sedang diuji.',
          optionExplanations: [
            'Benar. Menjalankan suatu perintah secara berulang merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Membuat variabel baru tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghapus data tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghentikan compiler tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Perulangan'),
      MultipleChoiceQuestion(
          question:
          'Struktur perulangan yang umumnya digunakan ketika jumlah pengulangan sudah diketahui adalah ...',
          options: [
            'if',
            'switch',
            'for',
            'else',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'for\' sesuai dengan konsep Perulangan yang sedang diuji.',
          optionExplanations: [
            'Salah. if tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. switch tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. for merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. else tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Perulangan'),
      MultipleChoiceQuestion(
          question:
          'Apa output dari for (int i = 1; i <= 5; i++) cout << i << " ";?',
          options: [
            '0 1 2 3 4',
            '1 2 3 4 5',
            '1 2 3 4',
            '5 4 3 2 1',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'1 2 3 4 5\' sesuai dengan konsep Perulangan yang sedang diuji.',
          optionExplanations: [
            'Salah. 0 1 2 3 4 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 1 2 3 4 5 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 1 2 3 4 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 5 4 3 2 1 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Perulangan'),
      MultipleChoiceQuestion(
          question:
          'Perulangan while dengan i mulai dari 1 dan kondisi i <= 3 berjalan sebanyak ... kali.',
          options: [
            '1 kali',
            '2 kali',
            '3 kali',
            '4 kali',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'3 kali\' sesuai dengan konsep Perulangan yang sedang diuji.',
          optionExplanations: [
            'Salah. 1 kali tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 2 kali tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 3 kali merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 4 kali tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Perulangan'),
      MultipleChoiceQuestion(
          question:
          'Perbedaan utama while dan do-while adalah ...',
          options: [
            'while tidak dapat digunakan untuk perulangan',
            'do-while menjalankan blok program setidaknya satu kali',
            'while hanya dapat digunakan untuk angka',
            'do-while tidak memiliki kondisi',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'do-while menjalankan blok program setidaknya satu kali\' sesuai dengan konsep Perulangan yang sedang diuji.',
          optionExplanations: [
            'Salah. while tidak dapat digunakan untuk perulangan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. do-while menjalankan blok program setidaknya satu kali merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. while hanya dapat digunakan untuk angka tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. do-while tidak memiliki kondisi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Perulangan'),
    ],
    codingQuestion: CodingQuestion(
        question:
        'Buat program C++ yang menerima sebuah bilangan bulat N, '
            'kemudian menampilkan angka dari 1 sampai N menggunakan perulangan.',
        testCases: [
          CodingTestCase(
            input: '5',
            expectedOutput: '1 2 3 4 5',
          ),
          CodingTestCase(
            input: '8',
            expectedOutput: '1 2 3 4 5 6 7 8',
          ),
          CodingTestCase(
            input: '3',
            expectedOutput: '1 2 3',
          ),
          CodingTestCase(
            input: '10',
            expectedOutput: '1 2 3 4 5 6 7 8 9 10',
          ),
        ],
        concept: 'Perulangan for',
        expectedConcepts: [
          'for',
          'inisialisasi',
          'kondisi',
          'increment',
          'cout',
        ],
        solutionCode: '#include <iostream>\nusing namespace std;\n\nint main() {\n    int n;\n    cin >> n;\n\n    for (int i = 1; i <= n; i++) {\n        if (i > 1) cout << \' \';\n        cout << i;\n    }\n\n    return 0;\n}',
        solutionExplanation: 'Perulangan for dimulai dari 1 dan terus berjalan selama i <= n. Nilai i dinaikkan satu setiap iterasi sehingga semua angka dari 1 sampai N ditampilkan.'),
  ),

  // ============================================================
  // BAB 8
  // ============================================================
  ChapterEvaluation(
    chapter: 8,
    title: 'Struktur Data Array',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'Array dalam C++ digunakan untuk ...',
          options: [
            'Menyimpan beberapa data dengan tipe data yang sama',
            'Menjalankan program',
            'Membuat kondisi percabangan',
            'Menghentikan perulangan',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Menyimpan beberapa data dengan tipe data yang sama\' sesuai dengan konsep Array yang sedang diuji.',
          optionExplanations: [
            'Benar. Menyimpan beberapa data dengan tipe data yang sama merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Menjalankan program tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Membuat kondisi percabangan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghentikan perulangan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Array'),
      MultipleChoiceQuestion(
          question:
          'Array int angka[5]; memiliki ... elemen.',
          options: [
            '4',
            '5',
            '6',
            '10',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'5\' sesuai dengan konsep Array yang sedang diuji.',
          optionExplanations: [
            'Salah. 4 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 5 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 6 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 10 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Array'),
      MultipleChoiceQuestion(
          question:
          'Indeks pertama sebuah array dalam C++ dimulai dari ...',
          options: [
            '-1',
            '0',
            '1',
            '2',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'0\' sesuai dengan konsep Array yang sedang diuji.',
          optionExplanations: [
            'Salah. -1 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 0 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 1 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 2 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Array'),
      MultipleChoiceQuestion(
          question:
          'Jika int angka[4] = {10,20,30,40}; maka angka[2] bernilai ...',
          options: [
            '10',
            '20',
            '30',
            '40',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'30\' sesuai dengan konsep Array yang sedang diuji.',
          optionExplanations: [
            'Salah. 10 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 20 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 30 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 40 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Array'),
      MultipleChoiceQuestion(
          question:
          'Array angka = {5,10,15} yang ditampilkan menggunakan indeks 0 sampai 2 menghasilkan ...',
          options: [
            '0 1 2',
            '5 10 15',
            '10 15 20',
            '15 10 5',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'5 10 15\' sesuai dengan konsep Array yang sedang diuji.',
          optionExplanations: [
            'Salah. 0 1 2 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 5 10 15 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 10 15 20 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 15 10 5 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Array'),
    ],
    codingQuestion: CodingQuestion(
        question:
        'Buat program C++ yang menerima 5 bilangan bulat, menyimpannya '
            'ke dalam array, kemudian menampilkan seluruh nilai array dan '
            'menentukan nilai terbesar.',
        testCases: [
          CodingTestCase(
            input: '12\n7\n25\n10\n18',
            expectedOutput:
            'Data: 12 7 25 10 18\n'
                'Terbesar: 25',
          ),
          CodingTestCase(
            input: '4\n9\n2\n15\n6',
            expectedOutput:
            'Data: 4 9 2 15 6\n'
                'Terbesar: 15',
          ),
          CodingTestCase(
            input: '20\n5\n30\n8\n12',
            expectedOutput:
            'Data: 20 5 30 8 12\n'
                'Terbesar: 30',
          ),
        ],
        concept: 'Array dan Pencarian Nilai Terbesar',
        expectedConcepts: [
          'array',
          'for',
          'indeks array',
          'perbandingan',
          'nilai maksimum',
        ],
        solutionCode: '#include <iostream>\nusing namespace std;\n\nint main() {\n    int angka[5];\n\n    for (int i = 0; i < 5; i++) {\n        cin >> angka[i];\n    }\n\n    int terbesar = angka[0];\n\n    for (int i = 1; i < 5; i++) {\n        if (angka[i] > terbesar) {\n            terbesar = angka[i];\n        }\n    }\n\n    cout << "Data: ";\n    for (int i = 0; i < 5; i++) {\n        if (i > 0) cout << \' \';\n        cout << angka[i];\n    }\n\n    cout << \'\\n\';\n    cout << "Terbesar: " << terbesar;\n\n    return 0;\n}',
        solutionExplanation: 'Lima bilangan disimpan dalam array. Nilai terbesar dimulai dari elemen pertama, kemudian dibandingkan dengan elemen berikutnya sampai seluruh array diperiksa.'),
  ),

  // ============================================================
  // BAB 9
  // ============================================================
  ChapterEvaluation(
    chapter: 9,
    title: 'Prosedur dan Fungsi',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'Fungsi dalam C++ digunakan untuk ...',
          options: [
            'Mengelompokkan sekumpulan perintah untuk tugas tertentu',
            'Menyimpan semua data program',
            'Menghapus variabel',
            'Menghentikan compiler',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Mengelompokkan sekumpulan perintah untuk tugas tertentu\' sesuai dengan konsep Prosedur dan Fungsi yang sedang diuji.',
          optionExplanations: [
            'Benar. Mengelompokkan sekumpulan perintah untuk tugas tertentu merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Menyimpan semua data program tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghapus variabel tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menghentikan compiler tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Prosedur dan Fungsi'),
      MultipleChoiceQuestion(
          question:
          'Kata void menunjukkan bahwa fungsi tersebut ...',
          options: [
            'Mengembalikan nilai integer',
            'Tidak mengembalikan nilai',
            'Mengembalikan string',
            'Tidak dapat dipanggil',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Tidak mengembalikan nilai\' sesuai dengan konsep Prosedur dan Fungsi yang sedang diuji.',
          optionExplanations: [
            'Salah. Mengembalikan nilai integer tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Tidak mengembalikan nilai merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Mengembalikan string tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Tidak dapat dipanggil tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Prosedur dan Fungsi'),
      MultipleChoiceQuestion(
          question:
          'Cara memanggil fungsi tampilkanPesan() yang benar adalah ...',
          options: [
            'call tampilkanPesan();',
            'run tampilkanPesan();',
            'tampilkanPesan();',
            'function tampilkanPesan();',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'tampilkanPesan();\' sesuai dengan konsep Prosedur dan Fungsi yang sedang diuji.',
          optionExplanations: [
            'Salah. call tampilkanPesan(); tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. run tampilkanPesan(); tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. tampilkanPesan(); merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. function tampilkanPesan(); tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Prosedur dan Fungsi'),
      MultipleChoiceQuestion(
          question:
          'Jika fungsi int tambah(int a, int b) mengembalikan a + b, '
              'maka hasil tambah(5,3) adalah ...',
          options: [
            '2',
            '8',
            '15',
            '53',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'8\' sesuai dengan konsep Prosedur dan Fungsi yang sedang diuji.',
          optionExplanations: [
            'Salah. 2 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 8 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 15 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 53 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Prosedur dan Fungsi'),
      MultipleChoiceQuestion(
          question:
          'Pada fungsi int luasPersegi(int sisi), parameter fungsi tersebut adalah ...',
          options: [
            'luasPersegi',
            'int',
            'sisi',
            'sisi * sisi',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'sisi\' sesuai dengan konsep Prosedur dan Fungsi yang sedang diuji.',
          optionExplanations: [
            'Salah. luasPersegi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. int tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. sisi merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. sisi * sisi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Prosedur dan Fungsi'),
    ],
    codingQuestion: CodingQuestion(
        question:
        'Buat program C++ yang memiliki sebuah fungsi untuk menghitung '
            'luas persegi panjang. Fungsi menerima panjang dan lebar sebagai parameter.',
        testCases: [
          CodingTestCase(
            input: '8\n5',
            expectedOutput: 'Luas: 40',
          ),
          CodingTestCase(
            input: '12\n4',
            expectedOutput: 'Luas: 48',
          ),
          CodingTestCase(
            input: '7\n6',
            expectedOutput: 'Luas: 42',
          ),
          CodingTestCase(
            input: '10\n10',
            expectedOutput: 'Luas: 100',
          ),
        ],
        concept: 'Fungsi dengan Parameter dan Nilai Kembalian',
        expectedConcepts: [
          'fungsi',
          'parameter',
          'return',
          'perkalian',
          'pemanggilan fungsi',
        ],
        solutionCode: '#include <iostream>\nusing namespace std;\n\nint luasPersegiPanjang(int panjang, int lebar) {\n    return panjang * lebar;\n}\n\nint main() {\n    int panjang, lebar;\n    cin >> panjang;\n    cin >> lebar;\n\n    cout << "Luas: " << luasPersegiPanjang(panjang, lebar);\n\n    return 0;\n}',
        solutionExplanation: 'Fungsi luasPersegiPanjang menerima panjang dan lebar sebagai parameter, lalu mengembalikan hasil perkalian keduanya menggunakan return. Fungsi tersebut dipanggil dari main().'),
  ),

  // ============================================================
  // BAB 10
  // ============================================================
  ChapterEvaluation(
    chapter: 10,
    title: 'Tipe Data Enum',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'enum dalam C++ digunakan untuk ...',
          options: [
            'Membuat tipe data dengan sekumpulan nilai yang telah ditentukan',
            'Menyimpan banyak karakter',
            'Melakukan perulangan',
            'Membuat array dua dimensi',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Membuat tipe data dengan sekumpulan nilai yang telah ditentukan\' sesuai dengan konsep Enum yang sedang diuji.',
          optionExplanations: [
            'Benar. Membuat tipe data dengan sekumpulan nilai yang telah ditentukan merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Menyimpan banyak karakter tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Melakukan perulangan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Membuat array dua dimensi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Enum'),
      MultipleChoiceQuestion(
          question:
          'enum Hari { SENIN, SELASA, RABU }; membuat Hari sebagai ...',
          options: [
            'Variabel',
            'Fungsi',
            'Tipe data enum',
            'Array',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'Tipe data enum\' sesuai dengan konsep Enum yang sedang diuji.',
          optionExplanations: [
            'Salah. Variabel tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Fungsi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Tipe data enum merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Array tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Enum'),
      MultipleChoiceQuestion(
          question:
          'Jika enum Level { MUDAH, SEDANG, SULIT }; maka Level tingkat = SEDANG; '
              'menyimpan nilai ...',
          options: [
            'MUDAH',
            'SEDANG',
            'SULIT',
            'Level',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'SEDANG\' sesuai dengan konsep Enum yang sedang diuji.',
          optionExplanations: [
            'Salah. MUDAH tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. SEDANG merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. SULIT tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Level tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Enum'),
      MultipleChoiceQuestion(
          question:
          'Jika tidak diberikan nilai secara khusus, enumerator pertama secara default bernilai ...',
          options: [
            '-1',
            '0',
            '1',
            '10',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'0\' sesuai dengan konsep Enum yang sedang diuji.',
          optionExplanations: [
            'Salah. -1 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 0 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. 1 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. 10 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Enum'),
      MultipleChoiceQuestion(
          question:
          'Manakah deklarasi variabel enum yang benar?',
          options: [
            'enum = AKTIF;',
            'Status status = AKTIF;',
            'status Status = AKTIF;',
            'Status = status(AKTIF);',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Status status = AKTIF;\' sesuai dengan konsep Enum yang sedang diuji.',
          optionExplanations: [
            'Salah. enum = AKTIF; tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Status status = AKTIF; merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. status Status = AKTIF; tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Status = status(AKTIF); tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Enum'),
    ],
    codingQuestion: null,
  ),

  // ============================================================
  // BAB 11
  // ============================================================
  ChapterEvaluation(
    chapter: 11,
    title: 'Tipe Data Structure',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'struct dalam C++ digunakan untuk ...',
          options: [
            'Mengelompokkan beberapa data yang dapat memiliki tipe berbeda',
            'Melakukan perulangan program',
            'Membuat kondisi percabangan',
            'Menjalankan compiler',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Mengelompokkan beberapa data yang dapat memiliki tipe berbeda\' sesuai dengan konsep Struct yang sedang diuji.',
          optionExplanations: [
            'Benar. Mengelompokkan beberapa data yang dapat memiliki tipe berbeda merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Melakukan perulangan program tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Membuat kondisi percabangan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Menjalankan compiler tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struct'),
      MultipleChoiceQuestion(
          question:
          'struct Siswa { string nama; int umur; }; membuat Siswa sebagai ...',
          options: [
            'Variabel',
            'Fungsi',
            'Tipe data structure',
            'Operator',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'Tipe data structure\' sesuai dengan konsep Struct yang sedang diuji.',
          optionExplanations: [
            'Salah. Variabel tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Fungsi tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Tipe data structure merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Operator tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struct'),
      MultipleChoiceQuestion(
          question:
          'Jika Barang barang1; memiliki anggota harga, cara mengaksesnya adalah ...',
          options: [
            'barang1 -> harga',
            'Barang.harga',
            'barang1.harga',
            'harga.barang1',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'barang1.harga\' sesuai dengan konsep Struct yang sedang diuji.',
          optionExplanations: [
            'Salah. barang1 -> harga tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Barang.harga tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. barang1.harga merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. harga.barang1 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struct'),
      MultipleChoiceQuestion(
          question:
          'Salah satu kelebihan struct adalah ...',
          options: [
            'Hanya dapat menyimpan integer',
            'Dapat menggabungkan beberapa data dengan tipe berbeda',
            'Tidak dapat dibuat menjadi variabel',
            'Hanya dapat digunakan dalam perulangan',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Dapat menggabungkan beberapa data dengan tipe berbeda\' sesuai dengan konsep Struct yang sedang diuji.',
          optionExplanations: [
            'Salah. Hanya dapat menyimpan integer tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Dapat menggabungkan beberapa data dengan tipe berbeda merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Tidak dapat dibuat menjadi variabel tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Hanya dapat digunakan dalam perulangan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struct'),
      MultipleChoiceQuestion(
          question:
          'Jika buku1.halaman = 120;, maka nilai buku1.halaman adalah ...',
          options: [
            '0',
            '120',
            'Pemrograman',
            'Buku',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'120\' sesuai dengan konsep Struct yang sedang diuji.',
          optionExplanations: [
            'Salah. 0 tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. 120 merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Pemrograman tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Buku tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Struct'),
    ],
    codingQuestion: CodingQuestion(
        question:
        'Buat program C++ menggunakan struct untuk menyimpan data sebuah barang '
            'berupa nama barang, harga barang, dan stok barang. '
            'Kemudian tampilkan seluruh data tersebut.',
        testCases: [
          CodingTestCase(
            input: 'Buku\n12000\n15',
            expectedOutput:
            'Nama: Buku\n'
                'Harga: 12000\n'
                'Stok: 15',
          ),
          CodingTestCase(
            input: 'Pensil\n3000\n20',
            expectedOutput:
            'Nama: Pensil\n'
                'Harga: 3000\n'
                'Stok: 20',
          ),
          CodingTestCase(
            input: 'Penghapus\n2500\n10',
            expectedOutput:
            'Nama: Penghapus\n'
                'Harga: 2500\n'
                'Stok: 10',
          ),
        ],
        concept: 'Struct',
        expectedConcepts: [
          'struct',
          'string',
          'int',
          'anggota struct',
          'operator titik',
        ],
        solutionCode: '#include <iostream>\n#include <string>\nusing namespace std;\n\nstruct Barang {\n    string nama;\n    int harga;\n    int stok;\n};\n\nint main() {\n    Barang barang;\n\n    getline(cin, barang.nama);\n    cin >> barang.harga;\n    cin >> barang.stok;\n\n    cout << "Nama: " << barang.nama << \'\\n\';\n    cout << "Harga: " << barang.harga << \'\\n\';\n    cout << "Stok: " << barang.stok;\n\n    return 0;\n}',
        solutionExplanation: 'Struct Barang mengelompokkan nama, harga, dan stok dalam satu tipe data. Anggota struct diakses menggunakan operator titik, misalnya barang.nama dan barang.harga.'),
  ),

  // ============================================================
  // BAB 12
  // ============================================================
  ChapterEvaluation(
    chapter: 12,
    title: 'Tipe Data Union',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
          question:
          'union dalam C++ digunakan untuk ...',
          options: [
            'Menyimpan beberapa nilai dengan ruang memori terpisah',
            'Menyimpan beberapa anggota data dalam satu lokasi memori yang sama',
            'Membuat perulangan',
            'Membuat percabangan',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Menyimpan beberapa anggota data dalam satu lokasi memori yang sama\' sesuai dengan konsep Union yang sedang diuji.',
          optionExplanations: [
            'Salah. Menyimpan beberapa nilai dengan ruang memori terpisah tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Menyimpan beberapa anggota data dalam satu lokasi memori yang sama merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Membuat perulangan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Membuat percabangan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Union'),
      MultipleChoiceQuestion(
          question:
          'Anggota-anggota sebuah union ...',
          options: [
            'Memiliki lokasi memori yang sama',
            'Selalu memiliki lokasi memori berbeda',
            'Tidak dapat digunakan',
            'Harus memiliki tipe data yang sama',
          ],
          correctAnswer: 0,
          explanation: 'Jawaban yang tepat adalah A karena \'Memiliki lokasi memori yang sama\' sesuai dengan konsep Union yang sedang diuji.',
          optionExplanations: [
            'Benar. Memiliki lokasi memori yang sama merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Selalu memiliki lokasi memori berbeda tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Tidak dapat digunakan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Harus memiliki tipe data yang sama tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Union'),
      MultipleChoiceQuestion(
          question:
          'Jika data.angka = 100; maka anggota union yang sedang digunakan adalah ...',
          options: [
            'Data',
            'huruf',
            'angka',
            'data',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'angka\' sesuai dengan konsep Union yang sedang diuji.',
          optionExplanations: [
            'Salah. Data tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. huruf tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. angka merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. data tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Union'),
      MultipleChoiceQuestion(
          question:
          'Perbedaan utama struct dan union adalah ...',
          options: [
            'struct hanya dapat memiliki satu anggota',
            'union tidak dapat memiliki anggota data',
            'Anggota struct memiliki penyimpanan masing-masing, sedangkan union berbagi lokasi memori',
            'struct dan union tidak memiliki perbedaan',
          ],
          correctAnswer: 2,
          explanation: 'Jawaban yang tepat adalah C karena \'Anggota struct memiliki penyimpanan masing-masing, sedangkan union berbagi lokasi memori\' sesuai dengan konsep Union yang sedang diuji.',
          optionExplanations: [
            'Salah. struct hanya dapat memiliki satu anggota tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. union tidak dapat memiliki anggota data tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Anggota struct memiliki penyimpanan masing-masing, sedangkan union berbagi lokasi memori merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. struct dan union tidak memiliki perbedaan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Union'),
      MultipleChoiceQuestion(
          question:
          'Pada penggunaan union, pada satu waktu penggunaan yang tepat adalah ...',
          options: [
            'Semua anggota menyimpan nilai independen secara bersamaan',
            'Salah satu anggota digunakan sebagai nilai aktif',
            'Tidak ada anggota yang dapat digunakan',
            'Semua anggota harus bertipe int',
          ],
          correctAnswer: 1,
          explanation: 'Jawaban yang tepat adalah B karena \'Salah satu anggota digunakan sebagai nilai aktif\' sesuai dengan konsep Union yang sedang diuji.',
          optionExplanations: [
            'Salah. Semua anggota menyimpan nilai independen secara bersamaan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Benar. Salah satu anggota digunakan sebagai nilai aktif merupakan jawaban yang sesuai dengan konsep yang ditanyakan.',
            'Salah. Tidak ada anggota yang dapat digunakan tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
            'Salah. Semua anggota harus bertipe int tidak sesuai dengan konsep yang ditanyakan pada soal ini.',
          ],
          concept: 'Union'),
    ],
    codingQuestion: null,
  ),

  // ============================================================
  // BAB 13 - UJIAN AKHIR
  // ============================================================
  ChapterEvaluation(
    chapter: 13,
    title: 'Ujian Akhir Bab 13',
    multipleChoiceQuestions: [
      MultipleChoiceQuestion(
        question: 'Apa fungsi operator & pada pointer C++?',
        options: ['Menghapus variabel', 'Mengambil alamat memori variabel', 'Membuat perulangan', 'Mencetak teks'],
        correctAnswer: 1,
        explanation: 'Operator & digunakan untuk mendapatkan alamat memori suatu variabel.',
        optionExplanations: ['Salah.', 'Benar.', 'Salah.', 'Salah.'],
        concept: 'Pointer',
      ),
      MultipleChoiceQuestion(
        question: 'Apa fungsi operator * saat digunakan pada pointer?',
        options: ['Dereference untuk mengambil nilai pada alamat yang ditunjuk', 'Membuat class', 'Membuat array', 'Mengakhiri program'],
        correctAnswer: 0,
        explanation: 'Operator * digunakan untuk dereference pointer.',
        optionExplanations: ['Benar.', 'Salah.', 'Salah.', 'Salah.'],
        concept: 'Pointer',
      ),
      MultipleChoiceQuestion(
        question: 'Manakah konsep yang dipakai untuk menyimpan banyak data dengan tipe yang sama?',
        options: ['Array', 'Enum', 'Union', 'Pointer'],
        correctAnswer: 0,
        explanation: 'Array menyimpan kumpulan data dengan tipe yang sama.',
        optionExplanations: ['Benar.', 'Salah.', 'Salah.', 'Salah.'],
        concept: 'Array',
      ),
      MultipleChoiceQuestion(
        question: 'Perintah C++ yang umum digunakan untuk output adalah ...',
        options: ['cin', 'cout', 'input', 'scan'],
        correctAnswer: 1,
        explanation: 'cout digunakan untuk menampilkan output ke console.',
        optionExplanations: ['Salah.', 'Benar.', 'Salah.', 'Salah.'],
        concept: 'Input Output',
      ),
      MultipleChoiceQuestion(
        question: 'Tipe data yang tepat untuk menyimpan bilangan bulat adalah ...',
        options: ['int', 'char', 'bool', 'string'],
        correctAnswer: 0,
        explanation: 'int digunakan untuk bilangan bulat.',
        optionExplanations: ['Benar.', 'Salah.', 'Salah.', 'Salah.'],
        concept: 'Tipe Data',
      ),
      MultipleChoiceQuestion(
        question: 'Struktur yang digunakan untuk memilih aksi berdasarkan kondisi adalah ...',
        options: ['if/else', 'include', 'return', 'namespace'],
        correctAnswer: 0,
        explanation: 'if/else digunakan untuk percabangan berdasarkan kondisi.',
        optionExplanations: ['Benar.', 'Salah.', 'Salah.', 'Salah.'],
        concept: 'Percabangan',
      ),
      MultipleChoiceQuestion(
        question: 'Struktur yang digunakan untuk mengulang instruksi adalah ...',
        options: ['loop/perulangan', 'class', 'struct', 'enum'],
        correctAnswer: 0,
        explanation: 'Perulangan digunakan untuk menjalankan instruksi berulang kali.',
        optionExplanations: ['Benar.', 'Salah.', 'Salah.', 'Salah.'],
        concept: 'Perulangan',
      ),
      MultipleChoiceQuestion(
        question: 'Kata kunci untuk mendefinisikan struct adalah ...',
        options: ['struct', 'record', 'data', 'object'],
        correctAnswer: 0,
        explanation: 'struct adalah kata kunci C++ untuk membuat tipe data bentukan.',
        optionExplanations: ['Benar.', 'Salah.', 'Salah.', 'Salah.'],
        concept: 'Structure',
      ),
      MultipleChoiceQuestion(
        question: 'Kata kunci untuk mendefinisikan enum adalah ...',
        options: ['enum', 'enumerate', 'choice', 'option'],
        correctAnswer: 0,
        explanation: 'enum digunakan untuk membuat tipe data enumerasi.',
        optionExplanations: ['Benar.', 'Salah.', 'Salah.', 'Salah.'],
        concept: 'Enum',
      ),
      MultipleChoiceQuestion(
        question: 'Apa ciri utama union?',
        options: ['Setiap member memiliki memori terpisah', 'Member berbagi lokasi memori yang sama', 'Tidak menggunakan memori', 'Hanya bisa berisi string'],
        correctAnswer: 1,
        explanation: 'Member union menggunakan lokasi memori yang sama.',
        optionExplanations: ['Salah.', 'Benar.', 'Salah.', 'Salah.'],
        concept: 'Union',
      ),
    ],
    codingQuestion: null,
    finalProject: null,
  ),
];