import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocation {
  int id;
  String city;
  String state;
  LatLng coordinates;

  GeoLocation({
    required this.id,
    required this.city,
    required this.state,
    required this.coordinates,
  });
}
