import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_truck_driver_app/adapters/adapters.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceStream;
  PermissionAdapter permissionAdapter;
  GeoLocatorAdapter geoLocatorAdapter;

  GpsBloc({
    required this.permissionAdapter,
    required this.geoLocatorAdapter,
  }) : super(const GpsState(
          isGpsEnabled: false,
          isGpsPermissionGranted: false,
        )) {
    on<GpsAndPermissionEvent>((event, emit) {
      emit(GpsState(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted,
      ));
    });

    init();
  }

  Future<void> init() async {
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    add(GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0],
      isGpsPermissionGranted: gpsInitStatus[1],
    ));
  }

  Future<bool> _isPermissionGranted() async {
    return await permissionAdapter.isPermissionGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnabled = await geoLocatorAdapter.isLocationServiceEnabled;

    gpsServiceStream = geoLocatorAdapter.serviceStatusStream.listen((event) {
      add(GpsAndPermissionEvent(
        isGpsEnabled: event.index == 1 ? true : false,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
      ));
    });

    return isEnabled;
  }

  Future<void> askGpsAccess() async {
    final status = await permissionAdapter.permissionStatus;

    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: true,
        ));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: false,
        ));
        openAppSettings();
    }
  }

  @override
  Future<void> close() {
    gpsServiceStream?.cancel();
    return super.close();
  }
}
