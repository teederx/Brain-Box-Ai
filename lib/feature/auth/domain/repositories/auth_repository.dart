import 'package:ai_chat_app/feature/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> signup(String email, String password, String name);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signInWithGoogle();
}
