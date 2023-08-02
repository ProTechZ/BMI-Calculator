import 'package:bmi_calculator/data/entries.dart';
import 'package:bmi_calculator/model/entry.dart';
import 'package:bmi_calculator/widgets/entry_list.dart';
import 'package:bmi_calculator/widgets/new_entry.dart';
import 'package:bmi_calculator/widgets/order_by_dropdown.dart';
import 'package:bmi_calculator/widgets/unit_system_dropdown.dart';
import 'package:flutter/material.dart';

enum OrderByOption { date_added, bmi, height, weight }

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() {
    return _BMICalculatorState();
  }
}

class _BMICalculatorState extends State<BMICalculator> {
  UnitSystem selectedUnitSystem = UnitSystem.metric;
  OrderByOption orderby = OrderByOption.date_added;

  final bmiEntries = entries;

  void addEntry(BMIEntry entry) {
    setState(() {
      bmiEntries.insert(0, entry);
    });
  }

  void onPressAddEntry() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewBMIEntry(
        addEntry: addEntry,
      ),
    );
  }

  void onChangeUnitSystem(UnitSystem? value) {
    if (value != null) {
      setState(() {
        selectedUnitSystem = value;
        for (final entry in bmiEntries) {
          entry.convertTo(value);
        }
      });
    }
  }

// polo g - da goat, die a legend, hall of fame2
  void onChangeOrderBy(OrderByOption? value) {
    if (value == null) {
      return;
    }

    setState(() {
      orderby = value;
      if (value == OrderByOption.date_added) {
        bmiEntries.sort((entry1, entry2) => entry2.date.compareTo(entry1.date));
      } else if (value == OrderByOption.bmi) {
        bmiEntries.sort((entry1, entry2) => entry2.bmi.compareTo(entry1.bmi));
      } else if (value == OrderByOption.height) {
        bmiEntries
            .sort((entry1, entry2) => entry2.height.compareTo(entry1.height));
      } else if (value == OrderByOption.weight) {
        bmiEntries
            .sort((entry1, entry2) => entry2.height.compareTo(entry1.weight));
      }
    });
  }

  void onRemoveEntry(BMIEntry entry) {
    final entryIndex = bmiEntries.indexOf(entry);
    setState(() {
      bmiEntries.removeAt(entryIndex);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            child: const Text('Deleted BMI Entry'),
          ),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                bmiEntries.insert(entryIndex, entry);
              });
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        actions: [
          IconButton(
            onPressed: onPressAddEntry,
            tooltip: 'Add Entry',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Chart'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OrderByDowndrop(
                  selectedOrderByOption: orderby,
                  onChangeOrderBy: onChangeOrderBy,
                ),
                UnitSystemDropDown(
                  selectedUnitSystem: selectedUnitSystem,
                  onChange: onChangeUnitSystem,
                ),
              ],
            ),
            Expanded(
                child: BMIEntryList(
                    bmiEntries: bmiEntries, onRemoveEntry: onRemoveEntry)),
          ],
        ),
      ),
    );
  }
}
