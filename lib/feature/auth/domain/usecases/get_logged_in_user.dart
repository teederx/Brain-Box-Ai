import 'package:ai_chat_app/core/error/failure.dart';
import 'package:ai_chat_app/core/usecase/usecase.dart';
import 'package:ai_chat_app/feature/auth/domain/entities/user_entity.dart';
import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetLoggedInUser implements UseCase<UserEntity, NoParams> {
  const GetLoggedInUser(this.authService);
  final AuthRepository authService;

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    final result = await authService.getCurrentUser();

    return result.map((userModel) {
      if (userModel == null) {
        return const UserEntity(id: "", name: "", email: "");
      }
      return UserEntity(
        id: userModel.uid,
        name: userModel.name,
        email: userModel.email,
      );
    });
  }
}
