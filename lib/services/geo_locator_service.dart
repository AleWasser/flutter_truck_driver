import 'package:geolocator/geolocator.dart' show Geolocator, ServiceStatus;

class GeoLocatorService {
  Future<bool> get isLocationServiceEnabled async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Stream<ServiceStatus> get serviceStatusStream {
    return Geolocator.getServiceStatusStream();
  }
}
