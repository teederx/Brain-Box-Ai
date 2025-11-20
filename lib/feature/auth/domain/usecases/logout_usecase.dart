import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  const LogoutUsecase(this.authService);
  final AuthRepository authService;

  Future<void> call() async {
    await authService.logout();
  }
}
