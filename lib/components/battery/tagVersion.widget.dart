import 'package:flutter/material.dart';
import 'package:ims_app/modules/bloc/device.bloc.dart';

class TagVersion extends StatelessWidget{
  final DeviceBloc deviceBloc;

  const TagVersion({super.key, required this.deviceBloc});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsetsDirectional.only(end:15.0),
      child: Text("(tag version: ${"${deviceBloc.getTagData?.firmwareMajor?.toString() ?? ""}.${deviceBloc.getTagData?.firmwareMinor?.toString().padLeft(2,'0') ?? ""}"})"),
    );
  }

  
}
