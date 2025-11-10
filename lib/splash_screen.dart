import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'feature/onboarding/presentation/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash';
  static const routeSetting = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showFirst = true;

  @override
  void initState() {
    super.initState();

    // Start animation AFTER the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 5), () {
        _crossFade();
      });
    });
  }

  void _crossFade() {
    setState(() {
      _showFirst = false;
    });

    Future.delayed(
      Duration(seconds: 3),
      // ignore: use_build_context_synchronously
      () => context.goNamed(OnboardingPage.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                      child: child,
                    ),
                  );
                },
                child:
                    _showFirst
                        ? SvgPicture.asset(
                          'asset/svg/Logo.svg',
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        )
                        : Text(
                          'Brain AI',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.02.sp,
                          ),
                        ),
              ),
              Spacer(),
              AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: _showFirst ? 1 : 0,
                child: Text(
                  'BrainBox',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.02,
                  ),
                ),
              ),
              Text(
                'Built with Gemini AI',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  letterSpacing: -0.02,
                  fontSize: 14.sp,
                ),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
