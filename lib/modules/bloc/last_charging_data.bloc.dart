import 'package:rxdart/rxdart.dart';
import 'package:ims_app/modules/models/last_charging_data.model.dart';

class LastChargingDataBloc{

  final BehaviorSubject<LastChargingDataModel> _lastChargingData =
  BehaviorSubject<LastChargingDataModel>();

  ValueStream<LastChargingDataModel> get lastChargingDataStream => _lastChargingData.stream;

  fetchLastCharging(){
  }
}