import 'package:bike_buddy/hive/entities/ride_item.dart';
import 'package:geolocator/geolocator.dart';

Map extractLatitudeLongitude(String position) {
  RegExp regex = RegExp(r"Latitude: (.*), Longitude: (.*)");
  var match = regex.allMatches(position).elementAt(0);
  return {"Lat": double.parse(match.group(1)!), "Lon": double.parse(match.group(2)!)};
}

double calculateDistance(RideItem trip) {
  var distance = 0.0;

  for (var i = 0; i < trip.positionTimestamps.length - 1; i++) {
    var startPosition = trip.positionTimestamps[i].position;
    if (startPosition == 'None') continue;
    startPosition = extractLatitudeLongitude(startPosition);
    var endPosition = extractLatitudeLongitude(trip.positionTimestamps[i+1].position);

    distance += Geolocator.distanceBetween(startPosition["Lat"], startPosition["Lon"], endPosition["Lat"], endPosition["Lon"]);
  }
  
  return distance;
}