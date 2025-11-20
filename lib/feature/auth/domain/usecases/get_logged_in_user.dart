import 'package:ai_chat_app/feature/auth/domain/entities/user_entity.dart';
import 'package:ai_chat_app/feature/auth/domain/repositories/auth_repository.dart';

class GetLoggedInUser {
  const GetLoggedInUser(this.authService);
  final AuthRepository authService;

  Future<UserEntity> call() async {
    final result = await authService.getCurrentUser();
    if (result == null) {
      return UserEntity(id: "", name: "", email: "");
    }
    final user = UserEntity(
      id: result.uid,
      name: result.name,
      email: result.email,
    );

    return user;
  }
}
