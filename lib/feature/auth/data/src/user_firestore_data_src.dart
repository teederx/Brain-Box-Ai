import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/firebase/firebase_constants.dart';
import '../models/user_model.dart';

part 'user_firestore_data_src.g.dart';

class UserFirestoreDataSrc {
  UserFirestoreDataSrc();

  // Get User Profile
  Future<UserModel> getUser(String uid) async {
    try {
      final doc = await usersCollection.doc(uid).get();

      if (doc.exists) {
        return UserModel.fromDoc(doc);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Create or Update User Profile
  Future<void> setUser(UserModel user) async {
    try {
      await usersCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }
}

@riverpod
UserFirestoreDataSrc userFireStoreDataSrc(Ref ref) {
  return UserFirestoreDataSrc();
}
