import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    textTheme: GoogleFonts.muktaTextTheme(),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal.shade800,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(Colors.amber.shade800),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: const MaterialStatePropertyAll(
          TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: MaterialStatePropertyAll(Colors.amber.shade800),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber.shade800,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
  );
}
