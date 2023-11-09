import 'package:flutter/material.dart';
import 'package:ims_app/utils/app_colors.dart';

class CircleBtn extends StatelessWidget{
  final String imgAssets;
  final Color? backgroundColor;
  final VoidCallback? voidCallback;

  const CircleBtn({super.key, required this.imgAssets,  this.backgroundColor, required this.voidCallback});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      onPressed: voidCallback,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
        backgroundColor: (backgroundColor ?? AppColors.grey), // <-- Button color
        foregroundColor: (backgroundColor ?? AppColors.grey).withAlpha(100), // <-- Splash color
        shadowColor: Colors.transparent,
      ),
      child: Image.asset(imgAssets),
    );
  }

}