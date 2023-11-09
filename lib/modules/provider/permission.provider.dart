import 'package:permission_handler/permission_handler.dart';

class PermissionProvider {
  // final loc.Location _location = loc.Location();
  static Future<void> request() async {
    await [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request();
  }

  Future<String?> checkServiceStatusLocation(
      /*, PermissionWithService permission*/) async {
    final status = await Permission.location.serviceStatus;
    return status == ServiceStatus.disabled
        ? "To use IMSapp, turn on device location"
        : status == ServiceStatus.notApplicable
            ? "Not have a location service on the current platform."
            : null;
  }


}
