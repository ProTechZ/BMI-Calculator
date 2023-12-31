import 'package:bmi_calculator/model/entry.dart';
import 'package:bmi_calculator/widgets/bmi_entries/entry_item.dart';
import 'package:flutter/material.dart';

class BMIEntryList extends StatelessWidget {
  const BMIEntryList({
    super.key,
    required this.bmiEntries,
    required this.onRemoveEntry,
  });

  final List<BMIEntry> bmiEntries;
  final void Function(BMIEntry) onRemoveEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: bmiEntries.length,
        itemBuilder: (context, index) {
          final entry = bmiEntries[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) => onRemoveEntry(entry),
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: Theme.of(context).cardTheme.margin,
            ),
            child: Column(
              children: [
                BMIEntryItem(entry: entry),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
