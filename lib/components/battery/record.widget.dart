import 'package:flutter/material.dart';
import 'package:ims_app/components/widgets/circle_btn.dart';
import 'package:ims_app/modules/models/record.model.dart';
import 'package:ims_app/utils/size_config.dart';

import '../../modules/bloc/device.bloc.dart';

class RecordWidget extends StatelessWidget {
  const RecordWidget({super.key, required this.deviceBloc});
  final DeviceBloc deviceBloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _buildBellAndMsg(),
        ),
        PositionedDirectional(
          child: _buildGetRecord(),
          end: 10 * SC.screenWidthProportion,
          top: 10 * SC.screenWidthProportion,
        )
      ],
    );
  }

  _buildBellAndMsg() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildBell(),
        _buildAlerts(),
      ],
    );
  }

  _buildBell() {
    return Image.asset("assets/images/bell_icon.png");
  }

  _buildGetRecord() {
    return CircleBtn(
        imgAssets: "assets/images/refresh_icon.png",
        voidCallback: () {
          deviceBloc.getRecord();
        });
  }

  _buildAlerts() {
    return StreamBuilder(
        stream: deviceBloc.errorTypeTempStream,
        builder: (context, AsyncSnapshot<EnErrorTypeTemp> snapshot) {
          return /*snapshot.data?.recordType?.index == 0 ||
                  snapshot.data?.recordType?.index == null
              ? const SizedBox()
              :*/
              Column(
            children: [
              Text(
                _getDesc(snapshot.data),
                style: const TextStyle(
                  color: Color(0xFFD90000),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                textAlign: TextAlign.center,
              ),
              // _getData(snapshot.data!),
            ],
          );
        });
  }

  _getData(RecordModel recordModel) {
    return Text(
        "Temperature: ${recordModel.batteryMaxTemperature?.toStringAsFixed(1) ?? "--"}c\nVoltage: ${recordModel.chargingData.batteryVoltage?.toStringAsFixed(1) ?? "--"}\nCharger voltage: ${recordModel.chargingData.mainVoltage?.toStringAsFixed(1) ?? "--"}");
  }

  String _getDesc(EnErrorTypeTemp? errorTypeTemp) {
    switch (errorTypeTemp) {
      case EnErrorTypeTemp.noError:
        return "No error.";
      case EnErrorTypeTemp.overTemperatureWithAlert:
        return "Over temperature with alert.";
      case EnErrorTypeTemp
            .chargeTemperatureIsOverMaximumChargeTemperatureFor3TimesWithinAnHour:
        return "Charge temperature is over maximum charge temperature for 3 times within an hour.";
      case EnErrorTypeTemp.theChargeIsTooLong:
        return "The charge is too long.";
      case EnErrorTypeTemp.theChargeIsTooFast:
        return "The charge is too fast.";
      case EnErrorTypeTemp.batteryVoltageDropsAfterCharge:
        return "Battery voltage drops after charge.";
      case EnErrorTypeTemp.selfTestChargerVoltageIsTooLow:
        return "Self-test, charger voltage is too low.";
      case EnErrorTypeTemp.selfTestChargerVoltageIsTooHigh:
        return "Self-test, charger voltage is too high.";
      case EnErrorTypeTemp.selfTestZeroCurrentIsTooHigh:
        return "Self-test, zero current is too high.";
      case EnErrorTypeTemp.selfTestDeviceTemperatureIsTooLow:
        return "Self-test, device temperature is too low.";
      case EnErrorTypeTemp.selfTestDeviceTemperatureIsTooHigh:
        return "Self-test, device temperature is too high.";
      case EnErrorTypeTemp.selfTestNotDoneStillRunningSelfTest:
        return "Self-test, not done (still running self test)";
      default:
        return "";
    }
  }
}
