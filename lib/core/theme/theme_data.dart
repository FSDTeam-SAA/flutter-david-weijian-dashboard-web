import 'package:flutter/material.dart';

class AppThemes {
  // Define the updated theme with base color #2165FF
  static final ThemeData appThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF2165FF), // Primary Color: #2165FF
    scaffoldBackgroundColor: Colors.white, // Background: White
    cardColor: Colors.white, // Surface: White
    
    // App Bar Theme
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Color(0xFF2165FF), // AppBar: Primary Color
    //   elevation: 2, // Slight shadow
    // ),

    // Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // Primary Text: Black
      bodyMedium: TextStyle(color: Colors.black87), // Secondary Text: Dark Gray
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ), // Heading Text
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ), // Button Text
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: Colors.black), // Icons: Black
    // Divider Theme
    dividerColor: Colors.black26, // Dividers: Light Black/Gray
    // Button Theme
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF2165FF), // Buttons: Primary Color
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: Color(0xFF2165FF)), // Border Color
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2165FF), // Button: Primary Color
        foregroundColor: Colors.white, // Text: White
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF2165FF), // Primary: #2165FF
      secondary: Color(0xFF2165FF), // Secondary: #2165FF
      surface: Colors.white, // Surface: White
      error: Colors.red, // Error: Red
      onPrimary: Colors.white, // Text on Primary: White
      onSecondary: Colors.white, // Text on Secondary: White
      onSurface: Colors.black, // Text on Surface: Black
      onError: Colors.white, // Text on Error: White
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // TextField Background: White
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF2165FF)), // Border Color
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF2165FF),
        ), // Enabled Border
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF2165FF),
          width: 2,
        ), // Focused Border
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red), // Error Border
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ), // Focused Error Border
      ),
      labelStyle: const TextStyle(color: Colors.black87), // Label Text
      hintStyle: const TextStyle(color: Colors.black45), // Hint Text
      errorStyle: const TextStyle(color: Colors.red), // Error Text
    ),
  );
}
