import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleWithDescription extends StatelessWidget {
  const TitleWithDescription({
    super.key,
    required this.currentPageIndex,
    required this.duration,
  });

  final int currentPageIndex;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 55.83.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: duration,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Text(
              _titles[currentPageIndex],
              key: ValueKey<int>(currentPageIndex),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 33.9.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Text(
            'Chat with the smartest AI Future Experience power of AI with us',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.3.sp,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

List<String> _titles = [
  'Unlock the Power Of Future AI',
  'Chat With Your Favorite AI',
  'Boost Your Mind Power with AI',
];
