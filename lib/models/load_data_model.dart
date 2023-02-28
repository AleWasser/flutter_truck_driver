import 'package:google_maps_flutter/google_maps_flutter.dart';

class LoadData {
  int id;
  String city;
  String state;
  String address;
  int geoLocationId;
  String cargo;
  DateTime pickUp;
  DateTime dropOff;
  LatLng pickUpCoordinates;
  LatLng dropOffCoordinates;

  LoadData({
    required this.id,
    required this.city,
    required this.state,
    required this.address,
    required this.geoLocationId,
    required this.cargo,
    required this.pickUp,
    required this.dropOff,
    required this.pickUpCoordinates,
    required this.dropOffCoordinates,
  });
}
