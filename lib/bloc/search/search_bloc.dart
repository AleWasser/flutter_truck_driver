import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_truck_driver_app/models/geo_location_model.dart';
import 'package:flutter_truck_driver_app/repositories/geo_location_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GeoLocationRepository geoLocationRepository;

  SearchBloc({
    required this.geoLocationRepository,
  }) : super(const SearchState()) {
    on<OnAddSearchResults>((event, emit) {
      emit(state.copyWith(searchResults: event.searchResults));
    });
    on<OnAddPlaceToHistory>((event, emit) {
      emit(state.copyWith(history: [...state.history, event.geo]));
    });
  }

  void searchCities() {
    List<GeoLocation> cities = geoLocationRepository.getGeo();
    add(OnAddSearchResults(cities));
  }
}
