import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoAnimation extends StatelessWidget {
  const LogoAnimation({super.key, required this.scale});

  final Animation<double> scale;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scale,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(height: 184.35.h, width: 154.w),
            Positioned(
              bottom: 35.h,
              right: 15.w * scale.value,
              child: ScaleTransition(
                scale: scale,
                child: SvgPicture.asset(
                  'asset/svg/Rectangle 1.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40.h,
              left: 5.w * scale.value,
              child: ScaleTransition(
                scale: scale,
                child: SvgPicture.asset(
                  'asset/svg/Rectangle 2.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.h * scale.value,
              left: 45.w,
              child: ScaleTransition(
                scale: scale,
                child: SvgPicture.asset(
                  'asset/svg/Rectangle 3.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
