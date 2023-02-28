import 'package:flutter_truck_driver_app/bloc/bloc.dart';

class SearchDelegateHelper {
  final MapBloc mapBloc;
  final LocationBloc locationBloc;
  late dynamic result;

  SearchDelegateHelper({required this.mapBloc, required this.locationBloc});

  void handleSearchResult(dynamic result) {
    locationBloc.add(OnStopFollowingUser());
    mapBloc.add(OnMoveCameraToCoordinatesEvent(result.coordinates));
    mapBloc.createArea(result.area);
  }
}
