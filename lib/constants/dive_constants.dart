/// Shared option lists for dive form dropdowns.
///
/// Centralizing these avoids the two screens drifting out of sync, which
/// previously could cause a DropdownButtonFormField to throw if a dive's
/// stored value wasn't present in one screen's local copy of the list.
class DiveConstants {
  static const List<String> tankTypes = ['Aluminum', 'Steel'];

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
}
