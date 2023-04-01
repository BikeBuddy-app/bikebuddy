import 'package:geolocator/geolocator.dart';

const LocationSettings kLocationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 5,
);