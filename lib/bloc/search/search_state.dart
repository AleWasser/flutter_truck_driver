part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<GeoLocation> searchResults;
  final List<GeoLocation> history;

  const SearchState({this.searchResults = const [], this.history = const []});

  SearchState copyWith({
    List<GeoLocation>? searchResults,
    List<GeoLocation>? history,
  }) =>
      SearchState(
        searchResults: searchResults ?? this.searchResults,
        history: history ?? this.history,
      );

  @override
  List<Object> get props => [searchResults, history];
}
