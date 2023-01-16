import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_truck_driver_app/bloc/location/location_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  StreamSubscription<LocationState>? locationStateSubscription;
  GoogleMapController? _mapController;

  MapBloc({required this.locationBloc}) : super(MapState()) {
    on<OnMapInitializedEvent>((event, emit) {
      _mapController = event.controller;
      emit(state.copyWith(isInitialized: true));
    });
    on<OnCenterCameraOnUserEvent>(_onToggleFollowingUser);

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (!state.isFollowingUser || locationState.lastKnownLocation == null) {
        return;
      }
      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onToggleFollowingUser(
    OnCenterCameraOnUserEvent event,
    Emitter<MapState> emit,
  ) {
    if (state.isFollowingUser == event.isFollowingUser) return;

    emit(state.copyWith(isFollowingUser: event.isFollowingUser));

    if (state.isFollowingUser && locationBloc.state.lastKnownLocation != null) {
      moveCamera(locationBloc.state.lastKnownLocation!);
    }
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }
}
