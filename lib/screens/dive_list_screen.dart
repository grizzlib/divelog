import 'package:flutter/material.dart';
import '../db/app_database.dart';
import 'dive_detail_screen.dart';

class DiveListScreen extends StatefulWidget {
  const DiveListScreen({super.key});

  @override
  State<DiveListScreen> createState() => _DiveListScreenState();
}

class _DiveListScreenState extends State<DiveListScreen> {
  List<Dive> dives = [];

  @override
  void initState() {
    super.initState();
    loadDives();
  }

  Future<void> loadDives() async {
    final results = await db.getAllDives();

    setState(() {
      dives = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dive Log'),
      ),
      body: dives.isEmpty
          ? const Center(
              child: Text('No dives logged yet'),
            )
          : ListView.builder(
              itemCount: dives.length,
              itemBuilder: (context, index) {
                final dive = dives[index];

                return ListTile(
                  title: Text(
                    dive.locationName ?? 'Unknown Location',
                  ),
                  subtitle: Text(
                    '${dive.maxDepthFt} ft • ${dive.bottomTimeMin} min',
                  ),
                  trailing: Text(
                    '${dive.date.month}/${dive.date.day}/${dive.date.year}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DiveDetailScreen(
                          dive: dive,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}