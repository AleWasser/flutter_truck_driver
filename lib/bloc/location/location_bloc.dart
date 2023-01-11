import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;

  LocationBloc() : super(LocationState()) {
    on<OnStartFollowingUser>(
      (event, emit) => emit(
        state.copyWith(
          isFollowingUser: true,
        ),
      ),
    );

    on<OnStopFollowingUser>(
      (event, emit) => emit(
        state.copyWith(
          isFollowingUser: false,
        ),
      ),
    );

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

  void startFollowingUser() {
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(OnStartFollowingUser());
      add(
        OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude),
        ),
      );
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add(OnStopFollowingUser());
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
