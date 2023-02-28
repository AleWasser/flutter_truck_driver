part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isInitialized;
  final bool isFollowingUser;
  final Map<String, Polygon> polygons;
  final Map<String, Marker>? markers;

  const MapState({
    this.isInitialized = false,
    this.isFollowingUser = true,
    Map<String, Polygon>? polygons,
    this.markers,
  }) : polygons = polygons ?? const {};

  MapState copyWith({
    bool? isInitialized,
    bool? isFollowingUser,
    Map<String, Polygon>? polygons,
    Map<String, Marker>? markers,
  }) =>
      MapState(
        isInitialized: isInitialized ?? this.isInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        polygons: polygons ?? this.polygons,
        markers: markers ?? this.markers,
      );

  @override
  List<Object?> get props => [
        isInitialized,
        isFollowingUser,
        polygons,
        markers,
      ];
}
