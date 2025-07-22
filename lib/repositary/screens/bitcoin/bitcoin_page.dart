import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futur/repositary/screens/pricetracker/LivePriceTicker.dart';

class BitcoinPage extends StatefulWidget {
  const BitcoinPage({super.key});

  @override
  State<BitcoinPage> createState() => _BitcoinPageState();
}

class _BitcoinPageState extends State<BitcoinPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: 2 * 3.1415926535,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {}, icon: Icon(CupertinoIcons.bitcoin_circle_fill)),
        title: Text(
          'Bitcoin',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/images/bitcoin.png',
                  width: 350,
                  alignment: Alignment.center,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 330),
            child: SafeArea(
                child: SizedBox(
              width: 450,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    LivePriceTicker(
                      currency: "BTC",
                    )
                  ],
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}
