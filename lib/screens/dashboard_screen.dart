import 'package:flutter/material.dart';
import '../db/app_database.dart';

/// Dashboard screen for Phase 2.
///
/// This screen shows quick summary statistics about the logged dives.
///
/// Current dashboard stats:
/// - Total dives
/// - Total bottom time
/// - Deepest dive
/// - Average depth
/// - Average bottom time
/// - Most recent dive
///
/// Future change points:
/// - Add SAC/RMV summaries here later.
/// - Add weighting/buoyancy trends here later.
/// - Add charts here later.
/// - Move calculations into database queries later if the dive list gets large.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  /// List of dives loaded from the local database.
  List<Dive> dives = [];

  /// Tracks whether we are still waiting for the database query to finish.
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Load the dashboard data when the screen first opens.
    loadDashboard();
  }

  /// Loads all dives from the database and refreshes the dashboard.
  ///
  /// Future change point:
  /// If we later add filters, date ranges, or user profiles, this method is
  /// likely where those database queries would start.
  Future<void> loadDashboard() async {
    final results = await db.getAllDives();

    if (!mounted) return;

    setState(() {
      dives = results;
      isLoading = false;
    });
  }

  // ---------------------------------------------------------------------------
  // Dashboard calculations
  // ---------------------------------------------------------------------------

  /// Total number of dives currently stored.
  int get totalDives => dives.length;

  /// Adds up bottom time from every dive.
  int get totalBottomTime {
    return dives.fold(0, (sum, dive) => sum + dive.bottomTimeMin);
  }

  /// Finds the deepest logged max depth.
  ///
  /// Returns 0 when there are no dives yet so the dashboard stays safe.
  int get deepestDive {
    if (dives.isEmpty) return 0;

    return dives
        .map((dive) => dive.maxDepthFt)
        .reduce((a, b) => a > b ? a : b);
  }

  /// Calculates the average max depth across all dives.
  ///
  /// Returns 0 when there are no dives yet to avoid dividing by zero.
  double get averageDepth {
    if (dives.isEmpty) return 0;

    final totalDepth = dives.fold(0, (sum, dive) => sum + dive.maxDepthFt);
    return totalDepth / dives.length;
  }

  /// Calculates the average bottom time across all dives.
  ///
  /// Returns 0 when there are no dives yet to avoid dividing by zero.
  double get averageBottomTime {
    if (dives.isEmpty) return 0;

    return totalBottomTime / dives.length;
  }

  /// Finds the most recent dive by date.
  ///
  /// Returns null when no dives exist.
  ///
  /// Future change point:
  /// If we add time-of-day sorting later, this can be updated to compare both
  /// date and timeIn.
  Dive? get mostRecentDive {
    if (dives.isEmpty) return null;

    return dives.reduce(
      (currentLatest, nextDive) =>
          nextDive.date.isAfter(currentLatest.date) ? nextDive : currentLatest,
    );
  }

  // ---------------------------------------------------------------------------
  // Formatting helpers
  // ---------------------------------------------------------------------------

  /// Formats a date as M/D/YYYY.
  ///
  /// Future change point:
  /// If we add app-wide date formatting, this helper could move into a shared
  /// utility file.
  String formatDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  /// Formats total bottom time as hours and minutes.
  ///
  /// Examples:
  /// - 35 becomes "35 min"
  /// - 70 becomes "1 hr 10 min"
  /// - 125 becomes "2 hr 5 min"
  String formatBottomTime(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours == 0) {
      return "$remainingMinutes min";
    }

    if (remainingMinutes == 0) {
      return "$hours hr";
    }

    return "$hours hr $remainingMinutes min";
  }

  /// Shows a dash for optional text fields when they are empty.
  String displayText(String? value) {
    if (value == null || value.isEmpty) return "-";
    return value;
  }

  // ---------------------------------------------------------------------------
  // Reusable dashboard widgets
  // ---------------------------------------------------------------------------

  /// Basic statistic card used for simple dashboard numbers.
  ///
  /// Future change point:
  /// If we want icons, colors, larger cards, or a grid layout later, this is
  /// the main widget to update.
  Widget statCard({
    required String label,
    required String value,
  }) {
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

  /// Card showing the most recent dive.
  ///
  /// This gives the dashboard a little more useful context than numbers alone.
  Widget mostRecentDiveCard(Dive dive) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Most Recent Dive",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text("Date: ${formatDate(dive.date)}"),
            Text("Location: ${displayText(dive.locationName)}"),
            Text("Max Depth: ${dive.maxDepthFt} ft"),
            Text("Bottom Time: ${dive.bottomTimeMin} min"),
          ],
        ),
      ),
    );
  }

  /// Empty dashboard message shown when no dives exist.
  ///
  /// This avoids showing a dashboard full of zeros when the database is empty.
  Widget emptyDashboard() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.scuba_diving,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              "No dives logged yet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Add your first dive, then come back here to see your dashboard stats.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Main dashboard content shown when at least one dive exists.
  Widget populatedDashboard() {
    final latestDive = mostRecentDive;

    return RefreshIndicator(
      onRefresh: loadDashboard,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          statCard(
            label: "Total Dives",
            value: totalDives.toString(),
          ),
          statCard(
            label: "Total Bottom Time",
            value: formatBottomTime(totalBottomTime),
          ),
          statCard(
            label: "Deepest Dive",
            value: "$deepestDive ft",
          ),
          statCard(
            label: "Average Depth",
            value: "${averageDepth.toStringAsFixed(1)} ft",
          ),
          statCard(
            label: "Average Bottom Time",
            value: "${averageBottomTime.toStringAsFixed(1)} min",
          ),

          const SizedBox(height: 12),

          if (latestDive != null) mostRecentDiveCard(latestDive),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Screen layout
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dive Dashboard"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : dives.isEmpty
              ? emptyDashboard()
              : populatedDashboard(),
    );
  }
}