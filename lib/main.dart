import 'package:flutter/material.dart';

void main() {
  runApp(const DiveLogApp());
}

class DiveLogApp extends StatelessWidget {
  const DiveLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dive Log',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dive Log'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddDiveScreen(),
                    ),
                  );
                },
                child: const Text('Add Dive'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DiveListScreen(),
                    ),
                  );
                },
                child: const Text('View Dives'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddDiveScreen extends StatelessWidget {
  const AddDiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Dive')),
      body: const Center(
        child: Text('Add Dive Form Coming Next'),
      ),
    );
  }
}

class DiveListScreen extends StatelessWidget {
  const DiveListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Dives')),
      body: const Center(
        child: Text('Dive List Coming Next'),
      ),
    );
  }
}