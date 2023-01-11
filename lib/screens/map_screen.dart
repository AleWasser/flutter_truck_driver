import 'package:flutter/material.dart';
import 'package:flutter_truck_driver_app/widgets/search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(41.8245, -87.6484),
            zoom: 15,
          ),
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
        ),
        SearchBar(),
      ],
    );
  }
}
