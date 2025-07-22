import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:futur/repositary/screens/register/verify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/userDetail.dart';
import '../registerorlogin/register.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedInputs();
  }

  Future<void> _loadSavedInputs() async {
    final prefs = await SharedPreferences.getInstance();
    firstNameController.text = prefs.getString('firstName') ?? '';
    lastNameController.text = prefs.getString('lastName') ?? '';
    emailController.text = prefs.getString('email') ?? '';
    dayController.text = prefs.getString('day') ?? '';
    monthController.text = prefs.getString('month') ?? '';
    yearController.text = prefs.getString('year') ?? '';
    mobileController.text = prefs.getString('mobile') ?? '';
  }

  Future<void> _saveField(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String key,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        onChanged: (value) => _saveField(key, value),
        maxLength: maxLength,
        decoration: InputDecoration(
          counterText: '',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SpeedPage()),
            );
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset('assets/images/Mock Logo.png', height: 30),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 350,
            left: 100,
            child: Image.asset('assets/images/Blend 01.png'),
          ),
          Positioned(
            bottom: 200,
            right: 0,
            child: Image.asset('assets/images/Blend 02.png'),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Personal Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    label: 'First Name',
                    controller: firstNameController,
                    key: 'firstName',
                  ),
                  _buildTextField(
                    label: 'Last Name',
                    controller: lastNameController,
                    key: 'lastName',
                  ),
                  _buildTextField(
                    label: 'Email Address',
                    controller: emailController,
                    key: 'email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Birthday',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'Day',
                          controller: dayController,
                          key: 'day',
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          label: 'Month',
                          controller: monthController,
                          key: 'month',
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Year',
                    controller: yearController,
                    key: 'year',
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Mobile Number',
                    controller: mobileController,
                    key: 'mobile',
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              if (firstNameController.text.trim().isEmpty ||
                  lastNameController.text.trim().isEmpty ||
                  emailController.text.trim().isEmpty ||
                  dayController.text.trim().isEmpty ||
                  monthController.text.trim().isEmpty ||
                  yearController.text.trim().isEmpty ||
                  mobileController.text.trim().isEmpty) {
                _showSnackBar("Please fill out all fields before continuing.");
                return;
              }

              if (mobileController.text.trim().length != 10 ||
                  !RegExp(r'^\d{10}$').hasMatch(mobileController.text.trim())) {
                _showSnackBar("Enter a valid 10-digit mobile number.");
                return;
              }

              final email = emailController.text.trim();

              try {
                final query = await FirebaseFirestore.instance
                    .collection('users')
                    .where('email', isEqualTo: email)
                    .limit(1)
                    .get();

                if (query.docs.isNotEmpty) {
                  if (context.mounted) {
                    _showSnackBar(
                        "An account with this email already exists. Please sign in instead.");
                  }
                  return;
                }

                final birthday =
                    '${dayController.text}/${monthController.text}/${yearController.text}';
                final currentUser = FirebaseAuth.instance.currentUser;

                final user = UserDetails(
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text.trim(),
                  email: email,
                  birthday: birthday,
                  mobile: mobileController.text.trim(),
                  province: '',
                  city: '',
                  addressLine1: '',
                  addressLine2: '',
                  postalCode: '',
                  photoUrl: currentUser?.photoURL,
                );

                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Verify(userDetails: user),
                    ),
                  );
                }
              } catch (e) {
                _showSnackBar("Error checking email: $e");
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
}
