import 'package:ai_chat_app/feature/auth/presentation/provider/logout/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/theme_menu.dart';

class Appbar extends ConsumerWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          Spacer(),
          Text(
            'BrainBox A.I.',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          PopupMenuButton(
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: 'theme', child: ThemeMenu()),
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        IconButton(
                          onPressed:
                              () => ref.read(logoutProvider.notifier).logout(),
                          icon: Icon(Icons.logout),
                        ),
                        const Text('Logout'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
    );
  }
}
