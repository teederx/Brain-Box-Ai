import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  const LoginUsecase(this.authService);
  final AuthRepository authService;

  Future<void> call({required String email, required String password}) async {
    await authService.login(email, password);
  }
}
