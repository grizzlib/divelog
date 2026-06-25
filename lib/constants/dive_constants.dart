/// Shared option lists for dive form dropdowns.
///
/// Centralizing these avoids the two screens drifting out of sync, which
/// previously could cause a DropdownButtonFormField to throw if a dive's
/// stored value wasn't present in one screen's local copy of the list.
class DiveConstants {
  static const List<String> tankTypes = [
    'Aluminum',
    'Steel',
  ];

  static const List<double> tankSizes = [
    63,
    80,
    100,
    120,
  ];

  static const double defaultTankSize = 80;

  static const List<String> gasMixes = [
    'Air',
    'Nitrox',
    'Other',
  ];

  static const String defaultGasMix = 'Air';

  static const List<String> activityTypes = [
    'Recreational',
    'Training',
    'Photography',
    'Wreck',
    'Drift',
    'Night',
    'Research',
    'Other',
  ];
  static const List<String> exposureProtectionTypes = [
  'None',
  'Rash Guard',
  'Dive Skin',
  'Shorty Wetsuit',
  '3mm Wetsuit',
  '5mm Wetsuit',
  '7mm Wetsuit',
  'Semi-Dry Suit',
  'Drysuit',
  'Other',
];
}