import 'dart:async';
import 'dart:ui';

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
    on<OnNewPolygonsEvent>(
      (event, emit) => emit(
        state.copyWith(polygons: event.polygons),
      ),
    );
  }

  void moveCamera(LatLng coordinates) {
    final cameraUpdate = CameraUpdate.newLatLngZoom(coordinates, 10);
    _mapController?.animateCamera(cameraUpdate);
  }

  void createArea(List<LatLng> coordinates) {
    final originArea = Polygon(
      polygonId: const PolygonId("origin"),
      fillColor: const Color(0xFF006491).withOpacity(0.1),
      strokeWidth: 2,
      points: coordinates,
    );

    final polygons = Map<String, Polygon>.from(state.polygons);
    polygons["origin"] = originArea;

    add(OnNewPolygonsEvent(polygons));
  }
}
