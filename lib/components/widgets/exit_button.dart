import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'circle_btn.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  CircleBtn(imgAssets: "assets/images/logout_icon.png", voidCallback: () {
      SystemChannels.platform
          .invokeMethod<void>('SystemNavigator.pop', true);
    },);
  }
}
