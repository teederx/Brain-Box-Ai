import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonColor,
    required this.textColor,
    required this.ontap,
    required this.text,
  });
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: textColor,
        backgroundColor: buttonColor,
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 18.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Text(text),
    );
  }
}
