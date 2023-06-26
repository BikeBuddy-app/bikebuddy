import 'package:geolocator/geolocator.dart';

const LocationSettings kLocationSettings = LocationSettings(
  accuracy: LocationAccuracy.best,
  distanceFilter: 2,
);

const Position POSITION_PAUSE = Position(
    longitude: 0,
    latitude: 0,
    timestamp: null,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0);