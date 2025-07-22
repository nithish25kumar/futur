import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/userDetail.dart';
import '../../../welcomeback.dart';
import '../registerorlogin/register.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _checkLoginAndNavigate();
  }

  Future<void> _checkLoginAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != null) {
      final email = user.email;

      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();

        final userDetails = UserDetails(
          firstName: data['firstName'] ?? '',
          lastName: data['lastName'] ?? '',
          email: data['email'] ?? '',
          birthday: data['birthday'] ?? '',
          mobile: data['mobile'] ?? '',
          province: data['province'] ?? '',
          city: data['city'] ?? '',
          addressLine1: data['addressLine1'] ?? '',
          addressLine2: data['addressLine2'] ?? '',
          postalCode: data['postalCode'] ?? '',
          photoUrl: user.photoURL,
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Welcomeback(user: userDetails),
            ),
          );
        }
        return;
      }
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SpeedPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/Mock Logo 1.png',
          height: 150,
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
