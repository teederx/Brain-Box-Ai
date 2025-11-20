import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/auth_options.dart';
import '../../auth/presentation/pages/signin_page.dart';
import '../../auth/presentation/pages/signup_page.dart';
import 'widgets/custom_button.dart';
import 'widgets/logo_animation.dart';

class WelcomePage extends StatefulWidget {
  static const routeName = 'welcome';
  static const routeSetting = '/welcome';
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _scale = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.8, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.8), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Center(
            child: Column(
              children: [
                Spacer(flex: 2),
                LogoAnimation(scale: _scale),
                29.65.verticalSpace,
                Text(
                  'Welcome to BrainBox',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Go to login page
                    CustomButton(
                      buttonColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.surface,
                      ontap: () {
                        context.pushNamed(SigninPage.routeName);
                      },
                      text: 'Log in',
                    ),

                    20.verticalSpace,

                    // Go to Singup page
                    CustomButton(
                      buttonColor: Theme.of(
                        context,
                      ).colorScheme.secondary.withAlpha(80),
                      textColor: Theme.of(context).colorScheme.secondary,
                      ontap: () {
                        context.pushNamed(SignupPage.routeName);
                      },
                      text: 'Sign up',
                    ),
                    44.verticalSpace,

                    AuthOptions(),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
