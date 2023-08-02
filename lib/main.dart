import 'package:bmi_calculator/bmi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension StringExtension on String {
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split('_')
      .map((str) => str.capitalize())
      .join(' ');
}

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 131, 56, 236),
  secondary: const Color.fromARGB(255,205, 175, 247),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'BMI Calculator',
      home: const BMICalculator(),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          titleTextStyle: GoogleFonts.lobsterTwo(
            letterSpacing: 2.5,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.onPrimary,
          iconTheme: const IconThemeData().copyWith(
            color: kColorScheme.onPrimary,
            size: 35,
          ),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondary,
          margin: const EdgeInsets.all(10),
        ),
        textTheme: const TextTheme().copyWith(
          titleMedium: TextStyle(
            color: kColorScheme.onPrimaryContainer,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: const TextStyle(fontSize: 21),
          bodySmall: TextStyle(
            color: kColorScheme.onPrimaryContainer,
            fontSize: 17,
          ),
          bodyMedium: const TextStyle(fontSize: 17),
          bodyLarge: const TextStyle(fontSize: 19),
          labelMedium: TextStyle(
            color: kColorScheme.onPrimaryContainer,
            fontSize: 19,
          ),
          displaySmall: TextStyle(
            fontSize: 11,
            color: kColorScheme.onPrimaryContainer,
          ),
          displayMedium: TextStyle(
            fontSize: 16,
            color: kColorScheme.onPrimaryContainer,
          ),
          displayLarge: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            color: kColorScheme.onPrimaryContainer,
          ),
          labelSmall: TextStyle(
            color: kColorScheme.onPrimaryContainer,
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            color: kColorScheme.onPrimaryContainer,
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            backgroundColor: kColorScheme.primaryContainer,
            textStyle: TextStyle(
              fontSize: 17,
              color: kColorScheme.onPrimaryContainer,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 15, color: kColorScheme.primary),
          ),
        ),
      ),
    ),
  );
}
