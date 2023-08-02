import 'package:bmi_calculator/main.dart';
import 'package:bmi_calculator/model/entry.dart';
import 'package:flutter/material.dart';

class UnitSystemDropDown extends StatelessWidget {
  const UnitSystemDropDown({
    super.key,
    required this.selectedUnitSystem,
    required this.onChange,
  });

  final UnitSystem selectedUnitSystem;
  final void Function(UnitSystem?) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedUnitSystem,
      items: UnitSystem.values
          .map((unitSystem) => DropdownMenuItem(
                value: unitSystem, // used as identifier in DropdownButton.value
                child: Text(
                  unitSystem.name.capitalize(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ))
          .toList(),
      onChanged: onChange,
    );
  }
}
