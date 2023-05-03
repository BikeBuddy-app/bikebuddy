import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class BBMap extends StatefulWidget {
  final MapController controller;

  const BBMap({
    super.key,
    required this.controller,
  });

  @override
  State<BBMap> createState() => _BBMapState();
}

class _BBMapState extends State<BBMap> {

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: widget.controller,
      trackMyPosition: true,
      initZoom: 19,

      minZoomLevel: 8,
      maxZoomLevel: 19,
      stepZoom: 1.0,
      userLocationMarker: UserLocationMaker(
        personMarker: const MarkerIcon(
          icon: Icon(
            Icons.home,
            color: Colors.red,
            size: 78,
          ),

        ),
        directionArrowMarker: const MarkerIcon(
          icon: Icon(
            Icons.directions_bike_outlined,
            color: Colors.black,
            shadows: [Shadow(color: Colors.white, blurRadius: 20.0)],
            size: 78,
          ),
        ),
      ),
      roadConfiguration: const RoadOption(
        roadColor: Colors.yellowAccent,
      ),
      markerOption: MarkerOption(
        defaultMarker: const MarkerIcon(
          icon: Icon(
            Icons.person_pin_circle,
            color: Colors.blue,
            size: 56,
          ),
        ),
      ),
    );
  }
}