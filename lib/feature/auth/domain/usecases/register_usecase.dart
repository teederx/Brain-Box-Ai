import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  const RegisterUsecase(this.authService);
  final AuthRepository authService;

  Future<void> call({
    required String email,
    required String password,
    required String name,
  }) async {
    await authService.signup(email, password, name);
  }
}
