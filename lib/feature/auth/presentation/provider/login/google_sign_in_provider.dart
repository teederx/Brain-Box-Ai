import 'package:ai_chat_app/feature/auth/data/repositories/provider/auth_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_sign_in_provider.g.dart';

@riverpod
class GoogleSignInController extends _$GoogleSignInController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authServiceProvider).signInWithGoogle();
    });
  }
}
