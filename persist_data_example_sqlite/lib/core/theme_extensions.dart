import 'package:flutter/material.dart';
import 'package:persist_data_example_sqlite/data/datasources/datasource.dart';
import 'package:persist_data_example_sqlite/presentation/pages/homepage.dart';

// Spotify Color Palette
const spotifyGreen = Color(0xFF1DB954);
const spotifyBlack = Color(0xFF191414);
const spotifyWhite = Color(0xFFFFFFFF);
const spotifyGray = Color(0xFFB3B3B3);
const spotifyPurple = Color(0xFFA29BFE);

// Light Theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light, // Light theme
  useMaterial3: true,

  // Color Scheme for Light Theme
  colorScheme: ColorScheme.fromSeed(
    seedColor: spotifyGreen,
    brightness: Brightness.light,
    primary: spotifyGreen,
    secondary: spotifyPurple,
    background: spotifyWhite,
    surface: spotifyWhite,
    onPrimary: spotifyWhite,
    onSecondary: spotifyBlack,
    onBackground: spotifyBlack,
    onSurface: spotifyBlack,
    error: Colors.redAccent,
    onError: spotifyWhite,
  ),

  // AppBar Style
  appBarTheme: const AppBarTheme(
    backgroundColor: spotifyGreen,
    foregroundColor: spotifyWhite, // White text/icon color for AppBar
    iconTheme: IconThemeData(color: spotifyWhite),
  ),

  // Text Theme for Light Mode
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: spotifyBlack),
    bodyLarge: TextStyle(fontSize: 18, color: spotifyGray),
    bodyMedium: TextStyle(fontSize: 16, color: spotifyBlack),
    labelLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: spotifyGreen),
    headlineSmall: TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: spotifyBlack),
  ),

  // Elevated Button Style for Light Mode
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: spotifyGreen, // Button background color
      foregroundColor: spotifyWhite, // Button text color
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // Input Decoration Theme for Text Fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: spotifyWhite,
    focusColor: spotifyGreen,
    border: const OutlineInputBorder(),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: spotifyGray),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: spotifyGreen),
    ),
    labelStyle: const TextStyle(color: spotifyGray),
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark, // Dark theme
  useMaterial3: true,

  // Color Scheme for Dark Theme
  colorScheme: ColorScheme.fromSeed(
    seedColor: spotifyGreen,
    brightness: Brightness.dark,
    primary: spotifyGreen,
    secondary: spotifyPurple,
    background: spotifyBlack,
    surface: spotifyBlack,
    onPrimary: spotifyWhite,
    onSecondary: spotifyBlack,
    onBackground: spotifyWhite,
    onSurface: spotifyWhite,
    error: Colors.redAccent,
    onError: spotifyWhite,
  ),

  // AppBar Style
  appBarTheme: const AppBarTheme(
    backgroundColor: spotifyBlack,
    foregroundColor: spotifyWhite, // White text/icon color for AppBar
    iconTheme: IconThemeData(color: spotifyWhite),
  ),

  // Text Theme for Dark Mode
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: spotifyWhite),
    bodyLarge: TextStyle(fontSize: 18, color: spotifyGray),
    bodyMedium: TextStyle(fontSize: 16, color: spotifyWhite),
    labelLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: spotifyGreen),
    headlineSmall: TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: spotifyWhite),
  ),

  // Elevated Button Style for Dark Mode
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: spotifyGreen, // Button background color
      foregroundColor: spotifyWhite, // Button text color
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // Input Decoration Theme for Text Fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: spotifyBlack,
    focusColor: spotifyGreen,
    border: const OutlineInputBorder(),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: spotifyGray),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: spotifyGreen),
    ),
    labelStyle: const TextStyle(color: spotifyGray),
  ),
);
