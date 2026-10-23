import '../../models/chapter.dart';
import '../../models/task.dart';

final List<Chapter> sampleChapters = [
  // BAB 1
  Chapter(
    id: '1',
    title: 'Belajar C++ #01: Pengenalan Bahasa Pemrograman C++',
    description: 'Sejarah, karakteristik bahasa C++, dan persiapan lingkungan coding.',
    videoUrl: 'KjWbfkWqR4Y',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
C++ adalah salah satu bahasa pemrograman paling populer di dunia, diciptakan oleh Bjarne Stroustrup pada tahun 1979 sebagai pengembangan dari bahasa C. C++ banyak digunakan dalam pembuatan sistem operasi, game engine, aplikasi desktop, hingga sistem tertanam (embedded system).

Mengapa Siswa RPL Belajar C++?
1. Kecepatan Eksekusi yang Tinggi: Sangat dekat dengan perangkat keras.
2. Memahami Manajemen Memori: Membantu memahami cara kerja komputer secara mendalam.
3. Fondasi OOP (Object-Oriented Programming): Memudahkan belajar bahasa modern lain seperti Java, C#, atau Dart.

Alat Kerja (IDE/Compiler):
- G++ Compiler (MinGW untuk Windows)
- Code::Blocks, VS Code, atau Replit (Online)
''',
    tasks: [
      QuizTask(id: '1_q1', question: 'Siapa tokoh yang memelopori dan menciptakan bahasa pemrograman C++?', options: ['Dennis Ritchie', 'Bjarne Stroustrup', 'James Gosling', 'Guido van Rossum'], correctIndex: 1),
      QuizTask(id: '1_q2', question: 'Pada tahun berapakah pengembangan awal bahasa C++ dimulai?', options: ['1972', '1979', '1991', '1995'], correctIndex: 1),
      QuizTask(id: '1_q3', question: 'Bahasa pemrograman C++ merupakan pengembangan dari bahasa apa?', options: ['Bahasa B', 'Bahasa C', 'Java', 'Assembly'], correctIndex: 1),
      QuizTask(id: '1_q4', question: 'Di bawah ini yang BUKAN merupakan fungsi atau kegunaan utama dari C++ adalah...', options: ['Pembuatan Game Engine', 'Pembuatan Sistem Operasi', 'Pembuatan Desain Grafis Vector', 'Sistem Tertanam (Embedded)'], correctIndex: 2),
      QuizTask(id: '1_q5', question: 'Manakah dari pilihan berikut yang merupakan compiler populer untuk menjalankan kode C++?', options: ['G++', 'Python Interpreter', 'Node.js', 'JDK'], correctIndex: 0),
      PracticeTask(id: '1_p1', description: 'Buatlah sebuah program C++ yang mencetak teks kalimat sambutan "Selamat Datang di CraftC++" ke layar console.', expectedOutput: 'Selamat Datang di CraftC++', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nint main() {\n    cout << "Selamat Datang di CraftC++";\n    return 0;\n}'),
    ],
  ),

  // BAB 2
  Chapter(
    id: '2',
    title: 'Belajar C++ #02: Struktur Dasar Program C++ yang Harus Dipahami',
    description: 'Memahami header file, fungsi main(), blok kode, dan penulisan sintaks wajib.',
    videoUrl: 'fS-ec0KaGB8',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Setiap program C++ memiliki struktur wajib agar compiler dapat menerjemahkan kode menjadi aplikasi.

Berikut adalah anatomi struktur dasar program C++:
1. Header (#include <iostream>)
Komponen ini bertugas menyertakan pustaka standar (library) ke dalam program. `iostream` digunakan agar kita bisa menggunakan fungsi input dan output.
2. Namespace (using namespace std;)
Digunakan untuk memberitahu compiler bahwa kita akan menggunakan fungsi-fungsi dari namespace standar (seperti `cout`, `cin`) tanpa perlu menuliskan `std::` secara berulang-ulang.
3. Fungsi Utama (int main())
Gerbang utama eksekusi program. Semua kode di dalam kurung kurawal fungsi ini akan dijalankan pertama kali oleh komputer.
4. Statement & Titik Koma (;)
Setiap baris instruksi di C++ wajib diakhiri dengan tanda titik koma (Semicolon).

Contoh Kode Lengkap:
#include <iostream>
using namespace std;

int main() {
    cout << "Halo Dunia!";
    return 0;
}
''',
    tasks: [
      QuizTask(id: '2_q1', question: 'Setiap baris instruksi/pernyataan di dalam bahasa C++ wajib diakhiri dengan tanda...', options: ['; (Titik Koma)', ': (Titik Dua)', '. (Titik)', ', (Koma)'], correctIndex: 0),
      QuizTask(id: '2_q2', question: 'Library standar apakah yang wajib disertakan untuk melakukan operasi input dan output data?', options: ['cmath', 'iostream', 'string', 'fstream'], correctIndex: 1),
      QuizTask(id: '2_q3', question: 'Fungsi apakah yang menjadi titik awal/gerbang utama jalannya setiap program C++?', options: ['void start()', 'int main()', 'void main()', 'include()'], correctIndex: 1),
      QuizTask(id: '2_q4', question: 'Apa kegunaan dari menuliskan baris "using namespace std;" di awal program?', options: ['Mempercepat jalannya komputer', 'Membuka koneksi database', 'Menghindari penulisan std:: berulang kali', 'Membuat variabel otomatis'], correctIndex: 2),
      QuizTask(id: '2_q5', question: 'Tanda kurung apakah yang dipakai untuk membungkus suatu kelompok blok kode instruksi?', options: ['( )', '[ ]', '{ }', '< >'], correctIndex: 2),
      PracticeTask(id: '2_p1', description: 'Buatlah program terstruktur yang mencetak dua baris kalimat teks: baris pertama "Belajar C++" and baris kedua "Sangat Mudah".', expectedOutput: 'Belajar C++\nSangat Mudah', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nint main() {\n    cout << "Belajar C++\\nSangat Mudah";\n    return 0;\n}'),
    ],
  ),

  // BAB 3
  Chapter(
    id: '3',
    title: 'Belajar C++ #03: Fungsi Input dan Output',
    description: 'Menguasai perintah objek cout untuk menampilkan data dan cin untuk menerima input.',
    videoUrl: 'VRqfitH1cLw',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Program yang interaktif membutuhkan komunikasi dua arah: menampilkan informasi ke siswa (Output) dan menerima ketikan keyboard dari siswa (Input).

1. Fungsi Output (cout)
`cout` singkatan dari Console Output. Digunakan bersama dengan operator insertion `<<`.
2. Fungsi Input (cin)
`cin` singkatan dari Console Input. Digunakan bersama dengan operator extraction `>>` untuk membaca input lalu menyimpannya ke dalam variabel.
3. Baris Baru (endl / \n)
Untuk memindahkan kursor cetak ke baris baru, Anda bisa memakai objek `endl` atau karakter escape `\n`.
''',
    tasks: [
      QuizTask(id: '3_q1', question: 'Pasangan objek dan operator yang benar untuk menampilkan teks output ke layar adalah...', options: ['cout >>', 'cout <<', 'cin >>', 'cin <<'], correctIndex: 1),
      QuizTask(id: '3_q2', question: 'Objek apakah yang digunakan untuk menangkap input ketikan nilai dari keyboard user?', options: ['cout', 'cin', 'print', 'scan'], correctIndex: 1),
      QuizTask(id: '3_q3', question: 'Operator pembaca input "cin" menggunakan simbol panah ke arah mana?', options: ['<<', '>>', '==', '++'], correctIndex: 1),
      QuizTask(id: '3_q4', question: 'Manakah perintah di bawah ini yang berfungsi untuk menyisipkan baris baru (pindah baris)?', options: ['endl', '\\t', 'system("clear")', 'void'], correctIndex: 0),
      QuizTask(id: '3_q5', question: 'Jika ingin menampilkan teks kalimat dan nilai variabel sekaligus dalam satu baris cout, pembatasnya adalah...', options: ['Tanda koma (,)', 'Tanda titik koma (;)', 'Operator insertion << berulang', 'Tanda tambah (+)'], correctIndex: 2),
      PracticeTask(id: '3_p1', description: 'Simulasikan output program yang langsung mencetak hasil gabungan variabel angka: "Angka Saya: 7".', expectedOutput: 'Angka Saya: 7', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nint main() {\n    int angka = 7;\n    cout << "Angka Saya: " << angka;\n    return 0;\n}'),
    ],
  ),

  // BAB 4
  Chapter(
    id: '4',
    title: 'Belajar C++ #04: Variabel, Konstanta, dan Tipe Data',
    description: 'Mendefinisikan penyimpanan memori dengan tipe int, float, char, bool, dan konstanta const.',
    videoUrl: 'goXmjziRwUo',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Saat membuat aplikasi, kita perlu menyimpan data sementara di memori komputer. Di sinilah kita memakai Variabel dan Konstanta.

1. Variabel
Nama lokasi memori yang nilainya bisa berubah-ubah selama program berjalan.
2. Konstanta
Sama seperti variabel, namun nilainya bersifat mutlak/permanen dan tidak bisa diubah setelah didefinisikan. Dibuat dengan kata kunci `const`.
3. Tipe Data Populer di C++:
- `int`: Menyimpan bilangan bulat (contoh: 12, -450, 88).
- `float` / `double`: Menyimpan bilangan desimal/pecahan (contoh: 3.14).
- `char`: Menyimpan SATU karakter tunggal, diapit tanda kutip satu.
- `string`: Menyimpan kumpulan teks kalimat, diapit kutip dua.
- `bool`: Tipe logika, hanya bernilai `true` atau `false`.
''',
    tasks: [
      QuizTask(id: '4_q1', question: 'Manakah dari tipe data berikut yang paling tepat untuk menyimpan angka desimal pecahan seperti rata-rata nilai?', options: ['int', 'char', 'double', 'bool'], correctIndex: 2),
      QuizTask(id: '4_q2', question: 'Kata kunci apakah yang ditambahkan di depan deklarasi variabel agar nilainya menjadi permanen (Konstanta)?', options: ['static', 'const', 'final', 'stable'], correctIndex: 1),
      QuizTask(id: '4_q3', question: 'Tipe data manakah yang hanya bisa menampung satu karakter huruf tunggal seperti nilai abjad grade ujian?', options: ['string', 'int', 'char', 'float'], correctIndex: 2),
      QuizTask(id: '4_q4', question: 'Bagaimana penulisan nilai awal tipe data char yang benar di dalam kode C++?', options: ['\'A\' (Kutip Tunggal)', '"A" (Kutip Ganda)', '[A] (Kurung Siku)', 'A (Tanpa Kutip)'], correctIndex: 0),
      QuizTask(id: '4_q5', question: 'Berapakah nilai default biner di memori komputer yang merepresentasikan kondisi logika true?', options: ['-1', '0', '1', 'Null'], correctIndex: 2),
      PracticeTask(id: '4_p1', description: 'Buatlah sebuah program yang memiliki sebuah variabel bertipe integer bernama "umur" dengan nilai 17, lalu tampilkan teks: "Umurku 17 tahun".', expectedOutput: 'Umurku 17 tahun', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nint main() {\n    int umur = 17;\n    cout << "Umurku " << umur << " tahun";\n    return 0;\n}'),
    ],
  ),

  // BAB 5
  Chapter(
    id: '5',
    title: 'Belajar C++ #05: Operator',
    description: 'Menggunakan operator aritmatika, pembanding, dan operasi sisa bagi (modulus).',
    videoUrl: 'CegiCMF4Ljg',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Operator adalah simbol khusus yang digunakan untuk memanipulasi data dan melakukan operasi matematika atau logika.

1. Operator Aritmatika
`+` (Penjumlahan), `-` (Pengurangan), `*` (Perkalian), `/` (Pembagian), `%` (Modulus / Sisa Bagi).
2. Operator Pembanding (Relasional)
Menghasilkan nilai boolean (true/false): `==`, `!=`, `>`, `<`, `>=`, `<=`
3. Operator Penugasan (Assignment)
Mengisi nilai ke variabel: `=`, `+=`, `-=`, `*=`, `/=`
''',
    tasks: [
      QuizTask(id: '5_q1', question: 'Simbol operator manakah yang digunakan untuk mencari hasil sisa bagi (Modulus)?', options: ['/', '*', '%', '^'], correctIndex: 2),
      QuizTask(id: '5_q2', question: 'Berapakah hasil operasi dari ekspresi matematika 10 % 3 di dalam C++?', options: ['1', '2', '3', '0'], correctIndex: 0),
      QuizTask(id: '5_q3', question: 'Operator relasional manakah yang digunakan untuk mengecek apakah dua buah nilai bermakna "Sama Dengan"?', options: ['=', '==', '!=', '==='], correctIndex: 1),
      QuizTask(id: '5_q4', question: 'Jika int x = 5; lalu kita mengeksekusi instruksi x += 3;, berapakah nilai variabel x sekarang?', options: ['3', '5', '8', '15'], correctIndex: 2),
      QuizTask(id: '5_q5', question: 'Manakah dari operator berikut yang termasuk operator logika "DAN" (And)?', options: ['||', '&&', '!', '++'], correctIndex: 1),
      PracticeTask(id: '5_p1', description: 'Buatlah program yang menghitung perkalian antara angka 5 and 6 secara langsung di dalam cout, sehingga menghasilkan output nilai angka: 30.', expectedOutput: '30', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nint main() {\n    cout << 5 * 6;\n    return 0;\n}'),
    ],
  ),

  // BAB 6
  Chapter(
    id: '6',
    title: 'Belajar C++ #06: Percabangan',
    description: 'Mengontrol alur keputusan kode dengan struktur if, else if, else, dan switch case.',
    videoUrl: 't0QmgEFWWTg',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Percabangan memungkinkan program memilih jalur kode mana yang harus dijalankan berdasarkan suatu syarat/kondisi tertentu.

1. Struktur If Tunggal: Kode dijalankan HANYA JIKA kondisi bernilai true.
2. Struktur If-Else: Menyediakan jalur alternatif jika kondisi bernilai false (salah).
3. Struktur Else-If Multi Kondisi: Digunakan jika pilihan kondisi yang diuji lebih dari dua jalur.
4. Struktur Switch-Case: Sangat cocok untuk percabangan menu dengan nilai perbandingan yang pasti (bertipe integer atau char).
''',
    tasks: [
      QuizTask(id: '6_q1', question: 'Kata kunci logika percabangan yang dipanggil sebagai jalur alternatif terakhir jika seluruh kondisi if bernilai salah adalah...', options: ['then', 'else', 'switch', 'break'], correctIndex: 1),
      QuizTask(id: '6_q2', question: 'Struktur percabangan manakah yang paling direkomendasikan untuk menguji menu pilihan angka yang bersifat mutlak?', options: ['if tunggal', 'if-else', 'switch-case', 'while-loop'], correctIndex: 2),
      QuizTask(id: '6_q3', question: 'Setiap akhir blok pilihan pada "switch-case" wajib diberi kata kunci apa agar eksekusi tidak melorot ke pilihan bawahnya?', options: ['continue', 'exit', 'return', 'break'], correctIndex: 3),
      QuizTask(id: '6_q4', question: 'Kondisi di dalam tanda kurung struktur "if" harus menghasilkan nilai bertipe data...', options: ['int', 'string', 'boolean (true/false)', 'char'], correctIndex: 2),
      QuizTask(id: '6_q5', question: 'Apakah nama blok fallback pada switch-case yang bertindak mirip seperti perintah "else" di dalam rumpun struktur If?', options: ['else case', 'break case', 'default:', 'void:'], correctIndex: 2),
      PracticeTask(id: '6_p1', description: 'Buatlah logika if sederhana, jika int nilai = 90; bernilai lebih besar dari 75, cetak teks "Kompeten".', expectedOutput: 'Kompeten', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nint main() {\n    int nilai = 90;\n    if (nilai > 75) {\n        cout << "Kompeten";\n    }\n    return 0;\n}'),
    ],
  ),

  // BAB 7
  Chapter(
    id: '7',
    title: 'Belajar C++ #07: Perulangan',
    description: 'Mengulang sekumpulan baris kode otomatis menggunakan perintah for, while, dan do-while.',
    videoUrl: 'fL8-RZ8Lt60',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Perulangan digunakan untuk mengeksekusi sekumpulan baris kode berulang-ulang tanpa perlu menulis kodenya secara manual berkali-kali.

1. For Loop: Paling ideal jika kita sudah tahu pasti berapa jumlah total iterasi putaran yang kita inginkan.
2. While Loop: Melakukan pengecekan kondisi di AWAL. Kode di dalam blok diulang TERUS-MENERUS SELAMA kondisi bernilai true.
3. Do-While Loop: Melakukan eksekusi kode minimal SATU KALI terlebih dahulu, baru kemudian mengecek syarat kondisinya di AKHIR blok.
''',
    tasks: [
      QuizTask(id: '7_q1', question: 'Struktur perulangan manakah yang melakukan pengecekan syarat kondisi di bagian akhir blok kode?', options: ['for loop', 'while loop', 'do-while loop', 'foreach'], correctIndex: 2),
      QuizTask(id: '7_q2', question: 'Perulangan jenis apakah yang paling cocok digunakan jika total jumlah putarannya sudah diketahui pasti sejak awal?', options: ['while', 'for', 'do-while', 'switch'], correctIndex: 1),
      QuizTask(id: '7_q3', question: 'Apakah fungsi utama dari bagian ekspresi "increment" (seperti i++) di dalam struktur perulangan?', options: ['Menghentikan program paksa', 'Mengubah variabel menjadi konstanta', 'Menambah nilai counter agar perulangan berjalan maju', 'Mencetak teks angka'], correctIndex: 2),
      QuizTask(id: '7_q4', question: 'Apa yang akan terjadi jika kondisi penguji perulangan while selalu bernilai true selamanya?', options: ['Program lapor eror', 'Kelebihan memori komputer langsung bersih', 'Terjadi Infinite Loop (perulangan tiada henti)', 'Aplikasi otomatis tertutup'], correctIndex: 2),
      QuizTask(id: '7_q5', question: 'Berapa kalikah minimal blok kode di dalam struktur "do-while" dikerjakan meskipun kondisi bernilai salah?', options: ['0 kali', '1 kali', '5 kali', 'Selamanya'], correctIndex: 1),
      PracticeTask(id: '7_p1', description: 'Buatlah perulangan for berturut-turut untuk mencetak angka bintang sebanyak tiga baris vertikal: baris 1 "*", baris 2 "*", baris 3 "*".', expectedOutput: '*\n*\n*', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nint main() {\n    for(int i=0; i<3; i++) {\n        cout << "*\\n";\n    }\n    return 0;\n}'),
    ],
  ),

  // BAB 8
  Chapter(
    id: '8',
    title: 'Belajar C++ #08: Struktur Data Array',
    description: 'Menyimpan sekumpulan data homogen dalam satu nama variabel dengan sistem indeks memori.',
    videoUrl: 'U6ailcItsmQ',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Array (Larik) adalah struktur data yang mampu menyimpan banyak nilai sekaligus dalam satu nama variabel tunggal, asalkan seluruh nilai tersebut memiliki Tipe Data yang SAMA (homogen).

1. Akses Menggunakan Indeks: Setiap kotak nilai di dalam array memiliki nomor urut penunjuk yang disebut Indeks.
2. Indeks Dimulai dari Nol (0): Elemen pertama selalu berada di indeks `0`, elemen kedua di indeks `1`, dan seterusnya.

Sintaks Deklarasi Array:
`tipe_data nama_array[jumlah_ukuran];`
Contoh: `int nilai[3] = {85, 90, 95};`
''',
    tasks: [
      QuizTask(id: '8_q1', question: 'Nomor indeks elemen pertama di dalam sebuah variabel array selalu dimulai dari angka...', options: ['-1', '0', '1', 'Bebas tergantung input'], correctIndex: 1),
      QuizTask(id: '8_q2', question: 'Manakah syarat mutlak pengisian elemen nilai di dalam suatu variabel array?', options: ['Ukurannya bisa berubah otomatis', 'Seluruh elemen wajib memiliki tipe data yang sama', 'Harus berupa angka bulat saja', 'Tidak boleh dibaca pakai perulangan'], correctIndex: 1),
      QuizTask(id: '8_q3', question: 'Jika dideklarasikan int data[5];, berapakah nomor indeks maksimal yang valid untuk diakses?', options: ['5', '4', '6', '0'], correctIndex: 1),
      QuizTask(id: '8_q4', question: 'Bagaimanakah sintaks kode yang benar untuk membaca data array bernama "X" pada indeks ketiga?', options: ['X(3)', 'X{3}', 'X[3]', 'X->3'], correctIndex: 2),
      QuizTask(id: '8_q5', question: 'Komponen struktur kontrol apakah yang paling sering dikombinasikan untuk menginput atau menampilkan seluruh isi array?', options: ['Switch-Case', 'Perulangan (Looping)', 'If-Else Kondisional', 'Header File'], correctIndex: 1),
      PracticeTask(id: '8_p1', description: 'Buatlah deklarasi array bertipe integer berisi 2 elemen yaitu {10, 20}, lalu cetak elemen kedua (indeks 1) ke layar console.', expectedOutput: '20', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nint main() {\n    int arr[2] = {10, 20};\n    cout << arr[1];\n    return 0;\n}'),
    ],
  ),

  // BAB 9
  Chapter(
    id: '9',
    title: 'Belajar C++ #09: Prosedur dan Fungsi',
    description: 'Memecah kode menjadi blok modular yang reusable menggunakan parameter dan nilai kembalian return.',
    videoUrl: 'uUTJ53sktck',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Fungsi/Prosedur memungkinkan kita memecah program besar menjadi bagian-bagian kecil yang focus pada tugas tertentu, sehingga kode mudah dibaca dan bisa dipanggil berulang kali.

1. Fungsi tanpa Return (Prosedur / Void)
Fungsi yang hanya melakukan aksi tanpa mengembalikan nilai ke pemanggil.
```cpp
void sapa() {
    cout << "Halo Siswa RPL!";
}
```

2. Fungsi dengan Return (Fungsi Mengembalikan Nilai)
Fungsi yang mengembalikan sebuah nilai hasil perhitungan sesuai tipe datanya.
```cpp
int tambah(int a, int b) {
    return a + b;
}
```
''',
    tasks: [
      QuizTask(id: '9_q1', question: 'Kata kunci bertipe apakah yang digunakan jika suatu fungsi tidak mengembalikan nilai apapun (Prosedur)?', options: ['int', 'void', 'return', 'static'], correctIndex: 1),
      QuizTask(id: '9_q2', question: 'Kata kunci perintah wajib apakah yang ditulis di akhir fungsi berjenis return untuk mengirimkan hasil operasi?', options: ['break', 'continue', 'return', 'send'], correctIndex: 2),
      QuizTask(id: '9_q3', question: 'Variabel penampung nilai yang diletakkan di dalam tanda kurung deklarasi fungsi disebut...', options: ['Konstanta', 'Argumen/Parameter', 'Header', 'Void'], correctIndex: 1),
      QuizTask(id: '9_q4', question: 'Manakah penulisan prototipe fungsi utama pemanggilan yang benar?', options: ['cetak()', 'void cetak{}', 'int cetak[]', 'void cetak;'], correctIndex: 0),
      QuizTask(id: '9_q5', question: 'Keuntungan utama memecah alur kode program menjadi beberapa fungsi independen adalah...', options: ['Memperberat memori', 'Kode bisa dipanggil berulang-ulang (reusable) dan modular', 'Menghilangkan fungsi main', 'Memperbanyak syntax error'], correctIndex: 1),
      PracticeTask(id: '9_p1', description: 'Buat fungsi void bernama "halo" yang mencetak "Hi", lalu panggil di fungsi main.', expectedOutput: 'Hi', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nvoid halo() {\n    cout << "Hi";\n}\nint main() {\n    halo();\n    return 0;\n}'),
    ],
  ),

  // BAB 10
  Chapter(
    id: '10',
    title: 'Belajar C++ #10: Tipe Data Enum',
    description: 'Membuat tipe data bentukan sendiri yang berisi kumpulan konstanta nama konstanta tekstual.',
    videoUrl: 'jMau81Jh8JU',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Enum (Enumeration) adalah tipe data bentukan buatan user yang terdiri dari sekumpulan konstanta bernilai tetap yang telah diberi nama secara tekstual. Enum mempermudah pembacaan logika kode program.

Secara internal di memori komputer, setiap nama konstanta enum diwakili oleh indeks angka integer, dimulai dari `0` untuk pilihan pertama.

Contoh Sintaks:
```cpp
enum Hari { SENIN, SELASA, RABU, KAMIS, JUMAT };
Hari hariIni = SENIN;
```
''',
    tasks: [
      QuizTask(id: '10_q1', question: 'Kata kunci apakah yang digunakan untuk mendefinisikan tipe data bentukan enumerasi?', options: ['struct', 'union', 'enum', 'constant'], correctIndex: 2),
      QuizTask(id: '10_q2', question: 'Secara default, nilai integer memori yang mewakili elemen konstanta enum urutan PERTAMA adalah...', options: ['1', '-1', '0', 'Null'], correctIndex: 2),
      QuizTask(id: '10_q3', question: 'Jika enum Bulan { JAN = 1, FEB, MAR };, berapakah nilai integer asetasi otomatis untuk konstanta FEB?', options: ['0', '1', '2', '3'], correctIndex: 2),
      QuizTask(id: '10_q4', question: 'Tujuan utama menggunakan tipe data bentukan enum di dalam rekayasa perangkat lunak adalah...', options: ['Meningkatkan keterbacaan kode (readability)', 'Membuat grafik UI', 'Menghapus library iostream', 'Mematikan looping'], correctIndex: 0),
      QuizTask(id: '10_q5', question: 'Manakah deklarasi variabel objek enum Hari yang benar berdasarkan rumpun C++?', options: ['Hari hariIni;', 'enum = Hari;', 'Hari = enum()', 'Hari {hariIni}'], correctIndex: 0),
      PracticeTask(id: '10_p1', description: 'Buat program enum A { X }, cetak nilai X ke layar (akan memunculkan angka 0).', expectedOutput: '0', targetCodeSnippet: '#include <iostream>\nusing namespace std;\nenum A { X };\nint main() {\n    cout << X;\n    return 0;\n}'),
    ],
  ),

  // BAB 11
  Chapter(
    id: '11',
    title: 'Belajar C++ #11: Tipe Data Structure',
    description: 'Menampung kumpulan variabel dengan tipe data yang berbeda-beda dalam satu payung struct.',
    videoUrl: 'MM2JLO6HFmY',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Berbeda dengan Array yang mengharuskan tipe data seragam (homogen), Struct (Structure) adalah tipe data bentukan yang memungkinkan kita mengelompokkan beberapa variabel dengan tipe data BERBEDA (heterogen) dalam satu wadah kesatuan.

Sangat cocok untuk pemodelan data entitas nyata, seperti objek data `Siswa` (memiliki nama bertipe string, umur bertipe int, dan nilai bertipe double).

Sintaks:
```cpp
struct Siswa {
    string nama;
    int umur;
};
Siswa s1;
s1.nama = "Damar";
```
''',
    tasks: [
      QuizTask(id: '11_q1', question: 'Kata kunci sintaks apakah yang dipakai untuk mendeklarasikan sebuah tipe data Structure?', options: ['structure', 'struct', 'class', 'union'], correctIndex: 1),
      QuizTask(id: '11_q2', question: 'Apakah perbedaan mendasar yang paling utama antara variabel Array dengan variabel Struct?', options: ['Array lambat sedangkan struct cepat', 'Array bertipe data homogen, sedangkan struct bisa menampung data heterogen', 'Struct tidak punya nama variabel', 'Array wajib bertipe string'], correctIndex: 1),
      QuizTask(id: '11_q3', question: 'Operator tanda baca apakah yang digunakan untuk mengakses anggota field internal di dalam suatu objek struct?', options: ['Tanda panah (->)', 'Tanda titik (.)', 'Tanda koma (,)', 'Tanda seru (!)'], correctIndex: 1),
      QuizTask(id: '11_q4', question: 'Setiap akhir penutupan kurung kurawal deklarasi induk blok "struct { ... }" wajib diakhiri tanda...', options: [': (Titik Dua)', '; (Titik Koma)', ', (Koma)', 'Tanpa Tanda Baca'], correctIndex: 1),
      QuizTask(id: '11_q5', question: 'Variabel-variabel komponen penyusun yang dideklarasikan di dalam tubuh induk struct dinamakan...', options: ['Parameter', 'Field / Member / Anggota', 'Constant', 'Header'], correctIndex: 1),
      PracticeTask(id: '11_p1', description: 'Buat struct B { int x; }; instansiasi objek b, isi nilai x = 99, lalu cetak nilai x.', expectedOutput: '99', targetCodeSnippet: '#include <iostream>\nusing namespace std;\nstruct B { int x; };\nint main() {\n    B b;\n    b.x = 99;\n    cout << b.x;\n    return 0;\n}'),
    ],
  ),

  // BAB 12
  Chapter(
    id: '12',
    title: 'Belajar C++ #12: Tipe Data Union',
    description: 'Mengenal penyimpanan variabel bersama di satu lokasi alamat memori yang bergantian.',
    videoUrl: 'CymbNTkakQg',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Union mirip seperti Struct karena bisa menampung beberapa member variabel dengan tipe data berbeda. Namun, ada perbedaan besar dalam manajemen memori: semua member variabel di dalam Union BERBAGI lokasi alamat memori yang SAMA.

Ukuran memori Union ditentukan oleh member yang memiliki ukuran bita terbesar. Nilai member akan saling menimpa satu sama lain jika diisi bersamaan.

Sintaks:
```cpp
union Data {
    int angkaBulat;
    char huruf;
};
```
''',
    tasks: [
      QuizTask(id: '12_q1', question: 'Kata kunci apakah yang ditgetikkan untuk mendefinisikan tipe data bentukan bersama bernama Union?', options: ['struct', 'union', 'enum', 'share'], correctIndex: 1),
      QuizTask(id: '12_q2', question: 'Bagaimanakah alokasi alamat memori untuk setiap member variabel penyusun di dalam sebuah Union?', options: ['Memori terpisah sendiri-sendiri', 'Berbagi lokasi alamat memori yang sama (saling bergantian)', 'Memori otomatis di awan', 'Tidak menggunakan memori komputer sama sekali'], correctIndex: 1),
      QuizTask(id: '12_q3', question: 'Berapakah ukuran total ruang kapasitas memori bita yang dialokasikan oleh kompilator untuk objek Union?', options: ['Jumlah total memori semua member', 'Sama dengan ukuran member terbesar', 'Selalu 4 byte', 'Sama dengan ukuran member terkecil'], correctIndex: 1),
      QuizTask(id: '12_q4', question: 'Apa akibatnya jika kita mengisi nilai ke suatu member Union, padahal member lainnya baru saja diisi nilai?', options: ['Program meledak', 'Nilai member sebelumnya akan tertimpa/rusak', 'Nilai otomatis digabung', 'Terjadi looping berulang'], correctIndex: 1),
      QuizTask(id: '12_q5', question: 'Sama seperti struct, untuk mengakses anggota internal objek union, kita menggunakan operator...', options: ['#', '::', '.', '->'], correctIndex: 2),
      PracticeTask(id: '12_p1', description: 'Buat union U { int k; }; instansiasi u, beri nilai u.k = 50, lalu cetak nilai u.k.', expectedOutput: '50', targetCodeSnippet: '#include <iostream>\nusing namespace std;\nunion U { int k; };\nint main() {\n    U u;\n    u.k = 50;\n    cout << u.k;\n    return 0;\n}'),
    ],
  ),

  // BAB 13
  Chapter(
    id: '13',
    title: 'Ujian Akhir Bab 13: Pointer dan Materi Sebelumnya',
    description: 'Memahami variabel penunjuk alamat memori komputer menggunakan operator & dan bintang *.',
    videoUrl: 'VPzmwIIKKRQ',
    startSeconds: 0,
    endSeconds: 0,
    content: '''
Pointer adalah salah satu fitur paling sakti di C++. Pointer adalah variabel khusus yang tidak menyimpan nilai data biasa, melainkan menyimpan ALAMAT MEMORI dari variabel lain.

Dua Operator Kunci Pointer:
1. Operator Reference / Address-of (`&`)
Digunakan untuk mendapatkan alamat memori suatu variabel.
2. Operator Dereference (`*`)
Digunakan untuk mengakses atau mengambil nilai data asli yang berada di alamat memori yang ditunjuk oleh pointer.

Contoh Sintaks:
```cpp
int angka = 10;
int* ptr = &angka; // ptr menyimpan alamat memori variabel angka
cout << *ptr;      // mencetak nilai data asli: 10
```
''',
    tasks: [
      QuizTask(id: '13_q1', question: 'Apakah yang dimaksud dengan variabel jenis Pointer di dalam ekosistem pemrograman C++?', options: ['Variabel penampung teks panjang', 'Variabel khusus yang menyimpan nilai alamat memori komputer', 'Fungsi otomatis pembersih cache', 'Operator modulus baru'], correctIndex: 1),
      QuizTask(id: '13_q2', question: 'Simbol operator penunjuk manakah yang digunakan untuk mendeklarasikan suatu variabel pointer?', options: ['& (Ampersand)', '* (Asterisk / Bintang)', '% (Persen)', '-> (Panah)'], correctIndex: 1),
      QuizTask(id: '13_q3', question: 'Simbol operator address-of manakah yang dipanggil untuk mengambil nilai alamat memori dari suatu variabel biasa?', options: ['*', '&', '#', '\$'], correctIndex: 1),
      QuizTask(id: '13_q4', question: 'Proses membaca nilai data asli di lokasi memori yang ditunjuk oleh pointer melalui operator bintang (*) dinamakan...', options: ['Reference', 'Dereference', 'Initialization', 'Allocation'], correctIndex: 1),
      QuizTask(id: '13_q5', question: 'Jika int x = 5; int* p = &x; maka jika kita mencetak kode *p, output yang keluar adalah...', options: ['Alamat memori x', 'Nilai angka 5', 'Eror kompilasi', 'Alamat memori p'], correctIndex: 1),
      PracticeTask(id: '13_p1', description: 'Buat program pointer: int a = 55; int* p = &a; cetak *p untuk menampilkan nilai 55.', expectedOutput: '55', targetCodeSnippet: '#include <iostream>\nusing namespace std;\n\nint main() {\n    int a = 55;\n    int* p = &a;\n    cout << *p;\n    return 0;\n}'),
    ],
  ),
];
