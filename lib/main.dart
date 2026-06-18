import 'package:flutter/material.dart';

import 'screens/add_dive_screen.dart';
import 'screens/dive_list_screen.dart';
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
      home: const HomePage(),
    );
  }
}

/// Main menu screen.
///
/// This is the central navigation screen for the app.
/// From here the user can:
/// - Add a new dive
/// - View the dive list
/// - Open the Phase 2 dashboard
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dive Log'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Opens the Add Dive screen.
              ElevatedButton(
                child: const Text('Add Dive'),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddDiveScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// Opens the list of saved dives.
              ElevatedButton(
                child: const Text('View Dives'),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DiveListScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// Opens the Phase 2 Dashboard screen.
              ///
              /// Future change point:
              /// If we add more dashboard sections later, they should be added
              /// inside dashboard_screen.dart, not here.
              ElevatedButton(
                child: const Text('Dashboard'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}