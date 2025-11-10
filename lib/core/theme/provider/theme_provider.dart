import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  MyTheme build() {
    return MyTheme.system; // default: follow device setting
  }

  void setTheme(MyTheme theme) {
    state = theme;
  }

  /// Optional toggle (Light <-> Dark), ignoring system
  void toggle() {
    if (state == MyTheme.light) {
      state = MyTheme.dark;
    } else if (state == MyTheme.dark) {
      state = MyTheme.light;
    } else {
      // If currently system, default toggle goes to light
      state = MyTheme.light;
    }
  }

  /// Converts MyTheme to Flutter's ThemeMode
  ThemeMode get themeMode {
    switch (state) {
      case MyTheme.light:
        return ThemeMode.light;
      case MyTheme.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

enum MyTheme { system, light, dark }
