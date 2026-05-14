import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final String? webClientId;

  AuthService({
    this.webClientId,
  });

  late final GoogleSignIn
  _googleSignIn =
  GoogleSignIn(
    clientId: kIsWeb
        ? webClientId
        : null,
  );

  Future<UserModel?> signInWithGoogle()
  async {
    try {
      final GoogleSignInAccount?
      googleUser =
      await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication
      googleAuth =
      await googleUser
          .authentication;

      final credential =
      GoogleAuthProvider.credential(
        accessToken:
        googleAuth.accessToken,

        idToken:
        googleAuth.idToken,
      );

      final userCredential =
      await _auth
          .signInWithCredential(
        credential,
      );

      final user =
          userCredential.user;

      if (user == null) {
        return null;
      }

      return UserModel(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
      );
    } catch (e) {
      debugPrint(
        'Google Login Error: $e',
      );

      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();

    await _auth.signOut();
  }

  UserModel? getCurrentUser() {
    final user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    return UserModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
    );
  }
}