import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'edit_dive_screen.dart';

class DiveDetailScreen extends StatelessWidget {
  final Dive dive;

  const DiveDetailScreen({
    super.key,
    required this.dive,
  });

  // ---------------------------------------------------------------------------
  // Formatting helpers
  //
  // These keep the display code below cleaner and make it easier to change
  // formatting later.
  // ---------------------------------------------------------------------------

  /// Formats the saved dive date as M/D/YYYY.
  String _formatDate(DateTime d) => "${d.month}/${d.day}/${d.year}";

  /// Displays text values safely.
  ///
  /// Null or blank values show as "-".
  String _displayText(String? value) {
    if (value == null || value.isEmpty) return "-";
    return value;
  }

  /// Displays optional integer values with an optional unit.
  ///
  /// Example:
  /// - null becomes "-"
  /// - 50 with "ft" becomes "50 ft"
  String _displayInt(int? value, {String unit = ""}) {
    if (value == null) return "-";
    return unit.isEmpty ? value.toString() : "$value $unit";
  }

  /// Displays optional double values with an optional unit.
  ///
  /// This is useful for tank size and weight because those are stored as
  /// real numbers in the database for future calculations.
  String _displayDouble(double? value, {String unit = ""}) {
    if (value == null) return "-";

    final formatted = value % 1 == 0
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);

    return unit.isEmpty ? formatted : "$formatted $unit";
  }

  // ---------------------------------------------------------------------------
  // Reusable detail widgets
  //
  // Future change point:
  // If we want a more polished detail screen later, these two widgets are good
  // places to start.
  // ---------------------------------------------------------------------------

  /// Section heading used to group related dive details.
  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Single detail row.
  ///
  /// Example:
  /// "Max Depth: 60 ft"
  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text("$label: $value"),
    );
  }

  // ---------------------------------------------------------------------------
  // Delete confirmation
  //
  // This prevents accidental deletion of a saved dive.
  // ---------------------------------------------------------------------------

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Dive?"),
        content: const Text(
          "Are you sure you want to delete this dive? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// Deletes the current dive if the user confirms.
  Future<void> _deleteDive(BuildContext context) async {
    final confirm = await _confirmDelete(context);

    if (!confirm) return;

    await db.deleteDive(dive.id);

    if (!context.mounted) return;

    // Return true so the previous screen knows to refresh its list.
    Navigator.pop(context, true);
  }

  /// Opens the edit screen.
  ///
  /// If the edit screen saves changes, this screen pops back to the list so the
  /// list/detail flow can reload the updated dive.
  Future<void> _editDive(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditDiveScreen(dive: dive),
      ),
    );

    if (result == true && context.mounted) {
      Navigator.pop(context, true);
    }
  }

  // ---------------------------------------------------------------------------
  // Screen layout
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dive Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editDive(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteDive(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _sectionLabel("Dive Info"),
            _detailRow("Date", _formatDate(dive.date)),
            _detailRow("Dive #", _displayInt(dive.diveNumber)),
            _detailRow("Location", _displayText(dive.locationName)),
            _detailRow("Max Depth", "${dive.maxDepthFt} ft"),
            _detailRow("Bottom Time", "${dive.bottomTimeMin} min"),
            _detailRow("Time In", _displayText(dive.timeIn)),
            _detailRow("Time Out", _displayText(dive.timeOut)),

            _sectionLabel("Equipment"),
            _detailRow("Tank Type", _displayText(dive.tankType)),
            _detailRow("Tank Size", _displayDouble(dive.tankSize)),
            _detailRow("Gas Mix", _displayText(dive.gasMix)),
            _detailRow(
              "Exposure Protection",
              _displayText(dive.exposureProtection),
            ),
            _detailRow("Weight Used", _displayDouble(dive.weightUsed, unit: "lb")),

            _sectionLabel("Dive Conditions"),
            _detailRow("Activity", _displayText(dive.activityType)),
            _detailRow("Visibility", _displayInt(dive.visibilityFt, unit: "ft")),
            _detailRow("Air Temperature", _displayInt(dive.airTempF, unit: "°F")),
            _detailRow(
              "Surface Temperature",
              _displayInt(dive.surfaceTempF, unit: "°F"),
            ),
            _detailRow(
              "Bottom Temperature",
              _displayInt(dive.bottomTempF, unit: "°F"),
            ),

            _sectionLabel("Pressure"),
            _detailRow(
              "Start Pressure",
              _displayInt(dive.startPressurePsi, unit: "psi"),
            ),
            _detailRow(
              "End Pressure",
              _displayInt(dive.endPressurePsi, unit: "psi"),
            ),

            _sectionLabel("Notes"),
            Text(_displayText(dive.notes)),
          ],
        ),
      ),
    );
  }
}