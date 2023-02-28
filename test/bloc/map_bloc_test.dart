import 'dart:ui' show Color;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_truck_driver_app/repositories/geo_location_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';

import 'package:flutter_truck_driver_app/bloc/map/map_bloc.dart';
import 'map_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GoogleMapController>()])
void main() {
  late GoogleMapController googleMapController;
  final geoLocationRepository = GeoLocationRepository();

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

    blocTest(
      'OnNewPolygonsEvent event sets a new polygons state',
      build: () => MapBloc(),
      act: (bloc) => bloc.add(const OnNewPolygonsEvent(
        {
          'origin': Polygon(
            polygonId: PolygonId("origin"),
          ),
        },
      )),
      expect: () => [
        const MapState(
          polygons: {
            'origin': Polygon(
              polygonId: PolygonId("origin"),
            ),
          },
        )
      ],
    );

    blocTest(
      'createArea function calls AddNewPolygons event',
      build: () => MapBloc(),
      act: (bloc) => bloc.createArea(
        geoLocationRepository
            .getGeo()
            .where((element) => element.city == 'Chicago')
            .first
            .area,
      ),
      expect: () => [
        MapState(
          polygons: {
            'origin': Polygon(
              polygonId: const PolygonId("origin"),
              fillColor: const Color(0xFF006491).withOpacity(0.1),
              strokeWidth: 2,
              points: geoLocationRepository
                  .getGeo()
                  .where((element) => element.city == 'Chicago')
                  .first
                  .area,
            )
          },
        )
      ],
    );
  });
}
