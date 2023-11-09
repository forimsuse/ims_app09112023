import 'package:flutter/material.dart';
import 'package:ims_app/components/home/last_data.widget.dart';
import 'package:ims_app/components/widgets/battery_frame.dart';

import '../../utils/size_config.dart';
import '../widgets/expanded_section.dart';

class ListItemBatteryNoCommunication extends StatefulWidget {
  const ListItemBatteryNoCommunication({
    super.key,
    required this.deviceId,
    this.name,
  });
  final String deviceId;
  final String? name;

  @override
  State<ListItemBatteryNoCommunication> createState() =>
      _ListItemBatteryNoCommunicationState();
}

class _ListItemBatteryNoCommunicationState
    extends State<ListItemBatteryNoCommunication> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    final lastData = LastDataWidget(deviceId: widget.deviceId);
    // TODO: implement build
    return BatteryFrame(
        child: ExpandedSection(
      title: Text(
        widget.deviceId,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18 * SC.screenWidthProportion,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
      ),
      subtitle: Text(
        "No communication.",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16 * SC.screenWidthProportion,
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
      child: lastData,
    ));
  }
}
