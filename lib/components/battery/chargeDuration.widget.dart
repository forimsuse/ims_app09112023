import 'package:flutter/material.dart';
import 'package:ims_app/modules/models/charge_event.model.dart';
import 'package:ims_app/utils/size_config.dart';

class ChargingDuration extends StatelessWidget{

  final ChargeEventModel? chargeEventModel;

  const ChargingDuration({super.key,required this.chargeEventModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildChargeDuration(
        chargeEventModel?.chargeDuration);
  }

  _buildChargeDuration(String? duration) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         Text(
          'Charge duration',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18*SC.fontProportion,
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        Text(
          duration ?? "-- : --",
          style: TextStyle(
            color: Colors.black,
            fontSize: 52*SC.fontProportion,
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        )
      ],
    );
  }
}