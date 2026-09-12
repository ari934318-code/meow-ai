import 'package:flutter/material.dart';

class AppTheme {
  // Lavender / purple seed color for a soft iOS-inspired accent
  static const Color _seedLavender = Color(0xFF8E7BFF);

  // Common typography that is easy to extend later
  static final TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w600),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w600),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );

  // Shared component defaults to keep a consistent look
  static ThemeData _baseTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _seedLavender,
      brightness: brightness,
    );

    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor:
          isDark ? Colors.black : const Color(0xFFF7F7FB), // soft bg for iOS feel
      textTheme: _textTheme.apply(
        bodyColor: isDark ? Colors.white : Colors.black87,
        displayColor: isDark ? Colors.white : Colors.black87,
      ),
      // Card theme: rounded, elevated lightly, roomy padding
      cardTheme: CardTheme(
        color: isDark ? Color(0xFF1B1B1F) : Colors.white,
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      // Inputs: filled, high contrast label, rounded corners
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? Color(0xFF121215) : Color(0xFFF2F4F8),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.8)),
        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
      ),
      // Elevated buttons: pill-ish, prominent primary color
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      // Navigation bar: iOS-inspired bottom navigation with subtle indicator
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark ? Color(0xFF0F0F0F) : Colors.white,
        indicatorColor: colorScheme.primary.withOpacity(0.12),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 64,
        labelTextStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black87,
        )),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(color: colorScheme.primary);
          }
          return IconThemeData(color: isDark ? Colors.white70 : Colors.black54);
        }),
      ),
      // App bar: translucent-ish with no heavy elevation
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? Color(0xFF0F0F0F) : Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: isDark ? Colors.white : Colors.black87,
        ),
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
      ),
      // Maintain accessibility: ensure high contrast for important controls
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? Colors.white10 : Colors.black87,
        contentTextStyle: TextStyle(color: isDark ? Colors.white : Colors.white),
      ),
      // Use consistent visual density
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Public API: keep these names unchanged so callers continue to work
  static final ThemeData lightTheme = _baseTheme(Brightness.light);
  static final ThemeData darkTheme = _baseTheme(Brightness.dark);
}
