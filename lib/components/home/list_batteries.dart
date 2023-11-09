import 'package:flutter/material.dart';
import 'package:ims_app/components/home/list_item_battery_noCommuication.dart';
import 'package:ims_app/components/widgets/location_error_message.dart';
import 'package:ims_app/modules/models/beacon_des.model.dart';
import 'package:ims_app/utils/logger.service.dart';
import '../../modules/bloc/device.bloc.dart';
import '../../modules/bloc/list_devices.bloc.dart';
import '../../modules/repository/permission_service.repository.dart';
import '../../utils/local_storage.dart';
import 'list_item_battery.dart';

class ListBatteries extends StatefulWidget {
  final PermissionServiceRepository permissionServiceRepository;
  const ListBatteries({super.key, required this.permissionServiceRepository});

  @override
  State<ListBatteries> createState() => _ListBatteriesState();
}

class _ListBatteriesState extends State<ListBatteries>
    with WidgetsBindingObserver {
  final ListDevicesBloc listDevicesBloc = ListDevicesBloc();
  final DeviceBloc deviceBloc = DeviceBloc();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  String? msgFromTryScan = "";
  bool forceReconnect = false;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        LoggerService.log("ListBatteries resumed");
        if (mounted) {
          forceReconnect = true;
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    LocalStorage().init().then((v) {
      listDevicesBloc.startToListenToDevicesScan();
    });
    refresh();
    deviceBloc.startListenToDeviceConnect();
    // listenToStateScanning();
    super.initState();
  }

  refresh() async {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState?.show());
  }

  _fetchDevices() async {
    if (mounted) {
      setState(() {});
    }
    listDevicesBloc.clearDevices();
    msgFromTryScan = await listDevicesBloc.fetchDevices();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () => _fetchDevices(),
        child: StreamBuilder(
            stream: deviceBloc.deviceIdConnectedStream,
            builder: (context, AsyncSnapshot<String?> snapshotDeviceConnected) {
              return Column(
                children: [
                  const SizedBox(height: 10,),
                  Expanded(
                    child: StreamBuilder(
                        stream: listDevicesBloc.streamDeviceDescList,
                        builder: (context,
                            AsyncSnapshot<List<DeviceDesc>> snapshot) {
                          final keysDevicesWithoutCommunication =
                              listDevicesBloc.devicesWithoutCommunication?.keys
                                      .toList() ??
                                  [];
                          final lengthDeviceDescList =
                              (snapshot.data?.length ?? 0);
                          return Column(
                            children: [
                              msgFromTryScan != null
                                  ? Text(msgFromTryScan!)
                                  : const SizedBox(),
                              snapshot.error != null
                                  ? Text(snapshot.error.toString())
                                  : const SizedBox(),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    if (index < lengthDeviceDescList) {}
                                    return index < lengthDeviceDescList
                                        ? ListItemBattery(
                                            beaconDesc: snapshot.data![index],
                                            deviceBloc: deviceBloc,
                                            deviceId:
                                                snapshot.data![index].deviceId,
                                            isConnected: snapshotDeviceConnected
                                                    .data ==
                                                snapshot.data![index].deviceId,
                                            forceToConnect: forceReconnect,
                                            finishToConnect: () {
                                              forceReconnect = false;
                                            },
                                          )
                                        : ListItemBatteryNoCommunication(
                                            deviceId:
                                                keysDevicesWithoutCommunication[
                                                    index -
                                                        lengthDeviceDescList],
                                            name: listDevicesBloc
                                                    .devicesWithoutCommunication?[
                                                keysDevicesWithoutCommunication[
                                                    index -
                                                        lengthDeviceDescList]],
                                          );
                                  },
                                  itemCount: lengthDeviceDescList +
                                      keysDevicesWithoutCommunication.length,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  FutureBuilder(
                      future: widget.permissionServiceRepository
                          .checkStateLocation(),
                      builder: (context, AsyncSnapshot<String?> snapshot) {
                        return LocationErrorMessage(
                            visible: snapshot.data == null ? false : true);
                      }),
                ],
              );
            }));
  }

  @override
  void dispose() {
    deviceBloc.dispose();
    listDevicesBloc.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
