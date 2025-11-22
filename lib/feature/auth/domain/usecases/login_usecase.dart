import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/core/usecase/usecase.dart';
import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase implements UseCase<void, LoginParams> {
  const LoginUsecase(this.authService);
  final AuthRepository authService;

  @override
  Future<Either<Failure, void>> call(LoginParams params) async {
    return await authService.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
