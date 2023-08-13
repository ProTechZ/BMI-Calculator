import 'package:bmi_calculator/data/entries.dart';
import 'package:bmi_calculator/model/entry.dart';
import 'package:bmi_calculator/widgets/bmi_chart.dart';
import 'package:bmi_calculator/widgets/bmi_entries/entry_list.dart';
import 'package:bmi_calculator/widgets/new_entry/new_entry.dart';
import 'package:bmi_calculator/widgets/order_by_dropdown.dart';
import 'package:bmi_calculator/widgets/unit_system_dropdown.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
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
  Padding chart = Padding(
    padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
    child: BMIChart(bmiEntries: entries),
  ); // defining the chart here so that it's data isn't affected by the order_by changes

  final bmiEntries = entries;

  void addEntry(BMIEntry entry) {
    setState(() {
      bmiEntries.add(entry);
    });
  }

  void onPressAddEntry() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
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

  Widget dropdowns(bool isPortrait) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OrderByDowndrop(
          selectedOrderByOption: orderby,
          onChangeOrderBy: onChangeOrderBy,
        ),
        isPortrait ? const SizedBox() : const SizedBox(width: 100),
        UnitSystemDropDown(
          selectedUnitSystem: selectedUnitSystem,
          onChange: onChangeUnitSystem,
        ),
      ],
    );
  }

  Widget get bmiEntryList {
    return BMIEntryList(
      bmiEntries: bmiEntries,
      onRemoveEntry: onRemoveEntry,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

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
      body: isPortrait
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                chart,
                dropdowns(isPortrait),
                Expanded(child: bmiEntryList),
              ],
            )
          : Row(
              children: [
                Expanded(child: chart),
                Column(
                  children: [
                    dropdowns(isPortrait),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width / 2,
                      child: bmiEntryList,
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
