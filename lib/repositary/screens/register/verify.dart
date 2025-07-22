import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futur/repositary/screens/register/signin.dart';
import '../../../model/userDetail.dart';
import '../home/HomeAddress.dart';

class Verify extends StatelessWidget {
  final UserDetails userDetails;

  const Verify({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    final TextEditingController mobileController =
        TextEditingController(text: userDetails.mobile);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PersonalDetailsPage()));
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset(
            'assets/images/Mock Logo.png',
            height: 40,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 20,
              left: 20,
              child: Image.asset('assets/images/Blend 01.png')),
          Positioned(
              top: 50,
              right: 0,
              child: Image.asset('assets/images/Blend 02.png')),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const Text(
                    'Mobile Number Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Mobile Number',
                    controller: mobileController,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              final query = await FirebaseFirestore.instance
                  .collection('users')
                  .where('mobile', isEqualTo: userDetails.mobile)
                  .limit(1)
                  .get();

              if (query.docs.isNotEmpty) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Mobile number already exists. Please log in instead.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              } else {
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeAddress(
                        userDetails: userDetails,
                      ),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD6D3FF),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Continue',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: const Color(0xFF1E1E1E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
