part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool isFollowingUser;
  final LatLng? lastKnownLocation;

  const LocationState({
    this.isFollowingUser = true,
    this.lastKnownLocation,
  });

  LocationState copyWith({
    bool? isFollowingUser,
    LatLng? lastKnownLocation,
  }) =>
      LocationState(
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      );

  @override
  List<Object?> get props => [
        isFollowingUser,
        lastKnownLocation,
      ];
}
