import 'package:flutter_truck_driver_app/models/geo_location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocationRepository {
  final List<GeoLocation> geoArray = [
    GeoLocation(
      id: 1,
      city: 'Chicago',
      state: 'IL',
      coordinates: const LatLng(41.881832, -87.623177),
    ),
    GeoLocation(
      id: 2,
      city: 'Denver',
      state: 'CO',
      coordinates: const LatLng(39.742043, -104.991531),
    ),
    GeoLocation(
      id: 3,
      city: 'New York',
      state: 'NY',
      coordinates: const LatLng(40.730610, -73.935242),
    ),
  ];

  List<GeoLocation> getGeo() {
    return geoArray;
  }
}
