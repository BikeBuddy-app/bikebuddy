import 'dart:async' as flutter_timer;

import 'package:bike_buddy/models/standard_duration.dart';

class Timer {
  late flutter_timer.Timer _timer;
  Duration _duration = const Duration(seconds: 0);
  Duration _withoutMoveDuration = const Duration(seconds: 0);
  final Duration allowedTimeWithoutMove = const Duration(seconds: 5);
  final Duration interval;
  final void Function(Duration) changeCallback;
  final void Function()? onNotMoving;

  Timer(
      {required this.changeCallback,
      this.onNotMoving,
      this.interval = const Duration(seconds: 1)});

  void start() {
    _timer = flutter_timer.Timer.periodic(
      interval,
      (timer) {
        _duration += interval;
        if ((_withoutMoveDuration += interval) >= allowedTimeWithoutMove) {
          onNotMoving?.call();
        }
        changeCallback(StandardDuration(_duration));
      },
    );
  }

  void registerMove() {
    _withoutMoveDuration = const Duration(seconds: 0);
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
