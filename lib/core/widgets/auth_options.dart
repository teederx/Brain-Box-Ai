import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'social_auth_button.dart';

class AuthOptions extends StatelessWidget {
  const AuthOptions({super.key});

  @override
  Widget build(BuildContext context) {
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
              onTap: () {}, //TODO: Google for login
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
