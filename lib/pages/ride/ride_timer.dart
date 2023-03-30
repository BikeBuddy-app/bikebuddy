import 'dart:async';

class RideTimer {
  Timer? timer;
  Duration duration = const Duration(seconds: 0);
  final Duration interval = const Duration(seconds: 1);
  final void Function(String timerValue) changeCallback;

  RideTimer(this.changeCallback);

  void start() {
    timer = Timer.periodic(
      interval,
      (timer) {
        duration += interval;
        changeCallback(toString());
      },
    );
  }

  void pause() {
    timer!.cancel();
  }

  @override
  String toString() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final String hours = strDigits(duration.inHours);
    final String minutes = strDigits(
      duration.inMinutes.remainder(60),
    );
    final String seconds = strDigits(
      duration.inSeconds.remainder(60),
    );
    return "$hours:$minutes:$seconds";
  }
}
