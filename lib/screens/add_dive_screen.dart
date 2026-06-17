import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'package:drift/drift.dart';
import '../constants/dive_constants.dart';

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
  final _bottomTimeController = TextEditingController();

  final _diveNumberController = TextEditingController();
  final _timeInController = TextEditingController();
  final _timeOutController = TextEditingController();

  final _tankSizeController = TextEditingController();
  final _gasMixController = TextEditingController();
  final _weightUsedController = TextEditingController();

  final _startPressureController = TextEditingController();
  final _endPressureController = TextEditingController();

  final _notesController = TextEditingController();

  String? _selectedTankType;
  String? _selectedActivityType;

  @override
  void dispose() {
    for (final c in [
      _locationController,
      _depthController,
      _bottomTimeController,
      _diveNumberController,
      _timeInController,
      _timeOutController,
      _tankSizeController,
      _gasMixController,
      _weightUsedController,
      _startPressureController,
      _endPressureController,
      _notesController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  // ---- Safe parsing helpers ----
  int? _toInt(String v) => v.isEmpty ? null : int.tryParse(v);
  double? _toDouble(String v) => v.isEmpty ? null : double.tryParse(v);

  // ---- Validators ----
  String? _requiredIntValidator(String? v) {
    if (v == null || v.isEmpty) return "Required";
    if (int.tryParse(v) == null) return "Enter a whole number";
    return null;
  }

  String? _optionalIntValidator(String? v) {
    if (v == null || v.isEmpty) return null;
    if (int.tryParse(v) == null) return "Enter a whole number";
    return null;
  }

  String? _optionalDoubleValidator(String? v) {
    if (v == null || v.isEmpty) return null;
    if (double.tryParse(v) == null) return "Enter a number";
    return null;
  }

  Future<void> _saveDive() async {
    if (!_formKey.currentState!.validate()) return;

    final companion = DivesCompanion.insert(
      date: _date,

      locationName: Value(
        _locationController.text.isEmpty ? null : _locationController.text,
      ),

      diveNumber: Value(_toInt(_diveNumberController.text)),

      maxDepthFt: int.parse(_depthController.text),
      bottomTimeMin: int.parse(_bottomTimeController.text),

      timeIn: Value(
        _timeInController.text.isEmpty ? null : _timeInController.text,
      ),
      timeOut: Value(
        _timeOutController.text.isEmpty ? null : _timeOutController.text,
      ),

      tankType: Value(_selectedTankType),
      tankSize: Value(_toDouble(_tankSizeController.text)),

      gasMix: Value(
        _gasMixController.text.isEmpty ? null : _gasMixController.text,
      ),

      weightUsed: Value(_toDouble(_weightUsedController.text)),

      activityType: Value(_selectedActivityType),

      startPressurePsi: Value(_toInt(_startPressureController.text)),
      endPressurePsi: Value(_toInt(_endPressureController.text)),

      notes: Value(
        _notesController.text.isEmpty ? null : _notesController.text,
      ),
    );

    await db.insertDive(companion);

    if (!mounted) return;
    Navigator.pop(context, true);
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
                controller: _diveNumberController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration: const InputDecoration(labelText: "Dive Number"),
              ),

              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),

              TextFormField(
                controller: _depthController,
                keyboardType: TextInputType.number,
                validator: _requiredIntValidator,
                decoration:
                    const InputDecoration(labelText: "Max Depth (ft)"),
              ),

              TextFormField(
                controller: _bottomTimeController,
                keyboardType: TextInputType.number,
                validator: _requiredIntValidator,
                decoration:
                    const InputDecoration(labelText: "Bottom Time (min)"),
              ),

              TextFormField(
                controller: _timeInController,
                decoration: const InputDecoration(labelText: "Time In"),
              ),

              TextFormField(
                controller: _timeOutController,
                decoration: const InputDecoration(labelText: "Time Out"),
              ),

              DropdownButtonFormField<String>(
                value: _selectedTankType,
                items: DiveConstants.tankTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedTankType = v),
                decoration: const InputDecoration(labelText: "Tank Type"),
              ),

              TextFormField(
                controller: _tankSizeController,
                keyboardType: TextInputType.number,
                validator: _optionalDoubleValidator,
                decoration: const InputDecoration(labelText: "Tank Size"),
              ),

              TextFormField(
                controller: _gasMixController,
                decoration: const InputDecoration(labelText: "Gas Mix"),
              ),

              DropdownButtonFormField<String>(
                value: _selectedActivityType,
                items: DiveConstants.activityTypes
                    .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedActivityType = v),
                decoration:
                    const InputDecoration(labelText: "Activity Type"),
              ),

              TextFormField(
                controller: _weightUsedController,
                keyboardType: TextInputType.number,
                validator: _optionalDoubleValidator,
                decoration: const InputDecoration(labelText: "Weight Used"),
              ),

              TextFormField(
                controller: _startPressureController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration:
                    const InputDecoration(labelText: "Start Pressure"),
              ),

              TextFormField(
                controller: _endPressureController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration: const InputDecoration(labelText: "End Pressure"),
              ),

              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Notes"),
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
