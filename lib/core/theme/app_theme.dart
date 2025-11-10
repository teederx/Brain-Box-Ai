import 'package:ai_chat_app/core/theme/provider/theme_provider.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.light(
      primary: Color(0xFF141718),
      secondary: Color(0xFF757171),
      surface: const Color(0xFFF7F8FA),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF141718),
    ),

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF141718),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFF141718)),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(color: Color(0xFF141718)),
      displayMedium: TextStyle(color: Color(0xFF141718)),
      displaySmall: TextStyle(color: Color(0xFF141718)),
      headlineLarge: TextStyle(color: Color(0xFF141718)),
      headlineMedium: TextStyle(color: Color(0xFF141718)),
      headlineSmall: TextStyle(color: Color(0xFF141718)),
      titleLarge: TextStyle(color: Color(0xFF141718)),
      titleMedium: TextStyle(color: Color(0xFF141718)),
      titleSmall: TextStyle(color: Color(0xFF141718)),
      bodyLarge: TextStyle(color: Color(0xFF141718)),
      bodyMedium: TextStyle(color: Color(0xFF141718)),
      bodySmall: TextStyle(color: Color(0xFF757171)),
      labelLarge: TextStyle(color: Color(0xFF141718)),
      labelMedium: TextStyle(color: Color(0xFF757171)),
      labelSmall: TextStyle(color: Color(0xFFCBCCCD)),
    ),

    iconTheme: IconThemeData(color: Color(0xFF141718)),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF141718),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Color(0xFF141718)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF7F8FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF141718), width: 2),
      ),
      hintStyle: TextStyle(color: Color(0xFFCBCCCD)),
      labelStyle: TextStyle(color: Color(0xFF757171)),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFF757171),
      surface: const Color(0xFF000000),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Color(0xFFFFFFFF),
    ),

    scaffoldBackgroundColor: Colors.black,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(color: Color(0xFFFFFFFF)),
      displayMedium: TextStyle(color: Color(0xFFFFFFFF)),
      displaySmall: TextStyle(color: Color(0xFFFFFFFF)),
      headlineLarge: TextStyle(color: Color(0xFFFFFFFF)),
      headlineMedium: TextStyle(color: Color(0xFFFFFFFF)),
      headlineSmall: TextStyle(color: Color(0xFFFFFFFF)),
      titleLarge: TextStyle(color: Color(0xFFFFFFFF)),
      titleMedium: TextStyle(color: Color(0xFFFFFFFF)),
      titleSmall: TextStyle(color: Color(0xFFFFFFFF)),
      bodyLarge: TextStyle(color: Color(0xFFFFFFFF)),
      bodyMedium: TextStyle(color: Color(0xFFFFFFFF)),
      bodySmall: TextStyle(color: Color(0xFF757171)),
      labelLarge: TextStyle(color: Color(0xFFFFFFFF)),
      labelMedium: TextStyle(color: Color(0xFF757171)),
      labelSmall: TextStyle(color: Color(0xFF757474)),
    ),

    iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),

    cardTheme: CardThemeData(
      color: Color(0xFF1A1A1A),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFFFFF),
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Color(0xFFFFFFFF)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1A1A1A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2),
      ),
      hintStyle: TextStyle(color: Color(0xFF757474)),
      labelStyle: TextStyle(color: Color(0xFF757171)),
    ),
  );

  // Helper method to get theme based on MyTheme enum
  static ThemeData getTheme(MyTheme theme) {
    return theme == MyTheme.light ? lightTheme : darkTheme;
  }
}
