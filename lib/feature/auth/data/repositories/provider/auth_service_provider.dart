import 'package:ai_chat_app/core/firebase/firebase_constants.dart';
import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../src/auth_firebase_data_src.dart';
import '../../src/user_firestore_data_src.dart';
import '../auth_service_impl.dart';

part 'auth_service_provider.g.dart';

@riverpod
AuthRepository authService(Ref ref) {
  final authFirebaseDataSrc = AuthFirebaseDataSrc();
  final userFirestoreDataSrc = UserFirestoreDataSrc();
  return AuthServiceImpl(
    authFirebaseDataSrc: authFirebaseDataSrc,
    userFirestoreDataSrc: userFirestoreDataSrc,
  );
}

@riverpod
Stream<User?> authStateChanges(Ref ref) {
  return fbAuth.authStateChanges();
}
