import 'dart:async' as flutter_timer;

class Timer {
  late flutter_timer.Timer _timer;
  Duration duration = const Duration(seconds: 0);
  final Duration interval = const Duration(seconds: 1);
  final void Function(String timerValue) changeCallback;

  Timer(this.changeCallback);

  void start() {
    _timer = flutter_timer.Timer.periodic(
      interval,
      (timer) {
        duration += interval;
        changeCallback(toString());
      },
    );
  }

  void resume() {
    start();
  }

  void pause() {
    _timer.cancel();
  }

  void stop() {
    _timer.cancel();
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
