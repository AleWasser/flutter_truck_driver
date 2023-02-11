import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test/test.dart';

import 'gps_bloc_test.mocks.dart';
import 'package:flutter_truck_driver_app/bloc/gps/gps_bloc.dart';
import 'package:flutter_truck_driver_app/services/services.dart';

@GenerateNiceMocks([
  MockSpec<GeoLocatorService>(),
  MockSpec<GpsBloc>(),
  MockSpec<PermissionService>(),
])
void main() {
  group('GpsBloc', () {
    late GeoLocatorService geoLocatorService;
    late GpsBloc gpsBloc;
    late PermissionService permissionService;

    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      geoLocatorService = MockGeoLocatorService();
      gpsBloc = MockGpsBloc();
      permissionService = MockPermissionService();

      when(gpsBloc.state).thenReturn(
        const GpsState(
          isGpsEnabled: false,
          isGpsPermissionGranted: false,
        ),
      );
    });

    test('Gps bloc initial state is false', () {
      expect(gpsBloc.state.isGpsEnabled, false);
      expect(gpsBloc.state.isGpsPermissionGranted, false);
    });

    blocTest(
      'Emits true states when the permissions are granted',
      setUp: () {
        when(permissionService.isPermissionGranted)
            .thenAnswer((_) async => true);
        when(geoLocatorService.isLocationServiceEnabled)
            .thenAnswer((_) async => true);
      },
      build: () => GpsBloc(
        permissionService: permissionService,
        geoLocatorService: geoLocatorService,
      ),
      act: (bloc) => bloc.add(
        const GpsAndPermissionEvent(
          isGpsEnabled: true,
          isGpsPermissionGranted: true,
        ),
      ),
      expect: () => [
        const GpsState(isGpsEnabled: true, isGpsPermissionGranted: true),
      ],
    );

    blocTest(
      'Emits false states when the permissions are not granted',
      setUp: () {
        when(permissionService.isPermissionGranted)
            .thenAnswer((_) async => false);
        when(geoLocatorService.isLocationServiceEnabled)
            .thenAnswer((_) async => false);
      },
      build: () => GpsBloc(
        permissionService: permissionService,
        geoLocatorService: geoLocatorService,
      ),
      act: (bloc) => bloc.add(
        const GpsAndPermissionEvent(
          isGpsEnabled: false,
          isGpsPermissionGranted: false,
        ),
      ),
      expect: () => [
        const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false),
      ],
    );

    blocTest(
      'askGpsAccess returns isGpsPermissionGranted true if access is granted',
      setUp: () {
        when(permissionService.isPermissionGranted)
            .thenAnswer((_) async => false);
        when(geoLocatorService.isLocationServiceEnabled)
            .thenAnswer((_) async => true);
        when(permissionService.permissionStatus)
            .thenAnswer((_) async => PermissionStatus.granted);
      },
      build: () => GpsBloc(
        permissionService: permissionService,
        geoLocatorService: geoLocatorService,
      ),
      act: (bloc) async {
        await bloc.init();
        await bloc.askGpsAccess();
      },
      expect: () => [
        const GpsState(isGpsEnabled: true, isGpsPermissionGranted: false),
        const GpsState(isGpsEnabled: true, isGpsPermissionGranted: true),
      ],
    );

    blocTest(
      'askGpsAccess returns isGpsPermissionGranted false if access is not granted',
      setUp: () {
        when(permissionService.isPermissionGranted)
            .thenAnswer((_) async => false);
        when(geoLocatorService.isLocationServiceEnabled)
            .thenAnswer((_) async => true);
        when(permissionService.permissionStatus)
            .thenAnswer((_) async => PermissionStatus.denied);
      },
      build: () => GpsBloc(
        permissionService: permissionService,
        geoLocatorService: geoLocatorService,
      ),
      act: (bloc) async {
        await bloc.init();
        await bloc.askGpsAccess();
      },
      expect: () => [
        const GpsState(isGpsEnabled: true, isGpsPermissionGranted: false),
      ],
    );
  });
}
