import 'package:permission_handler/permission_handler.dart';

class PermissionAdapter {
  Future<bool> get isPermissionGranted async {
    return await Permission.location.isGranted;
  }

  Future<PermissionStatus> get permissionStatus async {
    return await Permission.location.request();
  }
}
