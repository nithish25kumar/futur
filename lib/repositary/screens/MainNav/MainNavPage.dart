import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/userDetail.dart';
import '../biitcoin/bitcoin_page.dart';
import '../homepage/homepage.dart';
import '../savings/savings_page.dart';

class MainNavPage extends StatefulWidget {
  final UserDetails user;
  const MainNavPage({super.key, required this.user});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Homepage(user: widget.user),
      const SavingsPage(),
      const BitcoinPage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart_circle_fill), label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_bitcoin_outlined), label: 'Bitcoin'),
        ],
      ),
    );
  }
}
