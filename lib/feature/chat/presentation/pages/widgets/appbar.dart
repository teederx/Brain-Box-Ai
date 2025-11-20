import 'package:ai_chat_app/feature/auth/presentation/provider/logout/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_back_botton.dart';
import '../../../../../core/widgets/theme_menu.dart';

class Appbar extends ConsumerWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Row(
        children: [
          CustomBackBotton(),
          Spacer(),
          ThemeMenu(),
          IconButton(
            onPressed: () => ref.read(logoutProvider.notifier).logout(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
