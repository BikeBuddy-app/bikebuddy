class StandardDuration extends Duration {
  StandardDuration(Duration duration)
      : super(microseconds: duration.inMicroseconds);

  @override
  String toString() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final String hours = strDigits(super.inHours);
    final String minutes = strDigits(
      super.inMinutes.remainder(60),
    );
    final String seconds = strDigits(
      super.inSeconds.remainder(60),
    );
    return "$hours:$minutes:$seconds";
  }
}
