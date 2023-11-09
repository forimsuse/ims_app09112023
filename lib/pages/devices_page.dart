import 'package:flutter/material.dart';
import 'package:ims_app/components/home/list_batteries.dart';
import 'package:ims_app/components/widgets/appBar_wd.dart';
import 'package:ims_app/modules/repository/permission_service.repository.dart';
import 'package:ims_app/utils/app_colors.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key,required this.permissionServiceRepository});
  final PermissionServiceRepository permissionServiceRepository;
  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final myColor = AppColors.black;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWD(title: "Battery list") ,
        body: ListBatteries(permissionServiceRepository: widget.permissionServiceRepository,) );
  }
}
