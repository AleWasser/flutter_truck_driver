part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnAddSearchResults extends SearchEvent {
  final List<GeoLocation> searchResults;

  const OnAddSearchResults(this.searchResults);
}

class OnAddPlaceToHistory extends SearchEvent {
  final GeoLocation geo;

  const OnAddPlaceToHistory(this.geo);
}
