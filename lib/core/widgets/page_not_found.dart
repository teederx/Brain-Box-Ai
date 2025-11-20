import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../feature/welcome/presentation/welcome_page.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key, required this.eMsg});
  final String eMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                eMsg,
                style: TextStyle(fontSize: 18.sp, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              20.verticalSpace,
              OutlinedButton(
                onPressed: () {
                  GoRouter.of(context).goNamed(WelcomePage.routeName);
                },
                child: const Text(
                  'Go to Welcome Page',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}