import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWithBlur extends StatelessWidget {
  const ImageWithBlur({
    super.key,
    required this.imageSrc,
  });
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(height: 455.h, width: double.infinity),
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 414.h,
            width: 362.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Image.asset(
              imageSrc,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 2.h,
          child: Container(
            height: 439.h,
            width: 336.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Image.asset(
              imageSrc,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
