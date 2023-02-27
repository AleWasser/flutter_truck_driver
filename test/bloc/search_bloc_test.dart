import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_truck_driver_app/bloc/search/search_bloc.dart';
import 'package:flutter_truck_driver_app/repositories/geo_location_repository.dart';

void main() {
  final geoLocationRepository = GeoLocationRepository();
  final geoCities = geoLocationRepository.getGeo();

  group('Search Bloc', () {
    test('Search bloc has a default initial state', () {
      expect(
        SearchBloc(geoLocationRepository: geoLocationRepository).state,
        const SearchState(),
      );
    });

    blocTest(
      'OnAddSearchResults event adds a new array of GeoLocation to state',
      build: () => SearchBloc(geoLocationRepository: geoLocationRepository),
      act: (bloc) => bloc.add(OnAddSearchResults([...geoCities])),
      expect: () => [
        SearchState(searchResults: [...geoCities])
      ],
    );

    blocTest(
      'OnAddPlaceToHistory event adds a new GeoLocation to history state',
      build: () => SearchBloc(geoLocationRepository: geoLocationRepository),
      act: (bloc) => bloc.add(OnAddPlaceToHistory(geoCities.first)),
      expect: () => [
        SearchState(history: [
          geoCities.first,
        ])
      ],
    );

    blocTest(
      'searchCities method updates searchResults state',
      build: () => SearchBloc(geoLocationRepository: geoLocationRepository),
      act: (bloc) => bloc.searchCities(),
      expect: () => [
        SearchState(searchResults: [...geoCities])
      ],
    );
  });
}
