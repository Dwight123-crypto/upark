import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingList extends StatelessWidget {
  final List<PlacesSearchResult> parkingSpaces;
  final Function(LatLng) onTap;

  ParkingList({
    required this.parkingSpaces,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Nearby Parking Space',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: parkingSpaces.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(parkingSpaces[index].name ?? 'Unknown'),
                subtitle: Text(
                    parkingSpaces[index].vicinity ?? 'No address available'),
                onTap: () {
                  final LatLng location = LatLng(
                    parkingSpaces[index].geometry!.location.lat,
                    parkingSpaces[index].geometry!.location.lng,
                  );
                  onTap(location);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
