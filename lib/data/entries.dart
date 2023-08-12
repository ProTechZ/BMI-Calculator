import 'package:bmi_calculator/model/entry.dart';

final now = DateTime.now();

final entries = [
  BMIEntry(
    height: 140,
    weight: 92,
    date: DateTime(now.year, now.month, now.day),
    system: UnitSystem.metric,
  ),
  BMIEntry(
    height: 150,
    weight: 97,
    date: DateTime(now.year, now.month, now.day - 1),
    system: UnitSystem.metric,
  ),
  BMIEntry(
    height: 160,
    weight: 102,
    date: DateTime(now.year, now.month, now.day - 2),
    system: UnitSystem.metric,
  ),
  BMIEntry(
    height: 170,
    weight: 107,
    date: DateTime(now.year, now.month, now.day - 3),
    system: UnitSystem.metric,
  ),
  BMIEntry(
    height: 150,
    weight: 97,
    date: DateTime(now.year, now.month, now.day - 4),
    system: UnitSystem.metric,
  ),
  BMIEntry(
    height: 160,
    weight: 102,
    date: DateTime(now.year, now.month, now.day - 5),
    system: UnitSystem.metric,
  ),
  BMIEntry(
    height: 170,
    weight: 107,
    date: DateTime(now.year, now.month, now.day - 6),
    system: UnitSystem.metric,
  ),
];
