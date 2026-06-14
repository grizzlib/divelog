import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'package:drift/drift.dart' as drift;

class EditDiveScreen extends StatefulWidget {
  final Dive dive;

  const EditDiveScreen({
    super.key,
    required this.dive,
  });

  @override
  State<EditDiveScreen> createState() => _EditDiveScreenState();
}

class _EditDiveScreenState extends State<EditDiveScreen> {
  late TextEditingController locationController;
  late TextEditingController depthController;
  late TextEditingController bottomTimeController;
  late TextEditingController startPressureController;
  late TextEditingController endPressureController;
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();

    locationController =
        TextEditingController(text: widget.dive.locationName ?? '');

    depthController =
        TextEditingController(text: widget.dive.maxDepthFt.toString());

    bottomTimeController =
        TextEditingController(text: widget.dive.bottomTimeMin.toString());

    startPressureController =
        TextEditingController(text: widget.dive.startPressurePsi?.toString() ?? '');

    endPressureController =
        TextEditingController(text: widget.dive.endPressurePsi?.toString() ?? '');

    notesController =
        TextEditingController(text: widget.dive.notes ?? '');
  }

  Future<void> saveChanges() async {
    await db.update(db.dives).replace(
      DivesCompanion(
        id: drift.Value(widget.dive.id),
        date: drift.Value(widget.dive.date),
        locationName: drift.Value(locationController.text),
        maxDepthFt: drift.Value(int.parse(depthController.text)),
        bottomTimeMin: drift.Value(int.parse(bottomTimeController.text)),
        startPressurePsi: drift.Value(
          int.tryParse(startPressureController.text),
        ),
        endPressurePsi: drift.Value(
          int.tryParse(endPressureController.text),
        ),
        notes: drift.Value(notesController.text),
      ),
    );

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Dive"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Location",
              ),
            ),

            TextField(
              controller: depthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Max Depth",
              ),
            ),

            TextField(
              controller: bottomTimeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Bottom Time",
              ),
            ),

            TextField(
              controller: startPressureController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Start Pressure",
              ),
            ),

            TextField(
              controller: endPressureController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "End Pressure",
              ),
            ),

            TextField(
              controller: notesController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Notes",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveChanges,
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}