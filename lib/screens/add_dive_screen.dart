import 'package:flutter/material.dart';
import '../models/dive.dart';
import '../db/app_database.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class AddDiveScreen extends StatefulWidget {
  const AddDiveScreen({super.key});

  @override
  State<AddDiveScreen> createState() => _AddDiveScreenState();
}

class _AddDiveScreenState extends State<AddDiveScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  final _locationController = TextEditingController();
  final _depthController = TextEditingController();
  final _timeController = TextEditingController();
  final _startPressureController = TextEditingController();
  final _endPressureController = TextEditingController();
  final _notesController = TextEditingController();

 void _saveDive() async {
  if (!_formKey.currentState!.validate()) return;

  final id = const Uuid().v4();

  final companion = DivesCompanion.insert(
    id: id,
    date: _date,
    locationName: Value(_locationController.text.isEmpty
        ? null
        : _locationController.text),
    maxDepthFt: int.parse(_depthController.text),
    bottomTimeMin: int.parse(_timeController.text),
    startPressurePsi: Value(_startPressureController.text.isEmpty
        ? null
        : int.parse(_startPressureController.text)),
    endPressurePsi: Value(_endPressureController.text.isEmpty
        ? null
        : int.parse(_endPressureController.text)),
    notes: Value(_notesController.text.isEmpty
        ? null
        : _notesController.text),
  );

  await db.insertDive(companion);

  if (!mounted) return;
  Navigator.pop(context);
}

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Dive")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListTile(
                title: Text("Date: ${_date.toLocal()}".split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),

              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),

              TextFormField(
                controller: _depthController,
                decoration: const InputDecoration(labelText: "Max Depth (ft)"),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? "Required" : null,
              ),

              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: "Bottom Time (min)"),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? "Required" : null,
              ),

              TextFormField(
                controller: _startPressureController,
                decoration: const InputDecoration(labelText: "Start Pressure (psi)"),
                keyboardType: TextInputType.number,
              ),

              TextFormField(
                controller: _endPressureController,
                decoration: const InputDecoration(labelText: "End Pressure (psi)"),
                keyboardType: TextInputType.number,
              ),

              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: "Notes"),
                maxLines: 3,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveDive,
                child: const Text("Save Dive"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}