import 'dart:async';

import 'package:flutter/material.dart';

//import 'package:ims_app/components/battery/bettaryDesc.widget.dart';
import 'package:ims_app/components/battery/chargeDuration.widget.dart';
import 'package:ims_app/components/battery/chargingStatus.widget.dart';
import 'package:ims_app/components/battery/drawer.dart';
import 'package:ims_app/components/battery/monitoringMode.widget.dart';
import 'package:ims_app/components/battery/record.widget.dart';
import 'package:ims_app/components/battery/tagVersion.widget.dart';
import 'package:ims_app/components/widgets/appBar_wd.dart';
import 'package:ims_app/modules/models/charge_event.model.dart';
import 'package:ims_app/utils/logger.service.dart';
import 'package:ims_app/utils/root_navigation.dart';
import 'package:ims_app/utils/size_config.dart';
import '../modules/bloc/device.bloc.dart';
import '../modules/models/setting.model.dart';
import '../utils/app_colors.dart';
import '../components/widgets/indicators.dart';
import '../components/widgets/listTitle_wd.dart';
import '../components/battery/temperature.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.deviceId, required this.deviceBloc});

  final String deviceId;
  final DeviceBloc deviceBloc;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final myColor = AppColors.black;

  bool reconnect = false;
  String? msgError;

  StreamSubscription? streamDeviceIdConnect;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    streamDeviceIdConnect =
        widget.deviceBloc.deviceIdConnectedStream.listen((event) {}, onError: (ex, stack) {
          if (mounted) {
            RootNavigation.popToFirst();
          }
        });
    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (mounted) {
          LoggerService.log("HomePage resumed");
          setState(() {
            reconnect = true;
          });
          msgError = await widget.deviceBloc.connectToDevice(widget.deviceId, force: true);
          if (mounted) {
            setState(() {
              reconnect = false;
            });
          }
        }
        break;
      default:
        LoggerService.log("HomePage $state");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          widget.deviceBloc.stop();
          return true;
        },
        child: Scaffold(
          key: scaffoldKey,
          drawer: DrawerWD(
            deviceBloc: widget.deviceBloc,
          ),
          appBar: AppBarWD(
            leading: IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              padding: EdgeInsets.zero,
            ),
            titleWidget: _buildTagId(),
            title: '',
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: widget.deviceBloc.chargeEventModelStream,
                    builder: (context, AsyncSnapshot<ChargeEventModel?> snapshot) {
                      return ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                msgError == null
                                    ? const SizedBox()
                                    : Tooltip(
                                  message: msgError,
                                  child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.warning_rounded)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 4.0,
                                        top: 8.0,
                                        bottom: 8.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [_buildRoomTemperature(), _buildChargerVoltage()],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: MonitoringMode(deviceBloc: widget.deviceBloc),
                                    ),
                                  ],
                                ),
                                Indicators(
                                    chargeEventModel: snapshot.data, deviceBloc: widget.deviceBloc),
                                SizedBox(
                                  height: SC.screenHeight * 0.2,
                                  child: ChargingDuration(
                                    chargeEventModel: snapshot.data,
                                  ),
                                ),
                                SizedBox(
                                    height: SC.screenHeight * 0.1,
                                    child: ChargingStatus(deviceBloc: widget.deviceBloc)),
                                SizedBox(
                                  height: SC.screenHeight * 0.16,
                                  child: RecordWidget(
                                    deviceBloc: widget.deviceBloc,
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 10 * SC.screenWidthProportion),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                    TagVersion(deviceBloc: widget.deviceBloc)
                                  ]),
                                )
                                // ExpansionTile(
                                //   title: const Text('more data ..'),
                                //   shape: const Border(),
                                //   collapsedShape: const Border(),
                                //   children: [
                                //     LastDataWidget(deviceId: widget.deviceId)
                                //   ],
                                // ),
                              ]),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  _buildTagId() {
    return StreamBuilder(
        stream: widget.deviceBloc.settingStream,
        builder: (context, AsyncSnapshot<SettingModel?> snapshot) {
          return ListItemWD().build("Tag Id", snapshot.data?.tagId.toString(),
              boldContent: true);
        });
  }

  Widget _buildRoomTemperature() {
    return StreamBuilder(
        stream: widget.deviceBloc.chargeEventModelStream,
        builder: (context, AsyncSnapshot<ChargeEventModel?> snapshot) {
          return TemperatureWidget(
            title: "Room temperature: ",
            value: snapshot.data?.chargingData?.mainTemperature?.toStringAsFixed(1),
            isDangerous: false,
            titleBold: true,
          );
        });
  }

  Widget _buildChargerVoltage() {
    return StreamBuilder(
        stream: widget.deviceBloc.chargeEventModelStream,
        builder: (context, AsyncSnapshot<ChargeEventModel?> snapshot) {
          var charVoltage = snapshot.data?.chargingData?.mainVoltage?.toStringAsFixed(1) ?? '--';
          return Text(
            'Charger voltage: $charVoltage V',
            style: TextStyle(
              fontSize: 16 * SC.fontProportion,
              fontWeight: FontWeight.bold,
            ),
          );
        });
  }

  _buildTime() {
    return Text("RTC ${DateTime.now()}");
  }
}
