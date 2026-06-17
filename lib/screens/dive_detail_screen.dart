import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'edit_dive_screen.dart';

class DiveDetailScreen extends StatelessWidget {
  final Dive dive;

  const DiveDetailScreen({
    super.key,
    required this.dive,
  });

  String _formatDate(DateTime d) => "${d.month}/${d.day}/${d.year}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dive Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditDiveScreen(dive: dive),
                ),
              );

              if (result == true && context.mounted) {
                Navigator.pop(context, true);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Dive?"),
                  content: const Text("This cannot be undone."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await db.deleteDive(dive.id);
                if (context.mounted) {
                  Navigator.pop(context, true);
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Date: ${_formatDate(dive.date)}"),

            const SizedBox(height: 10),
            Text("Dive #: ${dive.diveNumber ?? '-'}"),
            Text("Location: ${dive.locationName ?? '-'}"),

            const SizedBox(height: 10),
            Text("Max Depth: ${dive.maxDepthFt} ft"),
            Text("Bottom Time: ${dive.bottomTimeMin} min"),

            const SizedBox(height: 10),
            Text("Time In: ${dive.timeIn ?? '-'}"),
            Text("Time Out: ${dive.timeOut ?? '-'}"),

            const SizedBox(height: 10),
            Text("Tank Type: ${dive.tankType ?? '-'}"),
            Text("Tank Size: ${dive.tankSize ?? '-'}"),
            Text("Gas Mix: ${dive.gasMix ?? '-'}"),

            const SizedBox(height: 10),
            Text("Weight Used: ${dive.weightUsed ?? '-'}"),
            Text("Activity: ${dive.activityType ?? '-'}"),

            const SizedBox(height: 10),
            Text("Start Pressure: ${dive.startPressurePsi ?? '-'}"),
            Text("End Pressure: ${dive.endPressurePsi ?? '-'}"),

            const SizedBox(height: 10),
            Text("Notes: ${dive.notes ?? ''}"),
          ],
        ),
      ),
    );
  }
}
