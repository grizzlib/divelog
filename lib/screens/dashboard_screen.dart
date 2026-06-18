import 'package:flutter/material.dart';
import '../db/app_database.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Dive> dives = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    final results = await db.getAllDives();

    if (!mounted) return;

    setState(() {
      dives = results;
      isLoading = false;
    });
  }

  int get totalDives => dives.length;

  int get totalBottomTime =>
      dives.fold(0, (sum, dive) => sum + dive.bottomTimeMin);

  int get deepestDive {
    if (dives.isEmpty) return 0;
    return dives
        .map((dive) => dive.maxDepthFt)
        .reduce((a, b) => a > b ? a : b);
  }

  double get averageDepth {
    if (dives.isEmpty) return 0;
    final totalDepth =
        dives.fold(0, (sum, dive) => sum + dive.maxDepthFt);
    return totalDepth / dives.length;
  }

  double get averageBottomTime {
    if (dives.isEmpty) return 0;
    return totalBottomTime / dives.length;
  }

  Widget statCard(String label, String value) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dive Dashboard"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  statCard("Total Dives", totalDives.toString()),
                  statCard("Total Bottom Time", "$totalBottomTime min"),
                  statCard("Deepest Dive", "$deepestDive ft"),
                  statCard(
                    "Average Depth",
                    "${averageDepth.toStringAsFixed(1)} ft",
                  ),
                  statCard(
                    "Average Bottom Time",
                    "${averageBottomTime.toStringAsFixed(1)} min",
                  ),
                ],
              ),
            ),
    );
  }
}