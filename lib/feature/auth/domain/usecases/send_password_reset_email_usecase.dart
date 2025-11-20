import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';

class SendPasswordResetEmailUsecase {
  const SendPasswordResetEmailUsecase(this.authService);

  final AuthRepository authService;

  Future<void> call({required String email}) async {
    await authService.sendPasswordResetEmail(email);
  }
}