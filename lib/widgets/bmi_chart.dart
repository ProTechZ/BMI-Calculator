import 'package:bmi_calculator/model/entry.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.Md();

class BMIChart extends StatelessWidget {
  const BMIChart({super.key, required this.bmiEntries});

  final List<BMIEntry> bmiEntries;

  List<double> get bmis {
    final copy = [...bmiEntries];

    // sorts the list by the entries' dates in descending order so that the most recent dates are first
    // and we want to get the 7 most recent dates
    copy.sort((entry1, entry2) => entry2.date.compareTo(entry1.date));

    if (bmiEntries.length >= 7) {
      // bmiEntries has 7 items or more, so we want to get the first 7 items
      return copy.sublist(0, 7).map((entry) => entry.bmi).toList();
    } else {
      // bmiEntries has less than 7 items so we do not need to sublist
      return bmiEntries.map((entry) => entry.bmi).toList();
    }
  }

  List<FlSpot> get spots {
    final List<FlSpot> dataSpots = [];

    // reversing the list so that the dates are in ascending order
    final y = bmis.reversed.toList();

    for (var i = 0; i < y.length; i++) {
      dataSpots.add(FlSpot(i.toDouble(), y[i]));
    }

    return dataSpots;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 35, 0),
      child: AspectRatio(
        aspectRatio: 1,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                color: colorScheme.primary,
              )
            ],
            borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide()),
            ),
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                axisNameWidget: const Text('Date'),
                sideTitles:
                    _bottomTitles(bmiEntries.map((e) => e.date).toList()),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
                axisNameWidget: Text('BMI'),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: colorScheme.onPrimaryContainer,
                tooltipRoundedRadius: 20.0,
                showOnTopOfTheChartBoxArea: true,
                fitInsideHorizontally: true,
                tooltipMargin: 0,
                getTooltipItems: (touchedSpots) => touchedSpots.map(
                  (LineBarSpot touchedSpot) {
                    return LineTooltipItem(
                      spots[touchedSpot.spotIndex].y.toStringAsFixed(2),
                      const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    );
                  },
                ).toList(),
              ),
              getTouchedSpotIndicator: (barData, List<int> indicators) =>
                  indicators.map(
                (int index) {
                  return const TouchedSpotIndicatorData(
                    FlLine(
                      color: Colors.grey,
                      strokeWidth: 1,
                    ),
                    FlDotData(
                      show: false,
                    ),
                  );
                },
              ).toList(),
              getTouchLineEnd: (_, __) => double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}

SideTitles _bottomTitles(List<DateTime> dates) {
  final formattedDates =
      dates.reversed.map((e) => dateFormatter.format(e)).toList();

  return SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      switch (value) {
        case 0:
          return Text(formattedDates[0]);
        case 1:
          return Text(formattedDates[1]);
        case 2:
          return Text(formattedDates[2]);
        case 3:
          return Text(formattedDates[3]);
        case 4:
          return Text(formattedDates[4]);
        case 5:
          return Text(formattedDates[5]);
        case 6:
          return Text(formattedDates[6]);
      }
      return const Text('');
    },
  );
}
