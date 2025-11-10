import 'package:ai_chat_app/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import '../../feature/onboarding/presentation/onboarding_page.dart';
import '../../feature/chat/presentation/screen/chat_screen.dart';
import '../../feature/signin/presentation/signin_page.dart';
import '../../feature/signup/presentation/signup_page.dart';
import '../../feature/welcome/presentation/welcome_page.dart';

part 'route_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: SplashScreen.routeSetting,
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
        path: SignupPage.routeSettings,
        name: SignupPage.routeName,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: ChatScreen.routeSetting,
        name: ChatScreen.routeName,
        builder: (context, state) => const ChatScreen(),
      ),
    ],
  );
}