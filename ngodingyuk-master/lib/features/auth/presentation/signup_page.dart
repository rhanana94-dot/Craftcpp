import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/auth_service.dart';
import '../domain/user_role_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  String _role = 'siswa';

  Future<void> _signup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final name = _nameController.text.trim();

    // Validasi nama
    if (name.isEmpty) {
      _showMessage('Nama tidak boleh kosong!');
      return;
    }

    // Validasi email
    if (email.isEmpty) {
      _showMessage('Email tidak boleh kosong!');
      return;
    }

    // Validasi password
    if (password.isEmpty) {
      _showMessage('Password tidak boleh kosong!');
      return;
    }

    if (password.length < 6) {
      _showMessage('Password minimal harus 6 karakter!');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(
        context,
        listen: false,
      );

      // Buat akun Firebase Authentication
      final credential = await authService.signUp(
        email,
        password,
      );

      // credential bisa null, jadi wajib menggunakan ?.
      final user = credential?.user;

      if (user == null) {
        throw Exception(
          'Akun gagal dibuat. User tidak ditemukan.',
        );
      }

      // Simpan role dan profil pengguna
      await UserRoleService().setRole(
        user,
        _role,
        name: name,
      );

      if (!mounted) return;

      // Setelah berhasil langsung masuk ke RoleRouter
      Navigator.pushReplacementNamed(
        context,
        '/role',
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'Gagal mendaftar: ${_cleanError(e)}',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _cleanError(Object error) {
    return error
        .toString()
        .replaceFirst('Exception: ', '')
        .replaceAll(
      RegExp(r'\[.*?\]\s*'),
      '',
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Akun Baru',
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    'Mulai Petualangan Belajar!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Daftar akun CraftC++ untuk menyimpan semua progres belajarmu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF94A3B8),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // =========================
                  // NAMA
                  // =========================

                  TextField(
                    controller: _nameController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      hintText: 'Masukkan nama lengkap',
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // EMAIL
                  // =========================

                  TextField(
                    controller: _emailController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Alamat Email',
                      hintText: 'Masukkan email aktif kamu',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // PASSWORD
                  // =========================

                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      hintText: 'Minimal 6 karakter',
                      prefixIcon: const Icon(
                        Icons.lock_outlined,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword =
                            !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // ROLE
                  // =========================

                  DropdownButtonFormField<String>(
                    value: _role,
                    decoration: const InputDecoration(
                      labelText: 'Daftar sebagai',
                      prefixIcon: Icon(
                        Icons.badge_outlined,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'siswa',
                        child: Text(
                          'Siswa',
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'guru',
                        child: Text(
                          'Guru',
                        ),
                      ),
                    ],
                    onChanged: _isLoading
                        ? null
                        : (value) {
                      setState(() {
                        _role =
                            value ?? 'siswa';
                      });
                    },
                  ),

                  const SizedBox(height: 40),

                  // =========================
                  // TOMBOL DAFTAR
                  // =========================

                  if (_isLoading)
                    const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 12),
                        Text(
                          'Membuat akun...',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _signup,
                        child: const Text(
                          'Daftar Akun',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Sudah punya akun? Masuk',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}