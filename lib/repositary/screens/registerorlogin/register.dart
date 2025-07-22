import 'package:flutter/material.dart';
import '../../../auth_service.dart';
import '../../../model/userDetail.dart';
import '../../../welcomeback.dart';
import '../register/signin.dart';

class SpeedPage extends StatelessWidget {
  const SpeedPage({super.key});

  Future<void> _handleLogin(BuildContext context) async {
    try {
      final user = await AuthService.signInWithGoogle();

      if (user != null && context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Welcomeback(user: user)),
        );
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No account found for this Google email. Please register first.',
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
              top: 700,
              left: 60,
              child: Image.asset('assets/images/Blend 01.png')),
          Positioned(
              bottom: 600,
              right: 0,
              child: Image.asset('assets/images/Blend 02.png')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                const SizedBox(height: 150),
                Image.asset('assets/images/Mock Logo.png', width: 180),
                const SizedBox(height: 100),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('ANYTIME',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white60,
                          letterSpacing: 1.5)),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Ready for ',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        TextSpan(
                          text: 'anything',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Manage your money effortlessly and stay in control anytime, anywhere.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PersonalDetailsPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6D3FF),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _handleLogin(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFF4D4D4D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Already have an account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
