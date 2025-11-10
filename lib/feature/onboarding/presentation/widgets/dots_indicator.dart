import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    super.key,
    required this.currentPageIndex,
    required this.length,
  });

  final int currentPageIndex;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (int index) => Stack(
          alignment: Alignment.center,
          children: [
            if (index == currentPageIndex)
              Container(
                height: 17.68.h,
                width: 17.68.w,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 0.5,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: index == currentPageIndex ? 12.h : 10.h,
              width: index == currentPageIndex ? 12.w : 10.w,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentPageIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
