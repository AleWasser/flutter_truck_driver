import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';

import 'package:flutter_truck_driver_app/bloc/map/map_bloc.dart';
import 'map_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GoogleMapController>()])
void main() {
  late GoogleMapController googleMapController;
  setUp(() {
    googleMapController = MockGoogleMapController();
  });
  group('Map Bloc', () {
    test('Map bloc has a default initial state', () {
      expect(MapBloc().state, const MapState());
    });

    blocTest(
      'OnMapIntialized event sets a isInitialized state to true',
      build: () => MapBloc(),
      act: (bloc) => bloc.add(OnMapInitializedEvent(googleMapController)),
      expect: () => [const MapState(isInitialized: true)],
    );
  });
}
