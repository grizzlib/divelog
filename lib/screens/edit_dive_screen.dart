import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'package:drift/drift.dart';
import '../constants/dive_constants.dart';

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
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _locationController;
  late TextEditingController _depthController;
  late TextEditingController _bottomTimeController;

  late TextEditingController _diveNumberController;
  late TextEditingController _timeInController;
  late TextEditingController _timeOutController;

  late TextEditingController _tankSizeController;
  late TextEditingController _gasMixController;
  late TextEditingController _weightUsedController;

  late TextEditingController _startPressureController;
  late TextEditingController _endPressureController;
  late TextEditingController _notesController;

  String? _selectedTankType;
  String? _selectedActivityType;

  @override
  void initState() {
    super.initState();

    _locationController =
        TextEditingController(text: widget.dive.locationName ?? '');

    _depthController =
        TextEditingController(text: widget.dive.maxDepthFt.toString());

    _bottomTimeController =
        TextEditingController(text: widget.dive.bottomTimeMin.toString());

    _diveNumberController =
        TextEditingController(text: widget.dive.diveNumber?.toString() ?? '');

    _timeInController =
        TextEditingController(text: widget.dive.timeIn ?? '');

    _timeOutController =
        TextEditingController(text: widget.dive.timeOut ?? '');

    _tankSizeController = TextEditingController(
      text: widget.dive.tankSize?.toString() ?? '',
    );

    _gasMixController =
        TextEditingController(text: widget.dive.gasMix ?? '');

    _weightUsedController = TextEditingController(
      text: widget.dive.weightUsed?.toString() ?? '',
    );

    _startPressureController = TextEditingController(
      text: widget.dive.startPressurePsi?.toString() ?? '',
    );

    _endPressureController = TextEditingController(
      text: widget.dive.endPressurePsi?.toString() ?? '',
    );

    _notesController = TextEditingController(text: widget.dive.notes ?? '');

    // Restore dropdown selections. If the stored value no longer exists in
    // the current option list, fall back to null so the dropdown doesn't
    // throw an assertion error.
    _selectedTankType = DiveConstants.tankTypes.contains(widget.dive.tankType)
        ? widget.dive.tankType
        : null;

    _selectedActivityType =
        DiveConstants.activityTypes.contains(widget.dive.activityType)
            ? widget.dive.activityType
            : null;
  }

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

  Future<void> saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    await db.updateDive(
      DivesCompanion(
        id: Value(widget.dive.id),
        date: Value(widget.dive.date),

        diveNumber: Value(_toInt(_diveNumberController.text)),

        locationName: Value(
          _locationController.text.isEmpty ? null : _locationController.text,
        ),

        maxDepthFt: Value(int.parse(_depthController.text)),
        bottomTimeMin: Value(int.parse(_bottomTimeController.text)),

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
      ),
    );

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Dive")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                maxLines: 4,
                decoration: const InputDecoration(labelText: "Notes"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: saveChanges,
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
