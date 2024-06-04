import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/parking_map.dart';
import '../widgets/parking_list.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(7.088096517195564, 125.62385398071346);
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'googleapi_key');
  List<PlacesSearchResult> parkingSpaces = [];
  LatLng currentLocation = LatLng(7.088096517195564, 125.62385398071346);
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
    if (status.isGranted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      currentLocation = _center;
      markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: currentLocation,
          infoWindow: InfoWindow(
            title: 'Current Location',
          ),
        ),
      );
    });
    _getNearbyParkingSpaces();
  }

  Future<void> _getNearbyParkingSpaces() async {
    PlacesSearchResponse response = await _places.searchNearbyWithRadius(
      Location(lat: currentLocation.latitude, lng: currentLocation.longitude),
      1500,
      type: 'parking',
    );
    setState(() {
      parkingSpaces = response.results;
      markers.addAll(parkingSpaces.map((parkingSpace) {
        final LatLng location = LatLng(
          parkingSpace.geometry!.location.lat,
          parkingSpace.geometry!.location.lng,
        );
        return Marker(
          markerId: MarkerId(parkingSpace.placeId),
          position: location,
          infoWindow: InfoWindow(
            title: parkingSpace.name ?? 'Unknown',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        );
      }).toList());
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _goToLocation(LatLng location) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: location,
        zoom: 22.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('😎UPark'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ParkingMap(
              center: _center,
              markers: markers,
              onMapCreated: _onMapCreated,
            ),
          ),
          Container(
            height: 400,
            child: ParkingList(
              parkingSpaces: parkingSpaces,
              onTap: _goToLocation,
            ),
          ),
        ],
      ),
    );
  }
}
