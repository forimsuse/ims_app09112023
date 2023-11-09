import 'package:flutter/material.dart';
import 'package:ims_app/pages/home_page.dart';


var routes = <String, WidgetBuilder>{
  // '/battery': (context) => const HomePage(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  final Map mapArguments = arguments is Map ? arguments : {};
  switch (settings.name) {
    case '/home':
      return MaterialPageRoute(
          builder: (context) => HomePage(
            deviceId: mapArguments["deviceId"], deviceBloc: mapArguments["deviceBloc"],
          ),
          settings: settings);
    default:
      return null;
  }
}
