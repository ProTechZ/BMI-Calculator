import 'package:bmi_calculator/main.dart';
import 'package:bmi_calculator/model/entry.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMMMMEEEEd();

class ExpandedEntryItem extends StatelessWidget {
  const ExpandedEntryItem({super.key, required this.entry});

  final BMIEntry entry;

  RichText textSpan({
    required String text1,
    TextStyle style1 = const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    required String text2,
    TextStyle style2 = const TextStyle(color: Colors.black, fontSize: 16),
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text1, style: style1),
          TextSpan(text: text2, style: style2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = entry.displayMeasurements[0];
    final weight = entry.displayMeasurements[1];

    final status = entry.status[0] as BMIStatus;
    final statusExtra = entry.status[1] as String;

    Color statusColor = Colors.blue; // underweight

    if (status == BMIStatus.healthy) {
      statusColor = Colors.green;
    } else if (status == BMIStatus.overweight) {
      statusColor = Colors.yellow;
    } else if (status == BMIStatus.obese) {
      statusColor = Colors.red;
    }

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Container(
        height: 500,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            Text(
              dateFormatter.format(entry.date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 40),
            textSpan(text1: 'Body Mass Index: ', text2: entry.bmi.toString()),
            const SizedBox(height: 5),
            textSpan(text1: 'Height: ', text2: height),
            const SizedBox(height: 5),
            textSpan(text1: 'Weight: ', text2: weight),
            const SizedBox(height: 30),
            textSpan(
              text1: 'Status: ',
              style1: const TextStyle(color: Colors.black, fontSize: 18),
              text2: status.name.capitalize(),
              style2: TextStyle(color: statusColor, fontSize: 17),
            ),
            const SizedBox(height: 5),
            Text(
              statusExtra,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
            const Spacer(),
            const Text(
              '*According to the National Health and Medical Research Council, a healthy BMI is between 20-25 for most adults*',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
