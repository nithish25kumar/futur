import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futur/repositary/screens/MainNav/MainNavPage.dart';
import 'package:futur/repositary/screens/homepage/homepage.dart';
import 'package:futur/repositary/screens/registerorlogin/register.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/userDetail.dart';

class Profile extends StatefulWidget {
  final UserDetails user;

  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.black,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SpeedPage()),
                  );
                }
              },
            ),
          ],
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color(0xFFFFCDD2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: const Text(
            'Profile Page',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 2,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainNavPage(user: widget.user),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: widget.user.photoUrl != null &&
                      widget.user.photoUrl!.isNotEmpty
                  ? NetworkImage(widget.user.photoUrl!)
                  : null,
              child:
                  widget.user.photoUrl == null || widget.user.photoUrl!.isEmpty
                      ? Text(
                          "${widget.user.firstName[0]}${widget.user.lastName[0]}"
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.redAccent),
                        const SizedBox(width: 10),
                        Text(
                          "${widget.user.firstName} ${widget.user.lastName}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.email, color: Colors.redAccent),
                        const SizedBox(width: 10),
                        Text(
                          widget.user.email,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.user.mobile,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Creator Info',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black12,
                  backgroundImage: AssetImage('assets/images/nithish1.jpeg'),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Nithishkumar K',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'VIT Vellore',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(
                        'https://www.linkedin.com/in/nithish-kumar-9b29b3287/'));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.linkedinIn,
                          size: 20, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        'Linked In',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
