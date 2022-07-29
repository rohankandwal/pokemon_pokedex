import 'dart:math';

class Utility {
  double getBMI(final double weight, final double height) {
    return (weight) / (pow(height, 2));
  }
}
