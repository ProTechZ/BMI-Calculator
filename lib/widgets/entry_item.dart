import 'package:bmi_calculator/model/entry.dart';
import 'package:bmi_calculator/widgets/expanded_entry_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

class BMIEntryItem extends StatefulWidget {
  const BMIEntryItem({super.key, required this.entry});

  final BMIEntry entry;

  @override
  State<StatefulWidget> createState() {
    return _BMIEntryItemState();
  }
}

class _BMIEntryItemState extends State<BMIEntryItem> {
  void onExpandItem() {
    showDialog(
      context: context,
      builder: (ctx) => ExpandedEntryItem(entry: widget.entry),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.entry.displayMeasurements[0];
    final weight = widget.entry.displayMeasurements[1];

    return InkWell(
      onTap: onExpandItem,
      child: Container(
        height: 140,
        width: 80,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dateFormatter.format(widget.entry.date),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Height: ${height}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 30),
                  Text('Weight: $weight'),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Body Mass Index: ${widget.entry.bmi}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
