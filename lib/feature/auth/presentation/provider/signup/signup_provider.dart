import 'package:ai_chat_app/feature/auth/data/repositories/provider/auth_service_provider.dart';
import 'package:ai_chat_app/feature/auth/domain/usecases/register_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_provider.g.dart';

@riverpod
class Signup extends _$Signup {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      _key = null;
    });
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncLoading();
    final key = _key;

    final authService = ref.read(authServiceProvider);
    final registerUseCase = RegisterUsecase(authService);

    final newState = await AsyncValue.guard(
      () => registerUseCase.call(email: email, password: password, name: name),
    );

    if (key == _key) {
      state = newState;
    }
  }
}
