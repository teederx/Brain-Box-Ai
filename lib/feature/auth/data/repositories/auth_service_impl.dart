import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/feature/auth/data/models/user_model.dart';
import 'package:ai_chat_app/feature/auth/data/src/auth_firebase_data_src.dart';
import 'package:ai_chat_app/feature/auth/data/src/user_firestore_data_src.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthServiceImpl implements AuthRepository {
  final AuthFirebaseDataSrc authFirebaseDataSrc;
  final UserFirestoreDataSrc userFirestoreDataSrc;

  AuthServiceImpl({
    required this.authFirebaseDataSrc,
    required this.userFirestoreDataSrc,
  });

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    try {
      final firebaseUser = authFirebaseDataSrc.currentUser;
      if (firebaseUser == null) {
        return const Right(null);
      }

      final user = await userFirestoreDataSrc.getUser(firebaseUser.uid);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      await authFirebaseDataSrc.signIn(email, password);
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authFirebaseDataSrc.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await authFirebaseDataSrc.sendResetPasswordMail(email);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signup(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await authFirebaseDataSrc.register(email, password);

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        return const Left(
          AuthFailure('Registration failed. Could not register user'),
        );
      }

      final newUser = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? email,
        name: firebaseUser.displayName ?? name,
      );

      await userFirestoreDataSrc.setUser(newUser);
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      final credential = await authFirebaseDataSrc.signInWithGoogle();
      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        return const Left(
          AuthFailure('Google Sign In failed. Could not retrieve user.'),
        );
      }

      final user = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? '',
      );

      await userFirestoreDataSrc.setUser(user);
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
