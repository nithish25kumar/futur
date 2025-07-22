import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futur/profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../model/userDetail.dart';
import '../pricetracker/LiveStockCard.dart';
import '../stockdetail/StockDetailsPage.dart';

class Homepage extends StatefulWidget {
  final UserDetails user;

  const Homepage({super.key, required this.user});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCurrency = "BTC";

  void _changeCurrency(String newCurrency) {
    setState(() {
      selectedCurrency = newCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/Mock Logo 1.png', height: 30),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Profile(
                                  user: widget.user,
                                )),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      backgroundImage: widget.user.photoUrl != null &&
                              widget.user.photoUrl!.isNotEmpty
                          ? NetworkImage(widget.user.photoUrl!)
                          : null,
                      child: widget.user.photoUrl == null ||
                              widget.user.photoUrl!.isEmpty
                          ? Text(
                              "${widget.user.firstName[0]}${widget.user.lastName[0]}"
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Welcome ${widget.user.firstName},",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Foreign Stocks",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.9,
                      children: [
                        _buildStockCard(context, 'AAPL', Icons.apple),
                        _buildStockCard(context, 'GOOGL', Icons.android),
                        _buildStockCard(context, 'MSFT', Icons.window),
                        _buildStockCard(context, 'NVDA', Icons.sports_soccer),
                        _buildStockCard(context, 'META', Icons.facebook),
                        _buildStockCard(context, 'NFLX', Icons.movie),
                        _buildStockCard(context, 'DIS', Icons.attractions),
                        _buildStockCard(context, 'INTC', Icons.memory),
                        _buildStockCard(context, 'ORCL', Icons.storage),
                        _buildStockCard(context, 'ADBE', Icons.brush),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencySelector extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CurrencySelector({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.transparent,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

Widget _buildStockCard(BuildContext context, String symbol, IconData icon) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockDetailsPage(symbol: symbol),
        ),
      );
    },
    child: LiveStockCard(symbol: symbol, icon: icon),
  );
}
