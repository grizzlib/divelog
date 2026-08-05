import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'dive_detail_screen.dart';

enum DiveListSortOption {
  newestFirst,
  oldestFirst,
  diveNumberAscending,
  diveNumberDescending,
  deepestFirst,
  longestBottomTimeFirst,
}

class DiveListScreen extends StatefulWidget {
  const DiveListScreen({super.key});

  @override
  State<DiveListScreen> createState() => _DiveListScreenState();
}

class _DiveListScreenState extends State<DiveListScreen> {
  List<Dive> _allDives = [];
  List<Dive> dives = [];
  final _searchController = TextEditingController();
  final _minimumDepthController = TextEditingController();
  final _maximumDepthController = TextEditingController();
  DiveListSortOption _sortOption = DiveListSortOption.newestFirst;
  String? _activityTypeFilter;
  String? _gasMixFilter;
  String? _tankTypeFilter;
  DateTime? _startDateFilter;
  DateTime? _endDateFilter;

  @override
  void initState() {
    super.initState();
    loadDives();
  }

  Future<void> loadDives() async {
    final results = await db.getAllDives();

    if (!mounted) return;
    setState(() {
      _allDives = results;
      _activityTypeFilter = _validFilter(
        _activityTypeFilter,
        _filterOptions((dive) => dive.activityType),
      );
      _gasMixFilter = _validFilter(
        _gasMixFilter,
        _filterOptions((dive) => dive.gasMix),
      );
      _tankTypeFilter = _validFilter(
        _tankTypeFilter,
        _filterOptions((dive) => dive.tankType),
      );
      _refreshVisibleDives();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _minimumDepthController.dispose();
    _maximumDepthController.dispose();
    super.dispose();
  }

  Future<void> _openDive(Dive dive) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DiveDetailScreen(dive: dive)),
    );

