import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/core/usecase/usecase.dart';
import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUsecase implements UseCase<void, NoParams> {
  const LogoutUsecase(this.authService);
  final AuthRepository authService;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authService.logout();
  }
}
