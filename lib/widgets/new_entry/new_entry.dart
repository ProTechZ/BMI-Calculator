import 'package:bmi_calculator/data/entries.dart';
import 'package:bmi_calculator/model/entry.dart';
import 'package:bmi_calculator/widgets/new_entry/error_dialog.dart';
import 'package:bmi_calculator/widgets/unit_system_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

class NewBMIEntry extends StatefulWidget {
  const NewBMIEntry({super.key, required this.addEntry});

  final void Function(BMIEntry) addEntry;

  @override
  State<NewBMIEntry> createState() {
    return _NewBMIEntryState();
  }
}

class _NewBMIEntryState extends State<NewBMIEntry> {
  UnitSystem selectedUnitSystem = UnitSystem.metric;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String heightSuffix = 'cm';
  String weightSuffix = 'kg';

  void onChangeUnitSystem(UnitSystem? value) {
    if (value != null) {
      setState(() {
        selectedUnitSystem = value; // change the name in the dropdown
        final isMetric = value == UnitSystem.metric;
        heightSuffix = isMetric ? 'cm' : 'ft';
        weightSuffix = isMetric ? 'kg' : 'lb';
      });
    }
  }

  void onPickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final userSelectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      selectedDate = userSelectedDate!;
    });
  }

  void showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => ErrorDialog(msg),
    );
  }

  void onSubmit() {
    final enteredHeight = double.tryParse(heightController.text);
    final enteredWeight = double.tryParse(weightController.text);

    if (enteredHeight == null || enteredWeight == null) {
      showErrorDialog(
          'Please make sure you have entered a value for weight and height.');
      return;
    }

    final dates =
        entries.map((entry) => dateFormatter.format(entry.date)).toList();
    if (dates.contains(dateFormatter.format(selectedDate))) {
      showErrorDialog('There is already an entry using this date.');
      return;
    }

    final isMetric = selectedUnitSystem == UnitSystem.metric;
    final invalidHeightRange = isMetric
        ? enteredHeight < 91 || enteredHeight > 250 // 91cm to 250cm
        : enteredHeight < 3 ||
            enteredHeight >
                8.2; // 3ft to 8.2 ft (if selectedUnitSystem is imperial)
    final invalidWeightRange = isMetric
        ? enteredWeight < 30 || enteredWeight > 250 // 30kg to 250kg
        : enteredWeight < 66 ||
            enteredWeight >
                551; // 66lb to 551lb (if selectedUnitSystem is imperial)

    if (invalidHeightRange) {
      final range =
          selectedUnitSystem == UnitSystem.metric ? '91cm-250cm' : '3ft-8.2ft';
      showErrorDialog('Please make sure that the height is in between $range');
    } else if (invalidWeightRange) {
      final range =
          selectedUnitSystem == UnitSystem.metric ? '30kg-250kg' : '66lb-551lb';
      showErrorDialog('Please make sure that the weight is in between $range');
    } else {
      widget.addEntry(BMIEntry(
        height: enteredHeight,
        weight: enteredWeight,
        date: selectedDate,
        system: selectedUnitSystem,
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add New Entry', style: textTheme.titleMedium),
              UnitSystemDropDown(
                selectedUnitSystem: selectedUnitSystem,
                onChange: onChangeUnitSystem,
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  style: textTheme.labelMedium,
                  decoration: InputDecoration(
                    suffix: Text(heightSuffix),
                    label: Text('Height', style: textTheme.labelSmall),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: TextField(
                  controller: weightController,
                  style: textTheme.labelMedium,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffix: Text(weightSuffix),
                    label: Text('Weight', style: textTheme.labelSmall),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                dateFormatter.format(selectedDate),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              IconButton(
                onPressed: onPickDate,
                icon: const Icon(Icons.calendar_month_outlined),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: onSubmit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
