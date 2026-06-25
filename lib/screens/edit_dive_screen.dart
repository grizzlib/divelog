import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'package:drift/drift.dart';
import '../constants/dive_constants.dart';

class EditDiveScreen extends StatefulWidget {
  final Dive dive;

  const EditDiveScreen({super.key, required this.dive});

  @override
  State<EditDiveScreen> createState() => _EditDiveScreenState();
}

class _EditDiveScreenState extends State<EditDiveScreen> {
  final _formKey = GlobalKey<FormState>();

  // ---------------------------------------------------------------------------
  // Text field controllers
  //
  // These hold the current values for text fields on the Edit Dive form.
  //
  // Future change point:
  // If a field becomes a dropdown later, remove its controller and replace it
  // with a selected value variable, like tank size, gas mix, and exposure
  // protection.
  // ---------------------------------------------------------------------------

  late TextEditingController _locationController;
  late TextEditingController _depthController;
  late TextEditingController _bottomTimeController;

  late TextEditingController _diveNumberController;
  late TextEditingController _timeInController;
  late TextEditingController _timeOutController;

  late TextEditingController _weightUsedController;

  late TextEditingController _startPressureController;
  late TextEditingController _endPressureController;

  // V3 environmental/conditions fields.
  late TextEditingController _visibilityController;
  late TextEditingController _airTempController;
  late TextEditingController _surfaceTempController;
  late TextEditingController _bottomTempController;

  late TextEditingController _notesController;

  // ---------------------------------------------------------------------------
  // Dropdown state
  //
  // These hold the selected values from dropdown fields.
  // ---------------------------------------------------------------------------

  String? _selectedTankType;
  double? _selectedTankSize;
  String? _selectedGasMix;
  String? _selectedActivityType;
  String? _selectedExposureProtection;

  @override
  void initState() {
    super.initState();

    // -------------------------------------------------------------------------
    // Load existing dive values into controllers
    //
    // When editing, each field starts with the saved value from the selected
    // dive. Null values show as blank fields.
    // -------------------------------------------------------------------------

    _locationController = TextEditingController(
      text: widget.dive.locationName ?? '',
    );

    _depthController = TextEditingController(
      text: widget.dive.maxDepthFt.toString(),
    );

    _bottomTimeController = TextEditingController(
      text: widget.dive.bottomTimeMin.toString(),
    );

    _diveNumberController = TextEditingController(
      text: widget.dive.diveNumber?.toString() ?? '',
    );

    _timeInController = TextEditingController(text: widget.dive.timeIn ?? '');

    _timeOutController = TextEditingController(text: widget.dive.timeOut ?? '');

    _weightUsedController = TextEditingController(
      text: widget.dive.weightUsed?.toString() ?? '',
    );

    _startPressureController = TextEditingController(
      text: widget.dive.startPressurePsi?.toString() ?? '',
    );

    _endPressureController = TextEditingController(
      text: widget.dive.endPressurePsi?.toString() ?? '',
    );

    // V3 fields.
    _visibilityController = TextEditingController(
      text: widget.dive.visibilityFt?.toString() ?? '',
    );

    _airTempController = TextEditingController(
      text: widget.dive.airTempF?.toString() ?? '',
    );

    _surfaceTempController = TextEditingController(
      text: widget.dive.surfaceTempF?.toString() ?? '',
    );

    _bottomTempController = TextEditingController(
      text: widget.dive.bottomTempF?.toString() ?? '',
    );

    _notesController = TextEditingController(text: widget.dive.notes ?? '');

    // -------------------------------------------------------------------------
    // Restore dropdown selections
    //
    // These checks prevent Flutter dropdown errors if an older saved value does
    // not exist in the current constants list.
    //
    // Future change point:
    // If dropdown options are renamed in DiveConstants, these fallback checks
    // help keep old dives editable.
    // -------------------------------------------------------------------------

    _selectedTankType = DiveConstants.tankTypes.contains(widget.dive.tankType)
        ? widget.dive.tankType
        : null;

    _selectedTankSize = DiveConstants.tankSizes.contains(widget.dive.tankSize)
        ? widget.dive.tankSize
        : DiveConstants.defaultTankSize;

    _selectedGasMix = DiveConstants.gasMixes.contains(widget.dive.gasMix)
        ? widget.dive.gasMix
        : DiveConstants.defaultGasMix;

    _selectedActivityType =
        DiveConstants.activityTypes.contains(widget.dive.activityType)
            ? widget.dive.activityType
            : null;

    _selectedExposureProtection = DiveConstants.exposureProtectionTypes
            .contains(widget.dive.exposureProtection)
        ? widget.dive.exposureProtection
        : null;
  }

