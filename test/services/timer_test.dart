import 'package:bike_buddy/services/timer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should be 00:00:00 at the beginning', () {
    String expectedDuration = "00:00:00";
    final timer = Timer((timerValue) {}, (){});
    String actualDuration = timer.duration.toString();

    expect(actualDuration, expectedDuration);
  });

  test('Should be greater than 00:00:00 after some time', () async {
    final timer = Timer((timerValue) {}, (){});
    Duration startingDuration = timer.duration;
    timer.start();
    await Future.delayed(const Duration(seconds: 3));
    Duration currentDuration = timer.duration;

    int actual = currentDuration.compareTo(startingDuration);

    expect(actual, isPositive);
  });
}
