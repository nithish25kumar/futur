import 'package:flutter/material.dart';
import '../../../model/userDetail.dart';
import '../homepage/homepage.dart';

class Success extends StatelessWidget {
  final UserDetails user;

  const Success({super.key, required this.user});

  String get initials {
    return "${user.firstName[0]}${user.lastName[0]}".toUpperCase();
  }

  String get accountId {
    return "ID:${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 12)}";
  }

  String get formattedDate {
    final now = DateTime.now();
    return "${_monthName(now.month)} ${now.day}, ${now.year}";
  }

  String _monthName(int month) {
    const months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Account Creation Successful!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 80),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xFFD6D3FF),
                            backgroundImage: user.photoUrl != null &&
                                user.photoUrl!.isNotEmpty
                                ? NetworkImage(user.photoUrl!)
                                : null,
                            child:
                            user.photoUrl == null || user.photoUrl!.isEmpty
                                ? Text(
                              initials,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            )
                                : null,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${user.firstName} ${user.lastName}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.mobile,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "$accountId   $formattedDate",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homepage(user: user),
                            ),
                          );
                        },
                        child: const Text("View Details",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Spacer(),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.info_outline, color: Colors.black),
                      label: const Text("How to deposit funds?",
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
