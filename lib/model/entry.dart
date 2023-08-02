enum UnitSystem { metric, imperial }

enum BMIStatus { underweight, healthy, overweight, obese }

const underweightExtra =
    'Your weight is less than it ideally should be. You may need to aim at gaining weight. Try think of small, practical changes you feel comfortable with to achieve a healthy weight.';
const healthyExtra =
    'Your BMI is currently within what is considered a healthy weight range. Being a healthy weight has important benefits as it can help reduce your risk of heart disease, diabetes and a range of other conditions.';
const overweightExtra =
    'Your weight appears to be a bit above the ideal range. You might like to think about whether you need to set yourself a new target for a healthy weight.';
const obeseExtra =
    'You currently weigh more than is ideal. This puts your health at risk and is of increasing concern, particularly as you get older.';

double calculateBMI(num height, num weight, UnitSystem system) {
  if (system == UnitSystem.imperial) {
    weight = (weight / 2.205).round();
    height = (height / .03281).round();
    // convert to metric
  }

  var raw = weight / (height * height); // w * h² =>  0.002653521
  raw *= 10000; // => 26.53521
  raw = double.parse(raw.toStringAsFixed(1)); // => double.parse(String(26.5)) ;
  return raw;
}

class BMIEntry {
  BMIEntry({
    required this.height,
    required this.weight,
    required this.date,
    required this.system,
  }) : bmi = calculateBMI(height, weight, system);

  final DateTime date;
  final double bmi;
  num height;
  num weight;
  UnitSystem system;

  List<Object> get status {
    if (bmi < 20) {
      return [BMIStatus.underweight, underweightExtra];
    } else if (bmi >= 20 && bmi <= 25) {
      return [BMIStatus.healthy, healthyExtra];
    } else if (bmi > 25 && bmi < 30) {
      return [BMIStatus.overweight, overweightExtra];
    } else if (bmi >= 30) {
      return [BMIStatus.obese, obeseExtra];
    }
    return [];
  }

  List<String> get displayMeasurements {
    if (system == UnitSystem.metric) {
      return ['$height cm', '$weight kg'];
    } else if (system == UnitSystem.imperial) {
      return ['$height ft', '$weight lb'];
    }
    return [''];
  }

  void convertTo(UnitSystem systemTo) {
    // systemTo => system to convert height and weight to

    if (systemTo == UnitSystem.imperial && system == UnitSystem.metric) {
      // convert to imperial
      weight = (weight * 2.20462).round(); // 1kg = 2.20462lb
      height = double.parse(
          (height / 30.48).toStringAsFixed(2)); // 1cm = 0.0328084ft
      system = UnitSystem.imperial;
    } else if (systemTo == UnitSystem.metric && system == UnitSystem.imperial) {
      // convert to metric
      weight = (weight / 2.20462).round(); // 2.205pounds =  1kg
      height = (height * 30.48).round(); //  1ft = 30.48cm
      system = UnitSystem.metric;
    }
  }
}
