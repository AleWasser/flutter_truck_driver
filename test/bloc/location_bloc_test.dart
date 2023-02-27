import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_truck_driver_app/bloc/bloc.dart';

void main() {
  final lat = Random().nextDouble() * 90;
  final lng = Random().nextDouble() * 180;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  group('Location bloc', () {
    test('initial state is empty', () {
      expect(LocationBloc(mapBloc: MapBloc()).state, const LocationState());
    });

    blocTest(
      'Start following user event changes the isFollowinguser state',
      build: () => LocationBloc(mapBloc: MapBloc()),
      act: (bloc) => bloc.add(OnStartFollowingUser()),
      expect: () => [const LocationState(isFollowingUser: true)],
    );

    blocTest(
      'Stop following user event changes the isFollowinguser state',
      build: () => LocationBloc(mapBloc: MapBloc()),
      act: (bloc) => bloc.add(OnStopFollowingUser()),
      expect: () => [const LocationState(isFollowingUser: false)],
    );

    blocTest(
      'NewUserLocationEvent event changes the lastKnownLocation state',
      build: () => LocationBloc(mapBloc: MapBloc()),
      act: (bloc) => bloc.add(OnNewUserLocationEvent(LatLng(lat, lng))),
      expect: () => [LocationState(lastKnownLocation: LatLng(lat, lng))],
    );
  });
}
