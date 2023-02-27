import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_truck_driver_app/bloc/map/map_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;
  final MapBloc mapBloc;

  LocationBloc({required this.mapBloc}) : super(const LocationState()) {
    on<OnStartFollowingUser>((event, emit) {
      followUser();
      emit(state.copyWith(isFollowingUser: true));
    });

    on<OnStopFollowingUser>((event, emit) {
      stopFollowingUser();
      emit(state.copyWith(isFollowingUser: false));
    });

    on<OnNewUserLocationEvent>(
      (event, emit) => emit(
        state.copyWith(
          lastKnownLocation: event.newLocation,
        ),
      ),
    );
  }

  Future<void> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  void followUser() {
    positionStream = Geolocator.getPositionStream().listen((event) {
      final coordinates = LatLng(event.latitude, event.longitude);
      add(OnNewUserLocationEvent(coordinates));

      if (state.isFollowingUser) {
        mapBloc.add(OnMoveCameraToCoordinatesEvent(coordinates));
      }
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
