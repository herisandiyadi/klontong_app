import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final MaterialColor tokopediaGreen = MaterialColor(0xFF03AC0E, <int, Color>{
  50: Color(0xFFE3F8E6),
  100: Color(0xFFB8EDC2),
  200: Color(0xFF8BE19B),
  300: Color(0xFF5ED574),
  400: Color(0xFF3ACD56),
  500: Color(0xFF03AC0E),
  600: Color(0xFF039F0C),
  700: Color(0xFF028C0A),
  800: Color(0xFF027A08),
  900: Color(0xFF015B05),
});

final appTheme = ThemeData(
  primarySwatch: tokopediaGreen,
  primaryColor: tokopediaGreen,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: tokopediaGreen,
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: tokopediaGreen,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: tokopediaGreen,
    foregroundColor: Colors.white,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
  useMaterial3: true,
);
