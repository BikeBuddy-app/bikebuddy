import 'dart:async' as flutter_timer;

import 'package:bike_buddy/models/standard_duration.dart';

class Timer {
  late flutter_timer.Timer _timer;
  Duration _duration = const Duration(seconds: 0);
  final Duration interval = const Duration(seconds: 1);
  final void Function(Duration) changeCallback;

  Timer(this.changeCallback);

  void start() {
    _timer = flutter_timer.Timer.periodic(
      interval,
      (timer) {
        _duration += interval;
        changeCallback(StandardDuration(_duration));
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

  get duration => StandardDuration(_duration);
}
