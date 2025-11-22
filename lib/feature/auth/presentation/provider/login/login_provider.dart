import 'package:ai_chat_app/feature/auth/data/repositories/provider/auth_service_provider.dart';
import 'package:ai_chat_app/feature/auth/domain/usecases/login_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      _key = null;
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();

    final key = _key;

    final authService = ref.read(authServiceProvider);
    final loginUseCase = LoginUsecase(authService);

    if (key == _key) {
      final result = await loginUseCase.call(
        LoginParams(email: email, password: password),
      );

      state = result.fold(
        (failure) => AsyncValue.error(failure.message, StackTrace.current),
        (_) => const AsyncValue.data(null),
      );
    }
  }
}
