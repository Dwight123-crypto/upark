import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingMap extends StatelessWidget {
  final LatLng center;
  final Set<Marker> markers;
  final Function(GoogleMapController) onMapCreated;

  ParkingMap({
    required this.center,
    required this.markers,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 11.0,
      ),
      markers: markers,
    );
  }
}
