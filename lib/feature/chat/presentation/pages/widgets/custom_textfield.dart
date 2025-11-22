import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.onSend,
    required this.controller,
  });

  final Function onSend;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
      child: Material(
        borderRadius: BorderRadius.circular(7.r),
        elevation: 5,
        shadowColor: Theme.of(context).colorScheme.primary.withAlpha(40),
        child: TextField(
          controller: controller,
          minLines: 1,
          maxLines: 6,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Type a message',
            suffixIcon: IconButton(
              icon: Icon(Icons.send_rounded),
              onPressed: () => onSend(),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary.withAlpha(5),
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(7.r),
            ),
          ),
        ),
      ),
    );
  }
}
