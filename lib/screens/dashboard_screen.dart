import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'add_dive_screen.dart';
import 'dive_list_screen.dart';

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
/// - Recent dives
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

    return dives.map((dive) => dive.maxDepthFt).reduce((a, b) => a > b ? a : b);
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

  /// Newest dives shown on the home dashboard.
  ///
  /// Future change point:
  /// If the dashboard later supports filters or profiles, apply those before
  /// taking the first few recent dives.
  List<Dive> get recentDives {
    final sorted = [...dives]..sort(_compareRecentDives);
    return sorted.take(5).toList();
  }

  /// Sorts recent dives newest first.
  ///
  /// The database stores timeIn as free text, so this parser supports simple
  /// common formats and falls back to date-only sorting when no usable time is
  /// available.
  int _compareRecentDives(Dive a, Dive b) {
    final dateCompare = _recentSortDateTime(
      b,
    ).compareTo(_recentSortDateTime(a));
    if (dateCompare != 0) return dateCompare;

    return (b.diveNumber ?? -1).compareTo(a.diveNumber ?? -1);
  }

  /// Builds a sortable DateTime from the dive date and optional timeIn text.
  DateTime _recentSortDateTime(Dive dive) {
    final time = _parseTimeIn(dive.timeIn);

    return DateTime(
      dive.date.year,
      dive.date.month,
      dive.date.day,
      time?.hour ?? 0,
      time?.minute ?? 0,
    );
  }

  /// Parses common timeIn values like "9:30", "09:30", "9:30 AM", or "2 PM".
  ///
  /// Future change point:
  /// If time entry becomes structured instead of free text, this helper can be
  /// replaced with direct sorting on the saved time value.
  TimeOfDay? _parseTimeIn(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final match = RegExp(
      r'^(\d{1,2})(?::(\d{2}))?\s*([ap]m)?$',
      caseSensitive: false,
    ).firstMatch(value.trim());

    if (match == null) return null;

    var hour = int.tryParse(match.group(1)!);
    final minute = int.tryParse(match.group(2) ?? '0');
    final period = match.group(3)?.toLowerCase();

    if (hour == null || minute == null || minute > 59) return null;
    if (period == null && hour > 23) return null;
    if (period != null && (hour < 1 || hour > 12)) return null;

    if (period == 'pm' && hour != 12) hour += 12;
    if (period == 'am' && hour == 12) hour = 0;

    return TimeOfDay(hour: hour, minute: minute);
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
  // Navigation actions
  // ---------------------------------------------------------------------------

  /// Opens the Add Dive screen and refreshes stats if a dive was saved.
  Future<void> openAddDive() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddDiveScreen()),
    );

    if (result == true) {
      await loadDashboard();
    }
  }

  /// Opens the full dive list.
  ///
  /// The dashboard refreshes when the user returns, because edits or deletes can
  /// happen from the list/detail flow.
  Future<void> openDiveList() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DiveListScreen()),
    );

    await loadDashboard();
  }

  // ---------------------------------------------------------------------------
  // Reusable dashboard widgets
  // ---------------------------------------------------------------------------

  /// Basic statistic card used for simple dashboard numbers.
  ///
  /// Future change point:
  /// If we want icons, colors, larger cards, or a grid layout later, this is
  /// the main widget to update.
  Widget statCard({required String label, required String value}) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Main dashboard navigation.
  ///
  /// Future change point:
  /// Add filters, export actions, or profile switching near these buttons if
  /// the dashboard grows.
  Widget dashboardActions() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: openAddDive,
            child: const Text("Add Dive"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: openDiveList,
            child: const Text("View Dives"),
          ),
        ),
      ],
    );
  }

  /// Recent dive list for the home dashboard.
  ///
  /// Future change point:
  /// This section is the natural place to add tap-to-open details, filters, or
  /// richer summary fields later.
  Widget recentDivesSection() {
    if (recentDives.isEmpty) {
      return const Card(
        child: ListTile(
          title: Text("Recent Dives"),
          subtitle: Text("No dives logged yet"),
        ),
      );
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              "Recent Dives",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          for (final dive in recentDives)
            ListTile(
              title: Text(
                dive.diveNumber == null
                    ? displayText(dive.locationName)
                    : "Dive #${dive.diveNumber} - ${displayText(dive.locationName)}",
              ),
              subtitle: Text(
                "${formatDate(dive.date)} | ${dive.maxDepthFt} ft | ${dive.bottomTimeMin} min",
              ),
            ),
        ],
      ),
    );
  }

  /// Main dashboard content.
  Widget dashboardContent() {
    return RefreshIndicator(
      onRefresh: loadDashboard,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          dashboardActions(),
          const SizedBox(height: 12),
          statCard(label: "Total Dives", value: totalDives.toString()),
          statCard(
            label: "Total Bottom Time",
            value: formatBottomTime(totalBottomTime),
          ),
          statCard(label: "Deepest Dive", value: "$deepestDive ft"),
          statCard(
            label: "Average Depth",
            value: "${averageDepth.toStringAsFixed(1)} ft",
          ),
          statCard(
            label: "Average Bottom Time",
            value: "${averageBottomTime.toStringAsFixed(1)} min",
          ),

          const SizedBox(height: 12),

          recentDivesSection(),
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
      appBar: AppBar(title: const Text("Dive Log")),
      body: SafeArea(
        top: false,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : dashboardContent(),
      ),
    );
  }
}
