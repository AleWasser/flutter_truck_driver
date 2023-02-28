import 'package:flutter_truck_driver_app/models/load_data_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//* This repository has been created for testing purposes. All the data is fake.
class LoadRepository {
  final List<LoadData> loadsArray = [
    LoadData(
      id: 1,
      city: 'Chicago',
      state: 'IL',
      address: 'test address 123',
      geoLocationId: 1,
      cargo: 'Books',
      pickUp: DateTime.now(),
      dropOff: DateTime.now().add(const Duration(days: 1)),
      pickUpCoordinates: const LatLng(41.881832, -87.623177),
      dropOffCoordinates: const LatLng(41.881832, -87.623177),
    ),
    LoadData(
      id: 2,
      city: 'Chicago',
      state: 'IL',
      address: 'test address 123',
      geoLocationId: 1,
      cargo: 'Toys',
      pickUp: DateTime.now(),
      dropOff: DateTime.now().add(const Duration(days: 1)),
      pickUpCoordinates: const LatLng(41.881832, -87.623177),
      dropOffCoordinates: const LatLng(41.881832, -87.623177),
    ),
    LoadData(
      id: 3,
      city: 'Chicago',
      state: 'IL',
      address: 'test address 123',
      geoLocationId: 1,
      cargo: 'Bricks',
      pickUp: DateTime.now(),
      dropOff: DateTime.now().add(const Duration(days: 1)),
      pickUpCoordinates: const LatLng(41.881832, -87.623177),
      dropOffCoordinates: const LatLng(41.881832, -87.623177),
    ),
  ];

  List<LoadData> getLoads() {
    return loadsArray;
  }
}
