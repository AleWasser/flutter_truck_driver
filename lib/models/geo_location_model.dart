import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocation {
  int id;
  String city;
  String state;
  LatLng coordinates;
  List<LatLng> area = const [
    LatLng(41.9950866, -87.6570173),
    LatLng(41.9940660, -87.8548629),
    LatLng(41.6625169, -87.8548629),
    LatLng(41.6625169, -87.5306160),
    LatLng(41.8333306, -87.6045676),
    LatLng(41.9910040, -87.6542695),
  ];

  GeoLocation({
    required this.id,
    required this.city,
    required this.state,
    required this.coordinates,
  });
}
