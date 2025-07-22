import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intl/intl.dart';

class LivePriceTicker extends StatefulWidget {
  final String currency;

  const LivePriceTicker({super.key, required this.currency});

  @override
  State<LivePriceTicker> createState() => _LivePriceTickerState();
}

class _LivePriceTickerState extends State<LivePriceTicker> {
  late WebSocketChannel channel;
  String price = 'Loading...';
  double inrRate = 0.0;

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
    connectToWebSocket();
  }

  Future<void> fetchExchangeRate() async {
    try {
      final response = await http.get(Uri.parse(
        'https://api.exchangerate-api.com/v4/latest/USD',
      ));
      final data = jsonDecode(response.body);
      setState(() {
        inrRate = data['rates']['INR'];
      });
    } catch (e) {
      print('Failed to fetch INR rate: $e');
      setState(() {
        inrRate = 83.0;
      });
    }
  }

  void connectToWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://ws.finnhub.io?token=d1t0iq1r01qllrcou7fgd1t0iq1r01qllrcou7g0'),
    );

    channel.sink.add(jsonEncode({
      'type': 'subscribe',
      'symbol': 'BINANCE:BTCUSDT',
    }));

    channel.stream.listen((event) {
      final data = jsonDecode(event);
      if (data['data'] != null && inrRate > 0) {
        final usdPrice = data['data'][0]['p'];
        final inrPrice = usdPrice * inrRate;
        final formattedPrice = NumberFormat.currency(
          locale: 'en_IN',
          symbol: '₹',
          decimalDigits: 2,
        ).format(inrPrice);

        setState(() {
          price = formattedPrice;
        });
      }
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.currency == "BTC" ? price : '',
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }
}
