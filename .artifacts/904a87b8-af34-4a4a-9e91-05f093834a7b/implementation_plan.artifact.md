# Rencana Implementasi Fitur Menu Profil Pengguna

Menambahkan menu profil baru ke dalam navigasi utama (`MainNavigationPage`) aplikasi NgodingYuk++. Menu ini memungkinkan pengguna untuk memperbarui nama profil (displayName di Firebase), memperbarui kata sandi, serta keluar akun (logout) untuk berpindah ke akun lain.

## Usulan Perubahan

Kita akan membuat komponen halaman profil baru dan mendaftarkannya di navigasi utama, serta menambahkan method pembantu yang diperlukan di `AuthService`.

### 1. Autentikasi Layer

#### [MODIFY] [auth_service.dart](file:///C:/Users/DZIQRO/AndroidStudioProjects/NgodingYuk/lib/features/auth/domain/auth_service.dart)
Menambahkan fungsi-fungsi pendukung:
- Mengambil instansi user saat ini (`currentUser`).
- Memperbarui nama tampilan pengguna (`updateDisplayName`).
- Memperbarui kata sandi pengguna (`updatePassword`).

### 2. Presentasi Layer - Fitur Profil Baru

#### [NEW] [profile_page.dart](file:///C:/Users/DZIQRO/AndroidStudioProjects/NgodingYuk/lib/features/profile/presentation/profile_page.dart)
Membuat halaman UI profil dengan fitur:
- Tampilan Email dan Nama Pengguna saat ini.
- Form/Dialog interaktif untuk memperbarui nama.
- Form/Dialog interaktif untuk memperbarui kata sandi dengan validasi keamanan minimal 6 karakter.
- Tombol Keluar Akun (Logout) yang membersihkan sesi dan mengarahkan kembali ke halaman login.

### 3. Integrasi Navigasi Utama

#### [MODIFY] [main_navigation_page.dart](file:///C:/Users/DZIQRO/AndroidStudioProjects/NgodingYuk/lib/features/home/presentation/main_navigation_page.dart)
Menambahkan destinasi tab kelima pada `NavigationBar` dan `IndexedStack` untuk memuat halaman `ProfilePage`.

---

## Rencana Verifikasi

### Verifikasi Manual
1. Pindah ke tab Profil di navigasi bawah.
2. Mencoba mengubah nama dan memastikan nama terupdate di layar secara instan.
3. Mencoba mengubah kata sandi dengan input yang valid dan tidak valid (< 6 karakter).
4. Klik tombol "Keluar Akun", pastikan aplikasi kembali ke halaman `/login`.
