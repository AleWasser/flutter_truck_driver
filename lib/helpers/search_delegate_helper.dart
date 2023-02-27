import 'package:flutter_truck_driver_app/bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchDelegateHelper {
  final MapBloc mapBloc;
  final LocationBloc locationBloc;
  late dynamic result;

  SearchDelegateHelper({required this.mapBloc, required this.locationBloc});

  void handleCitySearchResult(LatLng coordinates) {
    locationBloc.add(OnStopFollowingUser());
    mapBloc.add(OnMoveCameraToCoordinatesEvent(coordinates));
  }
}
