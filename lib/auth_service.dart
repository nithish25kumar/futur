import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../model/userDetail.dart';

class AuthService {
  static Future<UserDetails?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut(); // force fresh login
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final email = userCredential.user?.email;
      if (email == null) return null;

      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        await FirebaseAuth.instance.signOut();
        await googleSignIn.signOut();
        return null;
      }

      final data = query.docs.first.data();

      return UserDetails(
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        birthday: data['birthday'] ?? '',
        mobile: data['mobile'] ?? '',
        province: data['province'] ?? '',
        city: data['city'] ?? '',
        addressLine1: data['addressLine1'] ?? '',
        addressLine2: data['addressLine2'] ?? '',
        postalCode: data['postalCode'] ?? '',
        photoUrl: userCredential.user?.photoURL,
      );
    } catch (e) {
      rethrow;
    }
  }
}
