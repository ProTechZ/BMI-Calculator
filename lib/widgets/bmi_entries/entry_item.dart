import 'package:bmi_calculator/model/entry.dart';
import 'package:bmi_calculator/widgets/bmi_entries/expanded_entry_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.MMMd();

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

  List<String> get dateSeperator {
    final formattedDate = dateFormatter.format(widget.entry.date); // "August 9"
    final sep = formattedDate.split(' '); // ['August', '9']
    return sep;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onExpandItem,
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      dateSeperator[1],
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      dateSeperator[0].toUpperCase(),
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: double.infinity,
                width: 2,
                color: colorScheme.onPrimaryContainer,
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Body Mass Index : ${widget.entry.bmi}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'Height: ${widget.entry.displayMeasurements[0]}',
                        style: const TextStyle(fontSize: 15.5),
                      ),
                      Text(
                        'Weight: ${widget.entry.displayMeasurements[1]}',
                        style: const TextStyle(fontSize: 15.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
