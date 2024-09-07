import 'package:flutter/material.dart';
import 'package:persist_data_example_sqlite/core/theme_extensions.dart';
import 'package:persist_data_example_sqlite/data/datasources/datasource.dart';

import 'package:persist_data_example_sqlite/presentation/pages/homepage.dart'; // Importing the homepage widget.

void main() async {
  // This function runs before the app starts, to ensure Flutter is fully initialized.
  WidgetsFlutterBinding
      .ensureInitialized(); // For async operations before runApp(MyApp()) -  Flutter needs to ensure that all its internal systems (e.g., rendering, services) are initialized properly.

  // Initialize the database by calling the get database function.
  final db = await Datasource().database;

  // Run the application by creating an instance of MyApp widget.
  runApp(MyApp());
}

// Main application widget, extends StatefulWidget because the theme changes dynamically.
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

// State class that maintains the current state of MyApp
class _MyAppState extends State<MyApp> {
  // Variable to store the current theme mode (light or dark).
  ThemeMode _themeMode = ThemeMode.dark;

  // This method is called whenever the UI needs to be updated.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Main entry point for the Flutter application.
      title: 'Blog Manager', // Title of the app.

      // Define the themes for light and dark modes.
      theme:
          lightTheme, // Light mode theme defined in core/theme_extensions.dart.
      darkTheme:
          darkTheme, // Dark mode theme defined in core/theme_extensions.dart.

      // Control which theme to use based on _themeMode.
      themeMode:
          _themeMode, // Dynamic theme mode changes between light and dark modes.

      // The main home page of the application, passing down parameters.
      home: MyHomePage(
        title: 'Manage Blogs', // Title of the home page.

        // Callback function that updates the theme mode when toggled.
        onThemeChanged: (bool isDarkMode) {
          // Update the theme when dark mode is enabled or disabled.
          setState(() {
            _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
          });
        },

        // Pass the current theme mode as a boolean to the home page.
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}
