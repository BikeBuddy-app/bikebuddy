import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class BBMap extends StatefulWidget {
  final MapController controller;
  final Function(bool)? onLoaded;

  const BBMap({
    super.key,
    required this.controller,
    this.onLoaded,
  });

  @override
  State<BBMap> createState() => _BBMapState();
}

class _BBMapState extends State<BBMap> {
  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      onMapIsReady: widget.onLoaded,
      controller: widget.controller,
      initZoom: 19,
      minZoomLevel: 8,
      maxZoomLevel: 19,
      stepZoom: 1.0,
      userLocationMarker: UserLocationMaker(
        //todo test if default marker can be successfully set here
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
        defaultMarker: MarkerIcon(
          icon: Icon(
            Icons.directions_bike_outlined,
            size: 78,
            color: Colors.pink.shade300,
          ),
        ),
      ),
    );
  }
}
