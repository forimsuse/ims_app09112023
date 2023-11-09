import 'package:flutter/material.dart';

import '../../modules/models/charging_data.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';

class TemperatureWidget extends StatelessWidget {
  final String title;
  final String? value;
  final bool isDangerous;
  final bool titleBold;

  const TemperatureWidget(
      {super.key,
        required this.title,
        required this.value,
        this.isDangerous = false,
        this.titleBold = true});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildBatteryTemperature();
  }

  _buildBatteryTemperature() {
    final TextStyle textStyleTitle = TextStyle(
      color: Colors.black,
      fontSize: 18 * SC.fontProportion,
      fontWeight: titleBold ? FontWeight.w700 : FontWeight.w400,
      height: 0,
    );
    final TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: 18 * SC.fontProportion,
      fontWeight: FontWeight.w400,
      height: 0,
    );
    var unit = ChargingData.degreeTypeC ? '\u2103' : '\u2109';
    return Container(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          ChargingData.degreeTypeC = ChargingData.degreeTypeC ? false : true;
        },
        child: Container(
          color: Colors.transparent,
          child: RichText(
              text: TextSpan(children: [
                TextSpan(text: title, style: textStyleTitle),
                TextSpan(
                  text: '${value ?? "--"} $unit',
                  style: TextStyle(
                    color: isDangerous ? Colors.red : AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ], style: textStyle)),
        ),
      ),
    );
  }
}
