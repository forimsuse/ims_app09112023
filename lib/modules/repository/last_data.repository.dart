import '../../utils/local_storage.dart';
import '../models/charge_event.model.dart';
import '../models/record.model.dart';
import '../models/setting.model.dart';

class LastDataRepository {

  LastDataRepository(this._deviceId){
    localRecord = _localStorage.getRecord(_deviceId);
    localSetting = _localStorage.getSetting(_deviceId);
    localEndChanging =  _localStorage.getEndChanging(_deviceId);
  }

  final String _deviceId;

  final LocalStorage _localStorage = LocalStorage();

  late RecordModel?  localRecord;

  late SettingModel?  localSetting;

  late ChargeEventModel?  localEndChanging;

  String? chargingStatus(){
    return localSetting?.charge85 == true ? "Healthy" : localSetting?.charge85 == false ? "Full" : null;
  }

  String? voltageAtEndCharge(){
    return localEndChanging?.chargingData?.mainVoltage?.toStringAsFixed(1);
  }

  String? temperatureAtEndCharge(){
    return localEndChanging?.chargingData?.mainTemperature?.toStringAsFixed(1);
  }

  String? recordAlerts(){
    return localRecord?.getWarningMessage();
  }

}