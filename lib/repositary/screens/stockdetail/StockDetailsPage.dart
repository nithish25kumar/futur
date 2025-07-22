import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockDetailsPage extends StatefulWidget {
  final String symbol;

  const StockDetailsPage({super.key, required this.symbol});

  @override
  State<StockDetailsPage> createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage> {
  double? price;
  double? prevClose;
  bool isLoading = true;
  List<StockData> chartData = [];

  @override
  void initState() {
    super.initState();
    fetchStockDetails();
  }

  Future<void> fetchStockDetails() async {
    try {
      final response = await http.get(Uri.parse(
        'https://api.twelvedata.com/time_series?symbol=${widget.symbol}&interval=1min&outputsize=10&apikey=e5b572e868164abba7425af5e9a38393',
      ));
      final data = json.decode(response.body);

      if (data['values'] != null) {
        final List values = data['values'];
        final List<StockData> points = values.map((e) {
          return StockData(
            time: DateTime.parse(e['datetime']),
            price: double.tryParse(e['close']) ?? 0,
          );
        }).toList();

        setState(() {
          price = points.first.price;
          prevClose = points.length > 1 ? points[1].price : price;
          chartData = points.reversed.toList(); // ascending order
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching stock data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double priceChange = (price ?? 0) - (prevClose ?? 0);
    double priceChangePercent = prevClose != null && prevClose != 0
        ? (priceChange / prevClose!) * 100
        : 0;
    Color priceColor = priceChange > 0
        ? Colors.green
        : (priceChange < 0 ? Colors.red : Colors.grey);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('${widget.symbol} Details'),
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.symbol} Stock Price',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '\$${price!.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: priceColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${priceChange >= 0 ? '+' : ''}${priceChange.toStringAsFixed(2)} (${priceChangePercent.toStringAsFixed(2)}%)',
                        style: TextStyle(
                          fontSize: 16,
                          color: priceColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    '📈 ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(),
                      primaryYAxis: NumericAxis(),
                      series: <CartesianSeries<StockData, DateTime>>[
                        LineSeries<StockData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (StockData data, _) => data.time,
                          yValueMapper: (StockData data, _) => data.price,
                          color: priceColor,
                          width: 2,
                          markerSettings:
                              const MarkerSettings(isVisible: false),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please log in first')),
                          );
                          return;
                        }

                        try {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .collection('wishlist')
                              .doc(widget.symbol)
                              .set({'symbol': widget.symbol});
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      },
                      icon: const Icon(Icons.favorite_border),
                      label: const Text('Add to Wishlist'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class StockData {
  final DateTime time;
  final double price;

  StockData({required this.time, required this.price});
}
