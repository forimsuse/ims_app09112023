import 'package:flutter/material.dart';
import 'package:ims_app/components/widgets/battery_frame.dart';
import 'package:ims_app/modules/models/beacon_des.model.dart';
import 'package:ims_app/utils/logger.service.dart';
import 'package:ims_app/utils/root_navigation.dart';
import 'package:ims_app/utils/size_config.dart';
import '../../modules/bloc/device.bloc.dart';

class ListItemBattery extends StatefulWidget {
  final DeviceDesc beaconDesc;
  final String deviceId;
  final bool isConnected;
  final bool forceToConnect;
  final Function finishToConnect;
  // final BluetoothDevice bluetoothDevice;
  const ListItemBattery(
      {super.key,
      required this.beaconDesc,
      required this.deviceBloc,
      required this.deviceId,
      this.isConnected = false,
      required this.forceToConnect,
      required this.finishToConnect});
  final DeviceBloc deviceBloc;

  @override
  State<ListItemBattery> createState() => _ListItemBatteryState();
}

class _ListItemBatteryState extends State<ListItemBattery> {
  bool isConnecting = false;
  String? msg;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BatteryFrame(
            child: ListTile(
          title: Text(
            widget.beaconDesc.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18 * SC.fontProportion,
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          subtitle: isConnecting
              ?  Text(
                  "Connecting...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16 * SC.fontProportion,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                )
              : msg != null
                  ? Tooltip(
                      message: msg,
                      child:  Text(
                        "No device found\n$msg",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16 * SC.fontProportion,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    )
                  : Text(
                      (widget.isConnected
                          ? "connected"
                          : widget.beaconDesc.deviceId),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16 * SC.fontProportion,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
          onTap: () async {
            isConnecting = true;
            if (mounted) {
              setState(() {});
            }
            //await BleProvider().connectToMyDevice(widget.beaconDesc.deviceId);
            msg = await widget.deviceBloc
                .connectToDevice(widget.deviceId, force: widget.forceToConnect);
            widget.finishToConnect();
            isConnecting = false;
            if (mounted) {
              setState(() {});
            }
            if (msg == null) {
              RootNavigation.push('/home', arguments: {
                "deviceId": widget.beaconDesc.deviceId,
                "deviceBloc": widget.deviceBloc
              });
            } else {
              LoggerService.log(msg);
            }
          },
        )),
        // Container(
        //   margin: const EdgeInsets.all(5),
        //
        //   decoration: BoxDecoration(color:Colors.white ,border: Border.all(color: const Color(0xff424242),width: 1),borderRadius: BorderRadius.circular(15)),
        //   child: ,
        // ),
        isConnecting
            ? const Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Center(child: CircularProgressIndicator()),
              )
            : const SizedBox()
      ],
    );
  }
}