    // Refresh list if something changed (edit/delete).
    if (result == true) {
      await loadDives();
    }
  }

  // ---------------------------------------------------------------------------
  // Search, filters, and sorting
  //
  // Future CSV export can use the final `dives` list so exported rows respect
  // the same search, filter, and sort choices shown on screen.
  // ---------------------------------------------------------------------------

  void _changeSearch(String value) {
    setState(_refreshVisibleDives);
  }

  void _changeSort(DiveListSortOption? option) {
    if (option == null) return;

    setState(() {
      _sortOption = option;
      _refreshVisibleDives();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(_refreshVisibleDives);
  }

  void _setActivityTypeFilter(String? value) {
    setState(() {
      _activityTypeFilter = value;
      _refreshVisibleDives();
    });
  }

  void _setGasMixFilter(String? value) {
    setState(() {
      _gasMixFilter = value;
      _refreshVisibleDives();
    });
  }

  void _setTankTypeFilter(String? value) {
    setState(() {
      _tankTypeFilter = value;
      _refreshVisibleDives();
    });
  }

  void _clearFilters() {
    setState(() {
      _activityTypeFilter = null;
      _gasMixFilter = null;
      _tankTypeFilter = null;
      _refreshVisibleDives();
    });
  }

  void _changeRangeFilter(String value) {
    setState(_refreshVisibleDives);
  }

  void _clearRangeFilters() {
    _minimumDepthController.clear();
    _maximumDepthController.clear();
    setState(() {
      _startDateFilter = null;
      _endDateFilter = null;
      _refreshVisibleDives();
    });
  }

  Future<void> _selectDateFilter({required bool isStartDate}) async {
    final currentValue = isStartDate ? _startDateFilter : _endDateFilter;
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentValue ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null || !mounted) return;

    setState(() {
      if (isStartDate) {
        _startDateFilter = DateUtils.dateOnly(selectedDate);
      } else {
        _endDateFilter = DateUtils.dateOnly(selectedDate);
      }
      _refreshVisibleDives();
    });
  }

  void _clearDateFilter({required bool isStartDate}) {
    setState(() {
      if (isStartDate) {
        _startDateFilter = null;
      } else {
        _endDateFilter = null;
      }
      _refreshVisibleDives();
    });
  }

  String? _dateRangeError() {
    if (_startDateFilter != null &&
        _endDateFilter != null &&
        _startDateFilter!.isAfter(_endDateFilter!)) {
      return "Start date is after end date.";
    }
    return null;
  }

  String? _depthRangeError() {
    final minimumText = _minimumDepthController.text.trim();
    final maximumText = _maximumDepthController.text.trim();
    final minimumDepth = _parseDepth(minimumText);
    final maximumDepth = _parseDepth(maximumText);

    if ((minimumText.isNotEmpty && minimumDepth == null) ||
        (maximumText.isNotEmpty && maximumDepth == null)) {
      return "Depth must be a valid number.";
    }
    if (minimumDepth != null &&
        maximumDepth != null &&
        minimumDepth > maximumDepth) {
      return "Minimum depth is greater than maximum depth.";
    }
    return null;
  }

  void _refreshVisibleDives() {
    dives = _filteredDives();
    _sortDives(dives);
  }

  List<Dive> _filteredDives() {
    final query = _searchController.text.trim().toLowerCase();
    final minimumDepth = _parseDepth(_minimumDepthController.text);
    final maximumDepth = _parseDepth(_maximumDepthController.text);

    return _allDives.where((dive) {
      final matchesQuery = query.isEmpty || _matchesSearch(dive, query);
      final matchesActivity =
          _activityTypeFilter == null ||
          dive.activityType == _activityTypeFilter;
      final matchesGas = _gasMixFilter == null || dive.gasMix == _gasMixFilter;
      final matchesTank =
          _tankTypeFilter == null || dive.tankType == _tankTypeFilter;
      final diveDateTime = _sortDateTime(dive);
      final matchesStartDate =
          _startDateFilter == null || !diveDateTime.isBefore(_startDateFilter!);
      final endDateExclusive = _endDateFilter?.add(const Duration(days: 1));
      final matchesEndDate =
          endDateExclusive == null || diveDateTime.isBefore(endDateExclusive);
      final matchesMinimumDepth =
          minimumDepth == null || dive.maxDepthFt >= minimumDepth;
      final matchesMaximumDepth =
          maximumDepth == null || dive.maxDepthFt <= maximumDepth;

      return matchesQuery &&
          matchesActivity &&
          matchesGas &&
          matchesTank &&
          matchesStartDate &&
          matchesEndDate &&
          matchesMinimumDepth &&
          matchesMaximumDepth;
    }).toList();
  }

  double? _parseDepth(String value) {
    final depth = double.tryParse(value.trim());
    return depth != null && depth.isFinite ? depth : null;
  }

  List<String> _filterOptions(String? Function(Dive) valueForDive) {
    final values = _allDives
        .map(valueForDive)
        .whereType<String>()
        .where((value) => value.trim().isNotEmpty)
        .toSet()
        .toList();
    values.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return values;
  }

  String? _validFilter(String? filter, List<String> options) {
    return options.contains(filter) ? filter : null;
  }

  bool _matchesSearch(Dive dive, String query) {
    final searchableValues = [
      dive.locationName,
      dive.notes,
      dive.activityType,
      dive.gasMix,
      dive.tankType,
      dive.tankSize?.toString(),
      dive.diveNumber?.toString(),
    ];

    return searchableValues.any(
      (value) => value != null && value.toLowerCase().contains(query),
    );
  }

  void _sortDives(List<Dive> diveList) {
    diveList.sort(_compareDives);
  }

  int _compareDives(Dive a, Dive b) {
    switch (_sortOption) {
      case DiveListSortOption.newestFirst:
        return _compareNewestFirst(a, b);
      case DiveListSortOption.oldestFirst:
        return _compareOldestFirst(a, b);
      case DiveListSortOption.diveNumberAscending:
        return _compareDiveNumberAscending(a, b);
      case DiveListSortOption.diveNumberDescending:
        return _compareDiveNumberDescending(a, b);
      case DiveListSortOption.deepestFirst:
        return _compareDeepestFirst(a, b);
      case DiveListSortOption.longestBottomTimeFirst:
        return _compareLongestBottomTimeFirst(a, b);
    }
  }

  int _compareNewestFirst(Dive a, Dive b) {
    final dateCompare = _sortDateTime(b).compareTo(_sortDateTime(a));
    if (dateCompare != 0) return dateCompare;

    final numberCompare = _compareDiveNumberOnlyDescending(a, b);
    if (numberCompare != 0) return numberCompare;

    return a.id.compareTo(b.id);
  }

  int _compareOldestFirst(Dive a, Dive b) {
    final dateCompare = _sortDateTime(a).compareTo(_sortDateTime(b));
    if (dateCompare != 0) return dateCompare;

    final numberCompare = _compareDiveNumberOnlyAscending(a, b);
    if (numberCompare != 0) return numberCompare;

    return a.id.compareTo(b.id);
  }

  int _compareDiveNumberAscending(Dive a, Dive b) {
    final numberCompare = _compareDiveNumberOnlyAscending(a, b);
    if (numberCompare != 0) return numberCompare;

    return _compareNewestFirst(a, b);
  }

  int _compareDiveNumberDescending(Dive a, Dive b) {
    final numberCompare = _compareDiveNumberOnlyDescending(a, b);
    if (numberCompare != 0) return numberCompare;

    return _compareNewestFirst(a, b);
  }

  int _compareDiveNumberOnlyAscending(Dive a, Dive b) {
    final aNumber = a.diveNumber;
    final bNumber = b.diveNumber;

    if (aNumber == null && bNumber == null) return 0;
    if (aNumber == null) return 1;
    if (bNumber == null) return -1;

    return aNumber.compareTo(bNumber);
  }

  int _compareDiveNumberOnlyDescending(Dive a, Dive b) {
    final aNumber = a.diveNumber;
    final bNumber = b.diveNumber;

    if (aNumber == null && bNumber == null) return 0;
    if (aNumber == null) return 1;
    if (bNumber == null) return -1;

    return bNumber.compareTo(aNumber);
  }

  int _compareDeepestFirst(Dive a, Dive b) {
    final depthCompare = b.maxDepthFt.compareTo(a.maxDepthFt);
    if (depthCompare != 0) return depthCompare;

    return _compareNewestFirst(a, b);
  }

  int _compareLongestBottomTimeFirst(Dive a, Dive b) {
    final timeCompare = b.bottomTimeMin.compareTo(a.bottomTimeMin);
    if (timeCompare != 0) return timeCompare;

    return _compareNewestFirst(a, b);
  }

  DateTime _sortDateTime(Dive dive) {
    final time = _parseTimeIn(dive.timeIn);

    return DateTime(
      dive.date.year,
      dive.date.month,
      dive.date.day,
      time?.hour ?? 0,
      time?.minute ?? 0,
    );
  }

  TimeOfDay? _parseTimeIn(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final match = RegExp(
      r'^(\d{1,2})(?::(\d{2}))?\s*([ap]m)?$',
      caseSensitive: false,
    ).firstMatch(value.trim());

    if (match == null) return null;

    var hour = int.tryParse(match.group(1)!);
    final minute = int.tryParse(match.group(2) ?? '0');
    final period = match.group(3)?.toLowerCase();

    if (hour == null || minute == null || minute > 59) return null;
    if (period == null && hour > 23) return null;
    if (period != null && (hour < 1 || hour > 12)) return null;

    if (period == 'pm' && hour != 12) hour += 12;
    if (period == 'am' && hour == 12) hour = 0;

    return TimeOfDay(hour: hour, minute: minute);
  }

  String _sortOptionLabel(DiveListSortOption option) {
    switch (option) {
      case DiveListSortOption.newestFirst:
        return "Newest first";
      case DiveListSortOption.oldestFirst:
        return "Oldest first";
      case DiveListSortOption.diveNumberAscending:
        return "Dive number ascending";
      case DiveListSortOption.diveNumberDescending:
        return "Dive number descending";
      case DiveListSortOption.deepestFirst:
        return "Deepest first";
      case DiveListSortOption.longestBottomTimeFirst:
        return "Longest bottom time first";
    }
  }

  // ---------------------------------------------------------------------------
  // Screen widgets
  // ---------------------------------------------------------------------------

  Widget _searchControl() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: "Search dives",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearSearch,
                ),
        ),
        onChanged: _changeSearch,
      ),
    );
  }

  Widget _sortControl() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          const Text("Sort by"),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButton<DiveListSortOption>(
              value: _sortOption,
              isExpanded: true,
              items: DiveListSortOption.values
                  .map(
                    (option) => DropdownMenuItem<DiveListSortOption>(
                      value: option,
                      child: Text(_sortOptionLabel(option)),
                    ),
                  )
                  .toList(),
              onChanged: _changeSort,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rangeFilterControl() {
    final dateError = _dateRangeError();
    final depthError = _depthRangeError();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Date range"),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _dateFilterButton(
                label: "Start date",
                value: _startDateFilter,
                isStartDate: true,
              ),
              _dateFilterButton(
                label: "End date",
                value: _endDateFilter,
                isStartDate: false,
              ),
            ],
          ),
          if (dateError != null) _rangeErrorText(dateError),
          const SizedBox(height: 8),
          const Text("Depth range (ft)"),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minimumDepthController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Minimum depth",
                    isDense: true,
                  ),
                  onChanged: _changeRangeFilter,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _maximumDepthController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Maximum depth",
                    isDense: true,
                  ),
                  onChanged: _changeRangeFilter,
                ),
              ),
            ],
          ),
          if (depthError != null) _rangeErrorText(depthError),
          if (_hasRangeFilters())
            TextButton.icon(
              onPressed: _clearRangeFilters,
              icon: const Icon(Icons.restart_alt),
              label: const Text("Clear ranges"),
            ),
        ],
      ),
    );
  }

  bool _hasRangeFilters() {
    return _startDateFilter != null ||
        _endDateFilter != null ||
        _minimumDepthController.text.trim().isNotEmpty ||
        _maximumDepthController.text.trim().isNotEmpty;
  }

  Widget _rangeErrorText(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }

  Widget _dateFilterButton({
    required String label,
    required DateTime? value,
    required bool isStartDate,
  }) {
    final displayValue = value == null
        ? label
        : '${value.month}/${value.day}/${value.year}';

    return SizedBox(
      width: 220,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _selectDateFilter(isStartDate: isStartDate),
              icon: const Icon(Icons.calendar_today),
              label: Text(displayValue),
            ),
          ),
          if (value != null)
            IconButton(
              tooltip: "Clear $label",
              onPressed: () => _clearDateFilter(isStartDate: isStartDate),
              icon: const Icon(Icons.clear),
            ),
        ],
      ),
    );
  }

  Widget _filterControl() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _activityFilterDropdown(),
          _gasMixFilterDropdown(),
          _tankTypeFilterDropdown(),
          if (_hasFilters())
            TextButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.filter_alt_off),
              label: const Text("Clear filters"),
            ),
        ],
      ),
    );
  }

  bool _hasFilters() {
    return [
      _activityTypeFilter,
      _gasMixFilter,
      _tankTypeFilter,
    ].any((value) => value != null);
  }

  Widget _activityFilterDropdown() {
    return _filterDropdown(
      label: "Activity",
      value: _activityTypeFilter,
      options: _filterOptions((dive) => dive.activityType),
      onChanged: _setActivityTypeFilter,
    );
  }

  Widget _gasMixFilterDropdown() {
    return _filterDropdown(
      label: "Gas mix",
      value: _gasMixFilter,
      options: _filterOptions((dive) => dive.gasMix),
      onChanged: _setGasMixFilter,
    );
  }

  Widget _tankTypeFilterDropdown() {
    return _filterDropdown(
      label: "Tank type",
      value: _tankTypeFilter,
      options: _filterOptions((dive) => dive.tankType),
      onChanged: _setTankTypeFilter,
    );
  }

  Widget _filterDropdown({
    required String label,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      width: 180,
      child: DropdownButtonFormField<String?>(
        key: ValueKey('$label:$value'),
        initialValue: value,
        decoration: InputDecoration(labelText: label, isDense: true),
        items: [
          const DropdownMenuItem<String?>(value: null, child: Text('All')),
          ...options.map(
            (option) => DropdownMenuItem<String?>(
              value: option,
              child: Text(option, overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }

  Widget _diveList() {
    return ListView.builder(
      itemCount: dives.length,
      itemBuilder: (context, index) {
        final dive = dives[index];

        return ListTile(
          title: Text(dive.locationName ?? 'Unknown Location'),
          subtitle: Text('${dive.maxDepthFt} ft • ${dive.bottomTimeMin} min'),
          trailing: Text(
            '${dive.date.month}/${dive.date.day}/${dive.date.year}',
          ),
          onTap: () => _openDive(dive),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dive Log')),
      body: _allDives.isEmpty
          ? const Center(child: Text('No dives logged yet'))
          : Column(
              children: [
                _searchControl(),
                _filterControl(),
                _rangeFilterControl(),
                _sortControl(),
                Expanded(
                  child: dives.isEmpty
                      ? const Center(
                          child: Text('No dives match your search and filters'),
                        )
                      : _diveList(),
                ),
              ],
            ),
    );
  }
}
