import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'edit_dive_screen.dart';

class DiveDetailScreen extends StatelessWidget {
  final Dive dive;

  const DiveDetailScreen({
    super.key,
    required this.dive,
  });

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

              // if edited, refresh this screen
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
                  Navigator.pop(context, true); // notify list to refresh
                }
              }
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ${dive.date}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            Text(
              "Location: ${dive.locationName ?? 'N/A'}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            Text(
              "Max Depth: ${dive.maxDepthFt} ft",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            Text(
              "Bottom Time: ${dive.bottomTimeMin} min",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            Text(
              "Start Pressure: ${dive.startPressurePsi ?? '-'} psi",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            Text(
              "End Pressure: ${dive.endPressurePsi ?? '-'} psi",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            Text(
              "Notes: ${dive.notes ?? ''}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}