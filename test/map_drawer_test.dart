import 'package:bike_buddy/pages/ride/map_drawer.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  MapDrawer mapDrawer = MapDrawer();
  setUp(() => mapDrawer = MapDrawer());
  test("do nothing when enough points", () {
    List<GeoPoint> road = [
      GeoPoint(latitude: 1, longitude: 2),
      GeoPoint(latitude: 3, longitude: 5),
      GeoPoint(latitude: 7, longitude: 11)
    ];

    var adjusted = mapDrawer.adjustRoad(road);

    expect(adjusted, road);
    expect(adjusted.length, 3);
  });

  test("do nothing when many points", () {
    List<GeoPoint> road = [
      GeoPoint(latitude: 1, longitude: 2),
      GeoPoint(latitude: 3, longitude: 5),
      GeoPoint(latitude: 7, longitude: 11),
      GeoPoint(latitude: 13, longitude: 17),
      GeoPoint(latitude: 19, longitude: 23),
    ];

    var adjusted = mapDrawer.adjustRoad(road);

    expect(adjusted, road);
    expect(adjusted.length, 5);
  });

  test("create point between if only 2 points", () {
    List<GeoPoint> road = [
      GeoPoint(latitude: 1, longitude: 2),
      GeoPoint(latitude: 3, longitude: 5),
    ];

    var expectedPoint = GeoPoint(latitude: 2, longitude: 3.5);

    var adjusted = mapDrawer.adjustRoad(road);

    expect(adjusted, contains(expectedPoint));
    expect(adjusted.length, 3);
  });

  test("create different points nearby when only one point", () {
    List<GeoPoint> road = [
      GeoPoint(latitude: 1, longitude: 2),
    ];

    var adjusted = mapDrawer.adjustRoad(road);

    expect(
        adjusted,
        contains(GeoPoint(
          latitude: 1 - 2 * double.minPositive,
          longitude: 2 - 2 * double.minPositive,
        )));
    expect(
        adjusted,
        contains(GeoPoint(
          latitude: 1 - double.minPositive,
          longitude: 2 - double.minPositive,
        )));
    expect(
        adjusted,
        contains(GeoPoint(
          latitude: 1,
          longitude: 2,
        )));
    expect(adjusted.length, 3);
  });
}
