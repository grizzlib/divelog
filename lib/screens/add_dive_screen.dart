import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'package:drift/drift.dart';
import '../constants/dive_constants.dart';
import '../widgets/section_label.dart';

class AddDiveScreen extends StatefulWidget {
  const AddDiveScreen({super.key});

  @override
  State<AddDiveScreen> createState() => _AddDiveScreenState();
}

class _AddDiveScreenState extends State<AddDiveScreen> {
  final _formKey = GlobalKey<FormState>();

  // ---------------------------------------------------------------------------
  // Date state
  // ---------------------------------------------------------------------------

  DateTime _date = _dateOnly(DateTime.now());

  // ---------------------------------------------------------------------------
  // Text field controllers
  //
  // These hold the values entered into text fields.
  //
  // Future change point:
  // If a field becomes a dropdown, remove its controller and replace it with a
  // selected value variable, like we did for tank size and gas mix.
  // ---------------------------------------------------------------------------

  final _locationController = TextEditingController();
  final _depthController = TextEditingController();
  final _bottomTimeController = TextEditingController();

  final _diveNumberController = TextEditingController();
  final _timeInController = TextEditingController();
  final _timeOutController = TextEditingController();

  final _weightUsedController = TextEditingController();

  final _startPressureController = TextEditingController();
  final _endPressureController = TextEditingController();

  // New V3 environmental/conditions fields.
  final _visibilityController = TextEditingController();
  final _airTempController = TextEditingController();
  final _surfaceTempController = TextEditingController();
  final _bottomTempController = TextEditingController();

  final _notesController = TextEditingController();

  // ---------------------------------------------------------------------------
  // Dropdown state
  //
  // These hold the selected values from dropdown fields.
  // ---------------------------------------------------------------------------

  String? _selectedTankType;
  double? _selectedTankSize = DiveConstants.defaultTankSize;
  String? _selectedGasMix = DiveConstants.defaultGasMix;
  String? _selectedActivityType;
  String? _selectedExposureProtection;

  @override
  void initState() {
    super.initState();
    _prefillDiveNumber();
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

  /// Keeps saved form dates as calendar dates without a time-of-day component.
  static DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // ---------------------------------------------------------------------------
  // Dive number suggestion
  // ---------------------------------------------------------------------------

  /// Suggests the next dive number without changing any existing dives.
  ///
  /// Future change point:
  /// If dive numbering later becomes profile-specific or trip-specific, this is
  /// where that filtering should be added before finding the highest number.
  Future<void> _prefillDiveNumber() async {
    final existingDives = await db.getAllDives();

    int? highestDiveNumber;

    for (final dive in existingDives) {
      final diveNumber = dive.diveNumber;
      if (diveNumber == null) continue;

      if (highestDiveNumber == null || diveNumber > highestDiveNumber) {
        highestDiveNumber = diveNumber;
      }
    }

    if (!mounted || _diveNumberController.text.isNotEmpty) return;

    final suggestedDiveNumber = ((highestDiveNumber ?? 0) + 1).toString();
    _diveNumberController.value = TextEditingValue(
      text: suggestedDiveNumber,
      selection: TextSelection.collapsed(offset: suggestedDiveNumber.length),
    );
  }

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
  // This builds a Drift companion object and inserts it into the database.
  //
  // Future change point:
  // Any new database field added to the Dives table should usually be added
  // here so new dives save that field.
  // ---------------------------------------------------------------------------

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
      tankSize: Value(_selectedTankSize),
      gasMix: Value(_selectedGasMix),

      weightUsed: Value(_toDouble(_weightUsedController.text)),
      activityType: Value(_selectedActivityType),

      // New V3 fields.
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
    );

    await db.insertDive(companion);

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  // ---------------------------------------------------------------------------
  // Date picker
  // ---------------------------------------------------------------------------

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _date = _dateOnly(picked));
    }
  }

  /// Formats the currently selected date for the form.
  ///
  /// Future change point:
  /// If the app gets shared date formatting later, this can move to a utility.
  String _formatDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  // ---------------------------------------------------------------------------
  // Screen layout
  // ---------------------------------------------------------------------------

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
              const SectionLabel("Dive Info"),

              ListTile(
                title: Text("Date: ${_formatDate(_date)}"),
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

              const SectionLabel("Equipment"),

              DropdownButtonFormField<String>(
                initialValue: _selectedTankType,
                items: DiveConstants.tankTypes
                    .map(
                      (t) => DropdownMenuItem<String>(value: t, child: Text(t)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedTankType = v),
                decoration: const InputDecoration(labelText: "Tank Type"),
              ),

              DropdownButtonFormField<double>(
                initialValue: _selectedTankSize,
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
                initialValue: _selectedGasMix,
                items: DiveConstants.gasMixes
                    .map(
                      (g) => DropdownMenuItem<String>(value: g, child: Text(g)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedGasMix = v),
                decoration: const InputDecoration(labelText: "Gas Mix"),
              ),

              DropdownButtonFormField<String>(
                initialValue: _selectedExposureProtection,
                items: DiveConstants.exposureProtectionTypes
                    .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)),
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

              const SectionLabel("Dive Conditions"),

              DropdownButtonFormField<String>(
                initialValue: _selectedActivityType,
                items: DiveConstants.activityTypes
                    .map(
                      (a) => DropdownMenuItem<String>(value: a, child: Text(a)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedActivityType = v),
                decoration: const InputDecoration(labelText: "Activity Type"),
              ),

              TextFormField(
                controller: _visibilityController,
                keyboardType: TextInputType.number,
                validator: _optionalIntValidator,
                decoration: const InputDecoration(labelText: "Visibility (ft)"),
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

              const SectionLabel("Pressure"),

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

              const SectionLabel("Notes"),

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
