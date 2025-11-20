import 'package:ai_chat_app/core/error/handle_exceptions.dart';
import 'package:ai_chat_app/feature/auth/data/models/user_model.dart';
import 'package:ai_chat_app/feature/auth/data/src/auth_firebase_data_src.dart';
import 'package:ai_chat_app/feature/auth/data/src/user_firestore_data_src.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthServiceImpl implements AuthRepository {
  final AuthFirebaseDataSrc authFirebaseDataSrc;
  final UserFirestoreDataSrc userFirestoreDataSrc;

  AuthServiceImpl({
    required this.authFirebaseDataSrc,
    required this.userFirestoreDataSrc,
  });

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final firebaseUser = authFirebaseDataSrc.currentUser;

      final user = await userFirestoreDataSrc.getUser(firebaseUser!.uid);
      return user;
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      print('Login attempt: $email, $password');
      await authFirebaseDataSrc.signIn(email, password);
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await authFirebaseDataSrc.signOut();
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await authFirebaseDataSrc.sendResetPasswordMail(email);
    } catch (e) {
      throw handleException(e);
    }
  }

  // @override
  // Future<void> confirmPasswordReset(String code, String newPassword) async {
  //   try {
  //     await authFirebaseDataSrc.confirmPassWordReset(code, newPassword);
  //   } catch (e) {
  //     throw handleException(e);
  //   }
  // }

  @override
  Future<void> signup(String email, String password, String name) async {
    try {
      final credential = await authFirebaseDataSrc.register(email, password);

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw Exception('Registration failed. Could not register user');
      }

      final newUser = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? email,
        name: firebaseUser.displayName ?? name,
      );

      await userFirestoreDataSrc.setUser(newUser);
    } catch (e) {
      throw handleException(e);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final credential = await authFirebaseDataSrc.signInWithGoogle();
      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw Exception('Google Sign In failed. Could not retrieve user.');
      }

      final user = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? '',
      );

      await userFirestoreDataSrc.setUser(user);
    } catch (e) {
      throw handleException(e);
    }
  }
}
