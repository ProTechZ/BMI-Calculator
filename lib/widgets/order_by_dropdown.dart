import 'package:bmi_calculator/bmi_calculator.dart';
import 'package:bmi_calculator/main.dart';
import 'package:flutter/material.dart';

class OrderByDowndrop extends StatelessWidget {
  const OrderByDowndrop({
    super.key,
    required this.selectedOrderByOption,
    required this.onChangeOrderBy,
  });

  final OrderByOption selectedOrderByOption;
  final void Function(OrderByOption?) onChangeOrderBy;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedOrderByOption,
      items: OrderByOption.values.map((orderByOption) {
        final name = orderByOption.name;
        return DropdownMenuItem(
          value: orderByOption,
          child: Text(
            name == 'bmi' ? name.toUpperCase() : name.toTitleCase(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        );
      }).toList(),
      onChanged: onChangeOrderBy,
    );
  }
}
