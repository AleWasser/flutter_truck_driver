import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test/test.dart';

import 'gps_bloc_test.mocks.dart';
import 'package:flutter_truck_driver_app/bloc/gps/gps_bloc.dart';
import 'package:flutter_truck_driver_app/adapters/adapters.dart';

@GenerateNiceMocks([
  MockSpec<GeoLocatorAdapter>(),
  MockSpec<GpsBloc>(),
  MockSpec<PermissionAdapter>(),
])
void main() {
  group('GpsBloc', () {
    late GeoLocatorAdapter geoLocatorAdapter;
    late GpsBloc gpsBloc;
    late PermissionAdapter permissionAdapter;

    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      geoLocatorAdapter = MockGeoLocatorAdapter();
      gpsBloc = MockGpsBloc();
      permissionAdapter = MockPermissionAdapter();

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
        when(permissionAdapter.isPermissionGranted)
            .thenAnswer((_) async => true);
        when(geoLocatorAdapter.isLocationServiceEnabled)
            .thenAnswer((_) async => true);
      },
      build: () => GpsBloc(
        permissionAdapter: permissionAdapter,
        geoLocatorAdapter: geoLocatorAdapter,
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
        when(permissionAdapter.isPermissionGranted)
            .thenAnswer((_) async => false);
        when(geoLocatorAdapter.isLocationServiceEnabled)
            .thenAnswer((_) async => false);
      },
      build: () => GpsBloc(
        permissionAdapter: permissionAdapter,
        geoLocatorAdapter: geoLocatorAdapter,
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
        when(permissionAdapter.isPermissionGranted)
            .thenAnswer((_) async => false);
        when(geoLocatorAdapter.isLocationServiceEnabled)
            .thenAnswer((_) async => true);
        when(permissionAdapter.permissionStatus)
            .thenAnswer((_) async => PermissionStatus.granted);
      },
      build: () => GpsBloc(
        permissionAdapter: permissionAdapter,
        geoLocatorAdapter: geoLocatorAdapter,
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
        when(permissionAdapter.isPermissionGranted)
            .thenAnswer((_) async => false);
        when(geoLocatorAdapter.isLocationServiceEnabled)
            .thenAnswer((_) async => true);
        when(permissionAdapter.permissionStatus)
            .thenAnswer((_) async => PermissionStatus.denied);
      },
      build: () => GpsBloc(
        permissionAdapter: permissionAdapter,
        geoLocatorAdapter: geoLocatorAdapter,
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
