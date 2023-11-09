import 'package:ims_app/modules/repository/last_data.repository.dart';


class LastDataBloc {
  LastDataBloc(String deviceID) {
    _repository = LastDataRepository(deviceID);
  }

  late LastDataRepository _repository;

  String? get chargingStatus => _repository.chargingStatus();
  String? get voltageAtEndCharge => _repository.voltageAtEndCharge();
  String? get temperatureAtEndCharge => _repository.temperatureAtEndCharge();
  String? get recordAlerts => _repository.recordAlerts();
}
