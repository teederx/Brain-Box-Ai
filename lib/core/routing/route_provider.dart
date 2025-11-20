import 'package:ai_chat_app/core/widgets/page_not_found.dart';
import 'package:ai_chat_app/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../feature/auth/presentation/pages/forgot_password_page.dart';
import '../../feature/chat/presentation/pages/chat_screen.dart';
import '../../feature/onboarding/presentation/onboarding_page.dart';
import '../../feature/auth/presentation/pages/signin_page.dart';
import '../../feature/auth/presentation/pages/signup_page.dart';
import '../../feature/welcome/presentation/welcome_page.dart';
import '../../feature/auth/data/repositories/provider/auth_service_provider.dart';
import '../widgets/firebase_error_page.dart';

part 'route_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: SplashScreen.routeSetting,
    redirect: (context, state) {
      if (authState is AsyncLoading<User?>) {
        return WelcomePage.routeSetting;
      }

      if (authState is AsyncError<User?>) {
        return FirebaseErrorPage.routeSetting;
      }
      final authenticated = authState.valueOrNull != null;

      final authenticatingPage =
          (state.matchedLocation == SplashScreen.routeSetting) ||
          (state.matchedLocation == OnboardingPage.routeSetting) ||
          (state.matchedLocation == WelcomePage.routeSetting) ||
          (state.matchedLocation == SigninPage.routeSettings) ||
          (state.matchedLocation == SignupPage.routeSettings) ||
          (state.matchedLocation == ForgotPasswordPage.routeSetting);

      if (authenticated == false) {
        return authenticatingPage ? null : WelcomePage.routeSetting;
      }
      return authenticatingPage ? ChatScreen.routeSetting : null;
    },
    routes: [
      GoRoute(
        path: SplashScreen.routeSetting,
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: WelcomePage.routeSetting,
        name: WelcomePage.routeName,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: OnboardingPage.routeSetting,
        name: OnboardingPage.routeName,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: SigninPage.routeSettings,
        name: SigninPage.routeName,
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        path: ForgotPasswordPage.routeSetting,
        name: ForgotPasswordPage.routeName,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: SignupPage.routeSettings,
        name: SignupPage.routeName,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: ChatScreen.routeSetting,
        name: ChatScreen.routeName,
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: FirebaseErrorPage.routeSetting,
        name: FirebaseErrorPage.routeName,
        builder: (context, state) => const FirebaseErrorPage(),
      ),
    ],
    errorBuilder:
        (context, state) => PageNotFound(eMsg: state.error.toString()),
  );
}
