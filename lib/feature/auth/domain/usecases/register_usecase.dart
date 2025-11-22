import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/core/usecase/usecase.dart';
import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUsecase implements UseCase<void, RegisterParams> {
  const RegisterUsecase(this.authService);
  final AuthRepository authService;

  @override
  Future<Either<Failure, void>> call(RegisterParams params) async {
    return await authService.signup(params.email, params.password, params.name);
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String name;

  RegisterParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
