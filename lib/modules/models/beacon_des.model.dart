
class DeviceDesc{

  DeviceDesc( this.deviceId, this.name);
  // double? txPower;
  // int rssi;
  String deviceId;
  String name;

  // double? getDistance() {
  //   if (txPower == null) {
  //     return txPower;
  //   } else {
  //     return (pow(10, ((txPower! -rssi)/(10 * 2)))).toDouble();
  //   }
  // }

}