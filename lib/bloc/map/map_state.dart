part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isInitialized;
  final bool isFollowingUser;
  final Map<String, Polyline>? polylines;
  final Map<String, Marker>? markers;

  const MapState({
    this.isInitialized = false,
    this.isFollowingUser = true,
    this.polylines,
    this.markers,
  });

  MapState copyWith({
    bool? isInitialized,
    bool? isFollowingUser,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) =>
      MapState(
        isInitialized: isInitialized ?? this.isInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
      );

  @override
  List<Object?> get props => [
        isInitialized,
        isFollowingUser,
        polylines,
        markers,
      ];
}
