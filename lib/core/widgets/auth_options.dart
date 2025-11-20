import 'package:ai_chat_app/feature/auth/presentation/provider/login/google_sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'social_auth_button.dart';

class AuthOptions extends ConsumerWidget {
  const AuthOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(googleSignInControllerProvider, (previous, next) {
      next.when(
        data: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Google Sign In successful!')),
          );
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
        loading: () {},
      );
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: Text('Continue With Accounts')),
        20.verticalSpace,

        // Socials button
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Google
            SocialAuthButton(
              color: const Color(0xFFD44638),
              text: 'GOOGLE',
              onTap: () {
                ref.read(googleSignInControllerProvider.notifier).signIn();
              },
            ),

            14.horizontalSpace,

            //Facebook
            SocialAuthButton(
              color: const Color(0xFF4267B2),
              text: 'FACEBOOK',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
