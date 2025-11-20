import 'package:ai_chat_app/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/route_provider.dart';
import 'core/theme/provider/theme_provider.dart';
import 'core/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1️⃣ Watch state to trigger rebuilds
    ref.watch(themeNotifierProvider);

    // 2️⃣ Read notifier to get ThemeMode logic
    final themeMode = ref.read(themeNotifierProvider.notifier).themeMode;
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: 'BrainBox',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          
        );
      },
    );
  }
}
