import 'package:flutter/cupertino.dart';
import 'package:ims_app/modules/bloc/last_data.bloc.dart';
import 'package:ims_app/utils/logger.service.dart';

class LastDataWidget extends StatefulWidget{
  final String deviceId;
  const LastDataWidget({super.key, required this.deviceId});

  @override
  State<LastDataWidget> createState() => _LastDataWidgetState();
}

class _LastDataWidgetState extends State<LastDataWidget> {

  late LastDataBloc lastDataBloc;

  @override
  void initState() {
    LoggerService.log("init state LastDataWidget");
    lastDataBloc = LastDataBloc(widget.deviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRowContent("Last data:",null,bold: true),
        _buildRowContent("Charging status:",lastDataBloc.chargingStatus),
        _buildRowContent("Voltage at start of charge:","--"),
        _buildRowContent("Voltage at end of charge:",lastDataBloc.voltageAtEndCharge),
        _buildRowContent("Main temperature at start of charge:","--"),
        _buildRowContent("Main temperature at end of charge:",lastDataBloc.temperatureAtEndCharge),
        _buildRowContent("Charge duration:","--"),
        _buildRowContent("Alerts:",lastDataBloc.recordAlerts == "" ? "--" : lastDataBloc.recordAlerts),
      ],
    );
  }

  _buildRowContent(String title, String? data,{bool bold = false}){
    return Row(children: [
      Padding(
          padding: const EdgeInsets.symmetric( horizontal: 8.0,vertical: 3),
          child: Text(title,style: TextStyle(fontWeight: bold ? FontWeight.w500 : FontWeight.w400),)),
      Expanded(child: data != null ? Text(data) : const SizedBox()),
    ],);
  }
}