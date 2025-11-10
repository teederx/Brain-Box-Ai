import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/provider/theme_provider.dart';

class ThemeMenu extends ConsumerWidget {
  const ThemeMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<MyTheme>(
      tooltip: 'Select Theme',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.color_lens),
          5.horizontalSpace,
          const Text('Theme'),
        ],
      ),
      onSelected: (theme) {
        // debugPrint('Theme selected: $theme');
        ref.read(themeNotifierProvider.notifier).setTheme(theme);
      },
      itemBuilder:
          (context) => const [
            PopupMenuItem(value: MyTheme.system, child: Text("System Default")),
            PopupMenuItem(value: MyTheme.light, child: Text("Light")),
            PopupMenuItem(value: MyTheme.dark, child: Text("Dark")),
          ],
    );
  }
}
