import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/core/usecase/usecase.dart';
import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SendPasswordResetEmailUsecase implements UseCase<void, String> {
  const SendPasswordResetEmailUsecase(this.authService);

  final AuthRepository authService;

  @override
  Future<Either<Failure, void>> call(String email) async {
    return await authService.sendPasswordResetEmail(email);
  }
}
