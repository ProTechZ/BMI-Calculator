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
  secondary: Color.fromARGB(255, 255, 235, 13),
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
          titleTextStyle: GoogleFonts.montserrat(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: kColorScheme.onPrimary),
          backgroundColor: kColorScheme.primary,
          iconTheme: const IconThemeData().copyWith(
            color: kColorScheme.onPrimary,
            size: 35,
          ),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondary,
        ),
        textTheme: GoogleFonts.montserratTextTheme().copyWith(),
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
