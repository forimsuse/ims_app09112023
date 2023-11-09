import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:ims_app/modules/bloc/device.bloc.dart';
import 'package:ims_app/modules/models/charging_data.dart';
import 'package:ims_app/utils/size_config.dart';
import '../../modules/models/charge_event.model.dart';
import '../../utils/app_colors.dart';

class Indicators extends StatefulWidget {
  final ChargeEventModel? chargeEventModel;
  final DeviceBloc deviceBloc;

  const Indicators({super.key, required this.chargeEventModel, required this.deviceBloc});

  @override
  State<Indicators> createState() => _IndicatorsState();
}

class _IndicatorsState extends State<Indicators> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * SC.screenWidthProportion,
          vertical: 10 * SC.screenHeightProportion,
        ),
        color: AppColors.purple.withOpacity(0.3),
        child: _buildIndicators(),
      ),
    );
  }

  Widget _buildIndicators() {
    double tempValue = widget.chargeEventModel?.chargingData?.getMaxTemperature() ?? -999.0;
    double batVoltage = widget.chargeEventModel?.chargingData?.batteryVoltage ?? 0.0;
    double charVoltage = widget.chargeEventModel?.chargingData?.mainVoltage ?? 999.0;
    String tempValueDisp = (tempValue == -999.0) ? '--' : tempValue.toStringAsFixed(1);
    String batVoltageDisp = (batVoltage == 0.0) ? '--' : batVoltage.toStringAsFixed(1);
    bool degreeTypeC = ChargingData.degreeTypeC;
    bool dangerousTemp = degreeTypeC ? (tempValue >= 45.0 ? true : false) : (tempValue >= 113.0 ? true : false);
    var bgColor = dangerousTemp ? Colors.red.shade200 : Colors.transparent;
    var tempColor = dangerousTemp ? Colors.red.shade500 : Colors.green;
    var unit = degreeTypeC ? '\u2103' : '\u2109';
    double maxTemp = degreeTypeC ? 100.0 : 200.0;

    return ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 0.93,
        child: Column(
          children: [
            /*  Temp gauge:   */
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.7,
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  animationDuration: 2500,
                  axes: [
                    RadialAxis(
                      axisLineStyle: AxisLineStyle(
                        thickness: 7.0,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                      radiusFactor: 0.52,
                      showLastLabel: true,
                      maximum: maxTemp,
                      majorTickStyle: MajorTickStyle(
                        thickness: 4.0,
                      ),
                      labelOffset: 13.0,
                      ranges: [
                        GaugeRange(
                          startValue: 0.0,
                          endValue: tempValue,
                          startWidth: 0.07,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.07,
                          color: tempColor,
                        ),
                      ], //ranges
                      pointers: [
                        NeedlePointer(
                          needleLength: 0.5,
                          value: tempValue,
                          needleEndWidth: 5,
                          knobStyle: KnobStyle(
                            knobRadius: 0.06,
                          ),
                        ),
                      ], //pointers
                      annotations: [
                        GaugeAnnotation(
                          axisValue: maxTemp / 2,
                          verticalAlignment: GaugeAlignment.far,
                          positionFactor: 1.1,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.thermostat,
                                size: 40,
                                color: tempColor,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                color: bgColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                  child: Text(
                                    'Battery temperature: $tempValueDisp $unit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18 * SC.fontProportion,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ], //roBabies
                          ),
                        ),
                      ], //annotations
                    ),
                  ], //axesBabies
                ),
              ),
            ),
            /*  Voltages gauge:   */
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.7,
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  animationDuration: 2500,
                  axes: [
                    RadialAxis(
                      axisLineStyle: AxisLineStyle(
                        thickness: 7.0,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                      radiusFactor: 0.52,
                      showLastLabel: false,
                      maximum: charVoltage,
                      majorTickStyle: MajorTickStyle(
                        thickness: 4.0,
                      ),
                      labelOffset: 13.0,
                      ranges: [
                        GaugeRange(
                          startValue: 0.0,
                          endValue: batVoltage,
                          startWidth: 0.07,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.07,
                          color: Colors.green,
                        ),
                      ], //ranges
                      pointers: [
                        NeedlePointer(
                          needleLength: 0.5,
                          value: batVoltage,
                          needleEndWidth: 5,
                          knobStyle: KnobStyle(
                            knobRadius: 0.06,
                          ),
                        ),
                      ], //pointers
                      annotations: [
                        GaugeAnnotation(
                          axisValue: charVoltage / 2,
                          verticalAlignment: GaugeAlignment.far,
                          positionFactor: 1.2,
                          widget: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                'Battery voltage: $batVoltageDisp V',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18 * SC.fontProportion,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ], //annotations
                    ),
                  ], //axesBabies
                ),
              ),
            ),
          ], //coBabies
        ),
      ),
    );
  }
}