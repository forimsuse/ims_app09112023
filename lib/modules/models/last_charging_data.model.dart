import 'package:ims_app/modules/models/record.model.dart';
import 'charge_event.model.dart';

class LastChargingDataModel{
  ChargeEventModel? batteryDataStartCharging;
  ChargeEventModel? batteryDataEndCharging;
  double? chargeDuration;
  EnRecordType? recordType;

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> map = {};
    map["batteryDataStartCharging"] = batteryDataStartCharging?.toJson();
    map["batteryDataEndCharging"] = batteryDataEndCharging?.toJson();
    map["chargeDuration"] = chargeDuration;
    map["recordType"] = recordType?.index;
    return map;
  }

}
