import 'package:flutter/material.dart';
import 'package:ims_app/components/widgets/listTitle_wd.dart';
import 'package:ims_app/modules/bloc/device.bloc.dart';
import 'package:ims_app/utils/size_config.dart';

import '../../modules/models/charge_event.model.dart';
import '../../utils/app_colors.dart';
import 'temperature.widget.dart';

class BatteryDesc extends StatelessWidget {
  final ChargeEventModel? chargeEventModel;
  final DeviceBloc deviceBloc;



   const BatteryDesc(
      {super.key, required this.chargeEventModel, required this.deviceBloc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30*SC.screenWidthProportion,vertical: 10*SC.screenHeightProportion),
        color: AppColors.pink.withOpacity(0.1), child: _buildBattery());
  }

  Widget _buildTitle() {
    return Text(
      'Battery',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18 * SC.fontProportion,
        fontWeight: FontWeight.w400,
        height: 0,
      ),
    );
  }

  Widget _buildBattery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2*SC.screenHeightProportion,),
        _buildTitle(),
        SizedBox(height: 8*SC.screenHeightProportion,),
        ListItemWD().build("charging voltage", (chargeEventModel?.chargingData?.mainVoltage)?.toStringAsFixed(1),char: "V"),
        SizedBox(height: 2*SC.screenHeightProportion,),
        ListItemWD().build("battery voltage", (chargeEventModel?.chargingData?.batteryVoltage)?.toStringAsFixed(1),char: "V"),
        SizedBox(height: 2*SC.screenHeightProportion,),
        TemperatureWidget( title: "battery temperature : ", value: chargeEventModel?.chargingData?.getMaxTemperature()?.toStringAsFixed(1),isDangerous: chargeEventModel?.chargingData?.dangerousTemperature() == true,),
        SizedBox(height: 2*SC.screenHeightProportion,),
        ListItemWD().build("charging current", chargeEventModel?.mainCurrent?.toString(), char: "mA"),
      ],
    );
  }






}
