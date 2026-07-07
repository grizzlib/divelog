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
  List<Dive> dives = [];
  DiveListSortOption _sortOption = DiveListSortOption.newestFirst;

  @override
  void initState() {
    super.initState();
    loadDives();
  }

  Future<void> loadDives() async {
    final results = await db.getAllDives();
    _sortDives(results);

    if (!mounted) return;
    setState(() {
      dives = results;
    });
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
  // Sorting
  //
  // Future change point:
  // Add search and filter state near _sortOption, then apply search/filter/sort
  // together before displaying the list.
  // ---------------------------------------------------------------------------

  void _changeSort(DiveListSortOption? option) {
    if (option == null) return;

    setState(() {
      _sortOption = option;
      _sortDives(dives);
    });
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

  Widget _sortControl() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
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
      body: dives.isEmpty
          ? const Center(child: Text('No dives logged yet'))
          : Column(
              children: [
                _sortControl(),
                Expanded(child: _diveList()),
              ],
            ),
    );
  }
}
