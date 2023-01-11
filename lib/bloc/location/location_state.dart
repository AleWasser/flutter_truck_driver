part of 'location_bloc.dart';

class LocationState {
  final bool isFollowingUser;
  final LatLng? lastKnownLocation;

  LocationState({
    this.isFollowingUser = false,
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
}
