import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test("does not break list when already added to map", () {
    Map<String, List<GeoPoint>> roads = {};
    List<GeoPoint> initialRoad = [GeoPoint(latitude: 10, longitude: 10)];
    List<GeoPoint> currentRoad = initialRoad;
    roads.addAll({"test": currentRoad});
    currentRoad = [GeoPoint(latitude: 12, longitude: 12)];
    expect(roads['test'], [GeoPoint(latitude: 10, longitude: 10)]);
    
  });
}
