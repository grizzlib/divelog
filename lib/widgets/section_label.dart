import 'package:flutter/material.dart';

/// Shared section heading used by long forms.
///
/// Future change point:
/// If the app gets a more polished visual style later, update this widget once
/// instead of changing each form screen separately.
class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
