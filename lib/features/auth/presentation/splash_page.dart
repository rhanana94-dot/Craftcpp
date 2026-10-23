import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Splash tetap terlihat, tetapi tidak lagi menahan aplikasi selama 3 detik.
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    try {
      final authService = Provider.of<AuthService>(
        context,
        listen: false,
      );

      final user = authService.currentUser;

      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed(
        user != null ? '/role' : '/login',
      );
    } catch (e) {
      debugPrint('Splash auth check gagal: $e');

      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/loading screan.jpeg',
              width: 250,
              errorBuilder: (context, error, stackTrace) {
                return const FlutterLogo(size: 100);
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'CraftC++',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
