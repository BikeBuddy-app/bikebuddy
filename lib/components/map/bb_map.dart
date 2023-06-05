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
      trackMyPosition: false,
      initZoom: 19,
      minZoomLevel: 8,
      maxZoomLevel: 19,
      stepZoom: 1.0,
      userLocationMarker: UserLocationMaker( //todo test if default marker can be successfully set here
        personMarker: const MarkerIcon(
          icon: Icon(
            null,
            color: Colors.transparent,
            size: 1,
          ),
        ),
        directionArrowMarker: const MarkerIcon(
          icon: Icon(
            null,
            color: Colors.transparent,
            size: 1,
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
