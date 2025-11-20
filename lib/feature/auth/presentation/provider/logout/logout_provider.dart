import 'package:ai_chat_app/feature/auth/data/repositories/provider/auth_service_provider.dart';
import 'package:ai_chat_app/feature/auth/domain/usecases/logout_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

@riverpod
class Logout extends _$Logout {
  Object? _key;
  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
  }

  Future<void> logout() async {
    state = const AsyncLoading();

    final key = _key;

    final authService = ref.read(authServiceProvider);
    final logoutUsecase = LogoutUsecase(authService);

    if (key == _key) {
      state = await AsyncValue.guard(() => logoutUsecase.call());
    }
  }
}
