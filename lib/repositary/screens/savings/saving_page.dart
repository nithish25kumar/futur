import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../stockdetail/StockDetailsPage.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.heart_circle_fill,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Wishlist',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: user == null
          ? const Center(child: Text("Please log in"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .collection('wishlist')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No items in wishlist"));
                }

                final wishlist = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: wishlist.length,
                  itemBuilder: (context, index) {
                    final symbol = wishlist[index]['symbol'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          leading: const Icon(Icons.trending_up,
                              size: 32, color: Colors.green),
                          title: Text(
                            symbol,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    StockDetailsPage(symbol: symbol),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_rounded,
                                size: 28, color: Colors.red),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user!.uid)
                                  .collection('wishlist')
                                  .doc(symbol)
                                  .delete();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$symbol removed')),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
