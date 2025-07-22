import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class LiveStockCard extends StatefulWidget {
  final String symbol;
  final IconData icon;

  const LiveStockCard({
    required this.symbol,
    required this.icon,
    super.key,
  });

  @override
  State<LiveStockCard> createState() => _LiveStockCardState();
}

class _LiveStockCardState extends State<LiveStockCard> {
  double? price;
  bool isLoading = true;

  Future<void> fetchPriceFromFirestoreApiConfig() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('api_config')
          .doc('stockapi')
          .get();

      if (!doc.exists) {
        print('API config not found in Firestore.');
        return;
      }

      final baseUrl = doc['base_url'];
      final apiKey = doc['api_key'];

      final response = await http.get(Uri.parse(
        '$baseUrl?symbol=${widget.symbol}&apikey=$apiKey',
      ));

      final data = json.decode(response.body);

      if (data.containsKey('price')) {
        double parsedPrice = double.tryParse(data['price'] ?? '0') ?? 0;

        setState(() {
          price = parsedPrice;
          isLoading = false;
        });
      } else {
        print('API error: ${data['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('Error fetching price: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPriceFromFirestoreApiConfig();
    Timer.periodic(
        const Duration(minutes: 1), (_) => fetchPriceFromFirestoreApiConfig());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(widget.icon, size: 30, color: Colors.black),
          const SizedBox(height: 10),
          Text(widget.symbol,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          isLoading
              ? const CircularProgressIndicator()
              : Text(
                  '\$${price!.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }
}
