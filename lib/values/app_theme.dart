import 'package:flutter/material.dart';
import 'index.dart';

class AppThemes {
  ///Config ThemeData For LightMode
  static ThemeData lightTheme(BuildContext context) {
    final baseTheme = ThemeData.light();

    return ThemeData(
      fontFamily: "Poppins",
      primaryColor: AppColors.colorPrimaryApp2,
      canvasColor: const Color(0xFFFFFFFF),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.colorPrimaryApp2,
      ),
      shadowColor: Color(0xff6F87C3).withOpacity(0.25),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.colorPrimaryApp2,
        foregroundColor: Colors.white,
      ),
      cardColor: Colors.white,
      primaryIconTheme: baseTheme.iconTheme.copyWith(
        color: const Color(0xFF9C9C9C),
      ),
      indicatorColor: const Color(0xFF565656),
      iconTheme: baseTheme.iconTheme.copyWith(
        color: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      dividerTheme: const DividerThemeData(
        thickness: 1.0,
        color: Color(0xFFEAF0FD),
      ),
      dividerColor: const Color(0xFFEAF0FD),
      disabledColor: Colors.grey[400],
      tabBarTheme: baseTheme.tabBarTheme.copyWith(
        labelColor: AppColors.colorPrimaryApp2,
        unselectedLabelColor: const Color(0xFF8E9ABB),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      appBarTheme: AppBarTheme(
        color: baseTheme.cardColor,
        iconTheme: const IconThemeData(color: Color(0xFF212633)),
      ),
      highlightColor: AppColors.colorPrimaryApp2,
      colorScheme: const ColorScheme.light().copyWith(
        error: Colors.red,
        secondary: const Color(0xFF8E9ABB),
        onSecondary: const Color(0xFF6AA4D2),
        background: const Color(0xFFEAEAF0),
        onPrimary: Colors.white,
        primary: AppColors.colorPrimaryApp2,
        onBackground: const Color(0xFF0095DE),
        onSurface: Colors.black87,
        surface: const Color(0xFFEDEDED),
      ),
      cardTheme: baseTheme.cardTheme.copyWith(
        elevation: 0.0,
        shadowColor: Color(0xff6F87C3).withOpacity(0.25),
      ),
    );
  }

  ///Config ThemeData For DarkMode
  static ThemeData darkTheme(BuildContext context) {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      dividerColor: const Color(0xFF353F4A),
      scaffoldBackgroundColor: const Color(0xFF2A3139),
      cardColor: const Color(0xFF1E252D),
      primaryColor: const Color(0xFF3366FF),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF3366FF),
      ),
      appBarTheme: AppBarTheme(
        color: const Color(0xFF171717),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      tabBarTheme: baseTheme.tabBarTheme.copyWith(
        labelColor: const Color(0xFFFFFFFF),
        unselectedLabelColor: const Color(0xFFB1B1B1),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      colorScheme: const ColorScheme.dark().copyWith(
        secondary: const Color(0xFF8A89A0),
        onSecondary: Colors.white,
        background: Colors.black,
        surface: const Color(0xFF121212),
        onBackground: Colors.grey,
        onPrimary: Colors.white,
      ),
      cardTheme: baseTheme.cardTheme.copyWith(elevation: 0.0),
    );
  }

  ThemeData getTheme(BuildContext context, bool isLight) {
    if (isLight) {
      return lightTheme(context);
    } else {
      return darkTheme(context);
    }
  }
}
