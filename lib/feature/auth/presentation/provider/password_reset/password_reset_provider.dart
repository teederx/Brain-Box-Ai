import 'package:ai_chat_app/feature/auth/data/repositories/provider/auth_service_provider.dart';
import 'package:ai_chat_app/feature/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_reset_provider.g.dart';

@riverpod
class PasswordReset extends _$PasswordReset {
  @override
  FutureOr<void> build() {
    // _key = Object();
  }

  Future<void> sendResetEmail({required String email}) async {
    state = const AsyncLoading();

    final authService = ref.read(authServiceProvider);
    final emailResetUsecase = SendPasswordResetEmailUsecase(authService);

    final result = await emailResetUsecase.call(email);

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }
}
