import 'package:ai_chat_app/core/firebase/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_firebase_data_src.g.dart';

class AuthFirebaseDataSrc {
  final gsi.GoogleSignIn _googleSignIn;

  AuthFirebaseDataSrc({gsi.GoogleSignIn? googleSignIn})
    : _googleSignIn = googleSignIn ?? gsi.GoogleSignIn.instance;

  //Email and Password Sign Up
  Future<UserCredential> register(String email, String password) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      //throw _mapFirebaseException(e);
      rethrow;
    }
  }

  //Email and Password Sign In
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final userCredential = await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      //throw _mapFirebaseException(e);
      rethrow;
    }
  }

  //Password Reset Email
  Future<void> sendResetPasswordMail(String email) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  //Verify Email Code & Confirm password reset
  // Future<void> confirmPassWordReset(String code, String newPassword) async {
  //   try {
  //     await Future.wait([
  //       fbAuth.verifyPasswordResetCode(code),
  //       fbAuth.confirmPasswordReset(code: code, newPassword: newPassword),
  //     ]);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //Google Sign In
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Initialize GoogleSignIn (required for google_sign_in 7.0.0+)
      // We assume the scopes are passed here.
      // Note: If this throws, it might be because it's already initialized or the API is different.
      // But based on 7.0.0 changes, this is required.
      // We use a try-catch around init if we want to be safe, but let's just call it.
      await _googleSignIn.initialize();

      // Re-assign googleUser
      final gsi.GoogleSignInAccount? googleUser =
          await _googleSignIn.authenticate();

      if (googleUser == null) {
        throw FirebaseAuthException(
          code: "ERROR_ABORTED_BY_USER",
          message: "Sign in aborted by user",
        );
      }

      final gsi.GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        // accessToken is not available in GoogleSignInAuthentication in 7.0.0+
        // and is optional for Firebase GoogleAuthProvider.
      );

      return await fbAuth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([fbAuth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      rethrow;
    }
  }

  //Current User
  User? get currentUser => fbAuth.currentUser;
}

@riverpod
AuthFirebaseDataSrc authFirebaseDataSrc (Ref ref) {
  return AuthFirebaseDataSrc();
}