import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_truck_driver_app/bloc/map/map_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final LatLng initialLocation;
  const MapWidget({
    super.key,
    required this.initialLocation,
  });

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Listener(
      onPointerMove: (_) => mapBloc.add(const OnCenterCameraOnUserEvent(false)),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 16,
        ),
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        onMapCreated: (controller) {
          mapBloc.add(OnMapInitializedEvent(controller));
        },
      ),
    );
  }
}
