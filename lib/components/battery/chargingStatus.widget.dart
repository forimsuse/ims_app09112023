import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ims_app/components/widgets/lite_rolling_switch.dart';
import 'package:ims_app/modules/bloc/device.bloc.dart';
import 'package:ims_app/utils/size_config.dart';
import '../../utils/logger.service.dart';
import '../widgets/listTitle_wd.dart';

class ChargingStatus extends StatefulWidget {
  final DeviceBloc deviceBloc;

  const ChargingStatus({super.key, required this.deviceBloc});

  @override
  State<ChargingStatus> createState() => _ChargingStatusState();
}

class _ChargingStatusState extends State<ChargingStatus> {
  final GlobalKey<RollingSwitchState> globalKeyRollingSwitchState = GlobalKey<RollingSwitchState>();
  late StreamSubscription streamSubscription;
  bool? charge85;
  @override
  void initState() {
    streamSubscription = widget.deviceBloc.settingStream.listen((event) {
      charge85 = event?.charge85;
      if(mounted){
      globalKeyRollingSwitchState.currentState?.changeTurnState(charge85 == true);
      setState(() {
      });}
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return _buildChargingStatus();
  }

  _buildChargingStatus() {
    return Container(
        padding:
            EdgeInsetsDirectional.only(start: 30 * SC.screenWidthProportion),
        color: const Color(0xFFF2F2F2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListItemWD().build("Charging status",
                charge85 == true ? "Healthy" : "Full"),
            Expanded(
                child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        end: 20 * SC.screenWidthProportion),
                    child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: charge85 == null
                            ? const SizedBox()
                            : LiteRollingSwitch(
                          key: globalKeyRollingSwitchState,
                                //initial value
                                value: charge85 == true,
                                textOn: '',
                                textOff: '',
                                colorOn: const Color(0xff81C783),//Colors.greenAccent[700]!.withOpacity(0.75),
                                colorOff: Colors.grey.withOpacity(0.7),
                                iconOn: Icons.check,
                                iconOff: null,
                                textSize: 14.0,
                                onChanged: (bool state) {
                                  //Use it to manage the different states
                                  widget.deviceBloc.setSettings(state);
                                  LoggerService.log(
                                      'Current State of SWITCH IS: $state');
                                },
                                onTap: () {},
                                onDoubleTap: () {},
                                onSwipe: () {},
                                width: 70,
                              )))),
          ],
        ));
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
}