  @override
  void dispose() {
    // Always dispose controllers to avoid memory leaks.
    for (final c in [
      _locationController,
      _depthController,
      _bottomTimeController,
      _diveNumberController,
      _timeInController,
      _timeOutController,
      _weightUsedController,
      _startPressureController,
      _endPressureController,
      _visibilityController,
      _airTempController,
      _surfaceTempController,
      _bottomTempController,
      _notesController,
    ]) {
      c.dispose();
    }

    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Safe parsing helpers
  //
  // These convert optional text fields into numbers.
  // Empty values are stored as null in the database.
  // ---------------------------------------------------------------------------

  int? _toInt(String v) => v.isEmpty ? null : int.tryParse(v);
  double? _toDouble(String v) => v.isEmpty ? null : double.tryParse(v);

  // ---------------------------------------------------------------------------
  // Validators
  //
  // Required fields must contain valid values.
  // Optional fields can be blank, but must be valid if filled in.
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // Save logic
  //
  // This updates the existing dive row in the database.
  //
  // Future change point:
  // Any new database field added to the Dives table should usually be added
  // here so edited dives can save that field.
  // ---------------------------------------------------------------------------

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
        tankSize: Value(_selectedTankSize),
        gasMix: Value(_selectedGasMix),

        weightUsed: Value(_toDouble(_weightUsedController.text)),
        activityType: Value(_selectedActivityType),

        // V3 fields.
        exposureProtection: Value(_selectedExposureProtection),
        visibilityFt: Value(_toInt(_visibilityController.text)),
        airTempF: Value(_toInt(_airTempController.text)),
        surfaceTempF: Value(_toInt(_surfaceTempController.text)),
        bottomTempF: Value(_toInt(_bottomTempController.text)),

        startPressurePsi: Value(_toInt(_startPressureController.text)),
        endPressurePsi: Value(_toInt(_endPressureController.text)),

        notes: Value(
          _notesController.text.isEmpty ? null : _notesController.text,
        ),
      ),
    );

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  // ---------------------------------------------------------------------------
  // Reusable section label
  //
  // This keeps the long edit form easier to read.
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // Screen layout
  // ---------------------------------------------------------------------------

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
              _sectionLabel("Dive Info"),

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
                decoration: const InputDecoration(labelText: "Max Depth (ft)"),
              ),

              TextFormField(
                controller: _bottomTimeController,
                keyboardType: TextInputType.number,
                validator: _requiredIntValidator,
                decoration: const InputDecoration(
                  labelText: "Bottom Time (min)",
                ),
              ),

              TextFormField(
                controller: _timeInController,
                decoration: const InputDecoration(labelText: "Time In"),
              ),

              TextFormField(
                controller: _timeOutController,
                decoration: const InputDecoration(labelText: "Time Out"),
              ),

              _sectionLabel("Equipment"),

              DropdownButtonFormField<String>(
                value: _selectedTankType,
                items: DiveConstants.tankTypes
                    .map(
                      (t) => DropdownMenuItem<String>(
                        value: t,
                        child: Text(t),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedTankType = v),
                decoration: const InputDecoration(labelText: "Tank Type"),
              ),

              DropdownButtonFormField<double>(
                value: _selectedTankSize,
                items: DiveConstants.tankSizes
                    .map(
                      (s) => DropdownMenuItem<double>(
                        value: s,
                        child: Text(s.toStringAsFixed(0)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedTankSize = v),
                decoration: const InputDecoration(labelText: "Tank Size"),
              ),

              DropdownButtonFormField<String>(
                value: _selectedGasMix,
                items: DiveConstants.gasMixes
                    .map(
                      (g) => DropdownMenuItem<String>(
                        value: g,
                        child: Text(g),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedGasMix = v),
                decoration: const InputDecoration(labelText: "Gas Mix"),
              ),

              DropdownButtonFormField<String>(
                value: _selectedExposureProtection,
                items: DiveConstants.exposureProtectionTypes
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  setState(() => _selectedExposureProtection = v);
                },
                decoration: const InputDecoration(
                  labelText: "Exposure Protection",
                ),
              ),

              TextFormField(
                controller: _weightUsedController,
                keyboardType: TextInputType.number,
                validator: _optionalDoubleValidator,
                decoration: const InputDecoration(labelText: "Weight Used"),
              ),

              _sectionLabel("Dive Conditions"),

              DropdownButtonFormField<String>(
                value: _selectedActivityType,
                items: DiveConstants.activityTypes
                    .map(
                      (a) => DropdownMenuItem<String>(
                        value: a,
                        child: Text(a),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedActivityType = v),
                decoration: const InputDecoration(labelText: "Activity Type"),
              ),

              TextFormField(
                controller: _visibilityController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration: const InputDecoration(
                  labelText: "Visibility (ft)",
                ),
              ),

              TextFormField(
                controller: _airTempController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration: const InputDecoration(
                  labelText: "Air Temperature (°F)",
                ),
              ),

              TextFormField(
                controller: _surfaceTempController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration: const InputDecoration(
                  labelText: "Surface Temperature (°F)",
                ),
              ),

              TextFormField(
                controller: _bottomTempController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration: const InputDecoration(
                  labelText: "Bottom Temperature (°F)",
                ),
              ),

              _sectionLabel("Pressure"),

              TextFormField(
                controller: _startPressureController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration: const InputDecoration(labelText: "Start Pressure"),
              ),

              TextFormField(
                controller: _endPressureController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration: const InputDecoration(labelText: "End Pressure"),
              ),

              _sectionLabel("Notes"),

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