import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/userDetail.dart';
import '../register/success.dart';

class HomeAddress extends StatefulWidget {
  final UserDetails userDetails;
  const HomeAddress({super.key, required this.userDetails});

  @override
  State<HomeAddress> createState() => _HomeAddressState();
}

class _HomeAddressState extends State<HomeAddress> {
  String? selectedProvince;
  String? selectedCity;
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final postalCodeController = TextEditingController();
  bool isLoading = false;
  final provinceCityMap = {
    'Tamil Nadu': [
      'Chennai',
      'Coimbatore',
      'Madurai',
      'Krishnagiri',
      'Tiruchirappalli',
      'Salem',
      'Erode',
      'Vellore'
    ],
    'Karnataka': [
      'Bangalore',
      'Mysore',
      'Hubli',
      'Mangalore',
      'Belgaum',
      'Davangere',
      'Tumkur'
    ],
    'Maharashtra': [
      'Mumbai',
      'Pune',
      'Nagpur',
      'Nashik',
      'Thane',
      'Aurangabad',
      'Solapur'
    ],
    'Kerala': [
      'Thiruvananthapuram',
      'Kochi',
      'Kozhikode',
      'Thrissur',
      'Alappuzha',
      'Kannur',
    ],
    'Andhra Pradesh': [
      'Visakhapatnam',
      'Vijayawada',
      'Guntur',
      'Nellore',
      'Tirupati',
      'Kurnool'
    ],
    'Telangana': [
      'Hyderabad',
      'Warangal',
      'Nizamabad',
      'Karimnagar',
      'Khammam'
    ],
    'Delhi': [
      'New Delhi',
      'North Delhi',
      'South Delhi',
      'East Delhi',
      'West Delhi',
    ],
    'Uttar Pradesh': [
      'Lucknow',
      'Kanpur',
      'Ghaziabad',
      'Noida',
      'Agra',
      'Varanasi',
      'Prayagraj'
    ],
    'West Bengal': ['Kolkata', 'Howrah', 'Durgapur', 'Asansol', 'Siliguri'],
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Ajmer', 'Bikaner'],
  };

  bool get isFormValid =>
      selectedProvince != null &&
      selectedCity != null &&
      addressLine1Controller.text.isNotEmpty &&
      postalCodeController.text.isNotEmpty;

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF1C1C1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Image.asset('assets/images/Mock Logo.png', height: 40),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
              left: 10,
              top: 10,
              bottom: 90,
              child: Image.asset('assets/images/Blend 01.png')),
          Positioned(
              right: 10,
              bottom: 10,
              child: Image.asset('assets/images/Blend 01.png')),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text('Home Address',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text(
                    'Varius facilisis in duis volutpat. Viverra fermentum nibh consectetur purus.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.black,
                    value: selectedProvince,
                    hint: const Text("Province",
                        style: TextStyle(color: Colors.white70)),
                    decoration: _inputDecoration("Province"),
                    items: provinceCityMap.keys.map((prov) {
                      return DropdownMenuItem(
                          value: prov,
                          child: Text(prov,
                              style: const TextStyle(color: Colors.white)));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedProvince = val;
                        selectedCity = null;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.black,
                    value: selectedCity,
                    hint: const Text("City",
                        style: TextStyle(color: Colors.white70)),
                    decoration: _inputDecoration("City"),
                    items:
                        (provinceCityMap[selectedProvince] ?? []).map((city) {
                      return DropdownMenuItem(
                          value: city,
                          child: Text(city,
                              style: const TextStyle(color: Colors.white)));
                    }).toList(),
                    onChanged: selectedProvince == null
                        ? null
                        : (val) => setState(() => selectedCity = val),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: addressLine1Controller,
                    onChanged: (_) => setState(() {}),
                    decoration: _inputDecoration("Address Line 1"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: addressLine2Controller,
                    onChanged: (_) => setState(() {}),
                    decoration: _inputDecoration("Address Line 2"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: postalCodeController,
                    onChanged: (_) => setState(() {}),
                    decoration: _inputDecoration("Postal Code"),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 40),
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
            onPressed: isFormValid && !isLoading
                ? () async {
                    setState(() => isLoading = true);

                    final fullUserDetails = UserDetails(
                      firstName: widget.userDetails.firstName,
                      lastName: widget.userDetails.lastName,
                      email: widget.userDetails.email,
                      birthday: widget.userDetails.birthday,
                      mobile: widget.userDetails.mobile,
                      province: selectedProvince!,
                      city: selectedCity!,
                      addressLine1: addressLine1Controller.text.trim(),
                      addressLine2: addressLine2Controller.text.trim(),
                      postalCode: postalCodeController.text.trim(),
                      photoUrl: widget.userDetails.photoUrl,
                    );

                    final uid =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .set(fullUserDetails.toJson());

                    setState(() => isLoading = false);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Success(user: fullUserDetails),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD6D3FF),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.black)
                : const Text('Continue',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
