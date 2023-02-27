import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_truck_driver_app/bloc/location/location_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  StreamSubscription<LocationState>? locationStateSubscription;
  GoogleMapController? _mapController;

  MapBloc() : super(const MapState()) {
    on<OnMapInitializedEvent>((event, emit) {
      _mapController = event.controller;
      emit(state.copyWith(isInitialized: true));
    });
    on<OnMoveCameraToCoordinatesEvent>(
      (event, _) => moveCamera(event.coordinates),
    );
  }

  void moveCamera(LatLng coordinates) {
    final cameraUpdate = CameraUpdate.newLatLng(coordinates);
    _mapController?.animateCamera(cameraUpdate);
  }
}
