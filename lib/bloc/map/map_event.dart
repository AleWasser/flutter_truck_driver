part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  OnMapInitializedEvent(this.controller);
}

class OnCenterCameraOnUserEvent extends MapEvent {
  final bool isFollowingUser;

  OnCenterCameraOnUserEvent(this.isFollowingUser);
}
