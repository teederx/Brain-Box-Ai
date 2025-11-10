import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFloatingNavigator extends StatelessWidget {
  const CustomFloatingNavigator({
    super.key,
    required this.currentPageIndex,
    required this.nextPage,
    required this.previousPage,
    required this.imagesLength,
  });

  final int currentPageIndex;
  final int imagesLength;
  final Function nextPage;
  final Function previousPage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      // shadowColor: Theme.of(context).colorScheme.onPrimary,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        height: 64.h,
        width: 154.w,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => previousPage(),
                child: SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: SvgPicture.asset(
                    'asset/svg/icons/left_arrow.svg',
                    fit: BoxFit.none,
                    colorFilter: ColorFilter.mode(
                      currentPageIndex == 0
                          ? Theme.of(
                            context,
                          ).colorScheme.secondary.withAlpha(100)
                          : Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            VerticalDivider(
              color: Theme.of(context).colorScheme.primary.withAlpha(50),
            ),
            Expanded(
              child: InkWell(
                onTap: () => nextPage(),
                child: SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: SvgPicture.asset(
                    'asset/svg/icons/right_arrow.svg',
                    fit: BoxFit.none,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
