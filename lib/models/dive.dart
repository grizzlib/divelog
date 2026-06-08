class Dive {
  final DateTime date;
  final String? locationName;
  final int maxDepthFt;
  final int bottomTimeMin;
  final int? startPressurePsi;
  final int? endPressurePsi;
  final String? notes;

  Dive({
    required this.date,
    this.locationName,
    required this.maxDepthFt,
    required this.bottomTimeMin,
    this.startPressurePsi,
    this.endPressurePsi,
    this.notes,
  });
}