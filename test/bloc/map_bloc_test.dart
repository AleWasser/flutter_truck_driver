import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';

import 'package:flutter_truck_driver_app/bloc/bloc.dart';
import 'map_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GoogleMapController>()])
void main() {
  late GoogleMapController googleMapController;
  setUp(() {
    googleMapController = MockGoogleMapController();
  });
  group('Map Bloc', () {
    test('Map bloc has a default initial state', () {
      expect(MapBloc(locationBloc: LocationBloc()).state, const MapState());
    });

    blocTest(
      'OnMapIntialized event sets a isInitialized state to true',
      build: () => MapBloc(locationBloc: LocationBloc()),
      act: (bloc) => bloc.add(OnMapInitializedEvent(googleMapController)),
      expect: () => [const MapState(isInitialized: true)],
    );

    blocTest(
      'OnCenterCameraOnUserEvent event sets a isFollowing user state to false if parameter is false',
      build: () => MapBloc(locationBloc: LocationBloc()),
      act: (bloc) => bloc.add(const OnCenterCameraOnUserEvent(false)),
      expect: () => [const MapState(isFollowingUser: false)],
    );

    blocTest(
      'OnCenterCameraOnUserEvent event sets a isFollowing user state to true if parameter is true',
      build: () => MapBloc(locationBloc: LocationBloc()),
      seed: () => const MapState(isFollowingUser: false),
      act: (bloc) => bloc.add(const OnCenterCameraOnUserEvent(true)),
      expect: () => [const MapState(isFollowingUser: true)],
    );

    blocTest(
      'OnCenterCameraOnUserEvent event does nothing if the parameter is the same as the state',
      build: () => MapBloc(locationBloc: LocationBloc()),
      seed: () => const MapState(isFollowingUser: true),
      act: (bloc) => bloc.add(const OnCenterCameraOnUserEvent(true)),
      expect: () => [],
    );
  });
}
