import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../welcome/presentation/welcome_page.dart';
import 'widgets/custom_floating_navigator.dart';
import 'widgets/dots_indicator.dart';
import 'widgets/image_with_blur.dart';
import 'widgets/title_with_description.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = 'onboarding';
  static const routeSetting = '/onboarding';

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _duration = const Duration(milliseconds: 300);
  final _autoScrollInterval = const Duration(seconds: 5);

  int _currentPageIndex = 0;
  bool _isNext = true;
  Timer? _timer;

  final List<String> _images = const [
    'asset/image/robot-1.png',
    'asset/image/robot-2.png',
    'asset/image/robot-3.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(_autoScrollInterval, (_) {
      if (!mounted) return;

      if (_currentPageIndex == _images.length - 1) {
        _timer?.cancel();
      } else {
        _nextPage(context, auto: true);
      }
    });
  }

  void _nextPage(BuildContext context, {bool auto = false}) {
    if (_currentPageIndex < _images.length - 1) {
      setState(() {
        _isNext = true;
        _currentPageIndex++;
      });
    } else if (!auto) {
      // ✅ Navigate using GoRouter safely
      GoRouter.of(context).goNamed(WelcomePage.routeName);
    }
  }

  void _previousPage() {
    // Restart auto-scroll if it was stopped
    if (!(_timer?.isActive ?? false)) _startAutoScroll();

    if (_currentPageIndex > 0) {
      setState(() {
        _isNext = false;
        _currentPageIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🖼️ Image with animation
                AnimatedSwitcher(
                  duration: _duration,
                  transitionBuilder: (child, animation) {
                    final beginOffset =
                        _isNext
                            ? const Offset(1.0, 0.0)
                            : const Offset(-1.0, 0.0);
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: beginOffset,
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: ImageWithBlur(
                    key: ValueKey<int>(_currentPageIndex),
                    imageSrc: _images[_currentPageIndex],
                  ),
                ),

                19.verticalSpace,

                // 🔘 Dots Indicator
                DotsIndicator(
                  currentPageIndex: _currentPageIndex,
                  length: _images.length,
                ),

                21.3.verticalSpace,

                // 📝 Title + Description
                TitleWithDescription(
                  currentPageIndex: _currentPageIndex,
                  duration: _duration,
                ),
              ],
            ),
          ),
        ),
      ),

      // ⬆️ Bottom Navigator Buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingNavigator(
        currentPageIndex: _currentPageIndex,
        nextPage: () => _nextPage(context),
        previousPage: _previousPage,
        imagesLength: _images.length,
      ),
    );
  }
}
