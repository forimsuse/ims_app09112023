import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ims_app/pages/devices_page.dart';
import 'package:ims_app/routes.dart';
import 'package:ims_app/utils/app_colors.dart';
import 'package:ims_app/utils/root_navigation.dart';
import 'package:ims_app/utils/size_config.dart';
import 'components/home/blutooth_off_screen.dart';
import 'modules/provider/permission.provider.dart';
import 'modules/repository/permission_service.repository.dart';

void main() {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    PermissionProvider.request().then((status) {
      runApp(const MyApp());
    });
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final permission = PermissionServiceRepository();

  @override
  void initState() {
    permission.listenToState();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RootNavigation.navigatorKey,
      title: 'IMSapp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.pink),
          scaffoldBackgroundColor: Colors.white,
        // useMaterial3: true,
      ),
      routes: routes,
      home: LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SC().init(constraints, orientation, context);
        return StreamBuilder<bool>(
            stream: permission.correctPermissionsStream,
            initialData: false,
            builder: (c, snapshot) {
              final state = snapshot.data;
              if (state == true) {
                return DevicesPage(permissionServiceRepository: permission);
              }
              return BluetoothOffScreen(permissionServiceRepository: permission);
            });});
      }),
      onGenerateRoute: onGenerateRoute,
    );
  }
}