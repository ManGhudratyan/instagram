import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_service.dart';

class AuthServiceImp implements AuthService {
  AuthServiceImp({required this.firebaseFirestore});

  final FirebaseFirestore firebaseFirestore;

  @override
  Future<UserCredential> signInWithGoogle() async {
    final gUser = await GoogleSignIn().signIn();
    final gAuth = await gUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
      {
        'userId': userCredential.user?.uid,
        'email': userCredential.user?.email,
      },
    );
    return userCredential;
  }
}
