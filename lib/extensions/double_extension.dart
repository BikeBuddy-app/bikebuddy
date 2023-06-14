extension DoubleRounding on double {
  //? Można wymienić na matematyczną funkcję ale niech już będzie.
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
