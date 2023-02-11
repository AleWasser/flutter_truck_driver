part of 'map_bloc.dart';

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitializedEvent(this.controller);
}

class OnCenterCameraOnUserEvent extends MapEvent {
  final bool isFollowingUser;

  const OnCenterCameraOnUserEvent(this.isFollowingUser);
}
