import 'package:flutter/material.dart';

import 'screens/dashboard_screen.dart';

/// App entry point.
///
/// Flutter starts here and loads the root widget for the Dive Log app.
void main() {
  runApp(const MyApp());
}

/// Root app widget.
///
/// This sets up the MaterialApp and tells Flutter which screen should load
/// first when the app opens.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dive Log',

      // Basic app theme.
      // Future change point:
      // We can customize colors, dark mode, typography, etc. here later.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),

      // First screen shown when the app opens.
      // Future change point:
      // Dashboard navigation and dashboard sections should live inside
      // dashboard_screen.dart so main.dart stays focused on app setup.
      home: const DashboardScreen(),
    );
  }
}
