import 'package:flutter/material.dart';
import 'package:ims_app/utils/app_colors.dart';
import 'package:ims_app/utils/size_config.dart';

class BatteryFrame extends StatelessWidget {
  final Widget child;

  const BatteryFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 329 * SC.screenWidthProportion,
          padding: EdgeInsetsDirectional.only(
              top: 7 * SC.screenHeightProportion,
              bottom: 7 * SC.screenHeightProportion,
              start: 12 * SC.screenWidthProportion),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.circular(6 * SC.screenWidthProportion),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 4 * SC.screenWidthProportion),
                  child: child),
              PositionedDirectional(
                start: 0,
                top: 4 * SC.screenHeightProportion,
                bottom: 4 * SC.screenHeightProportion,
                child: Container(
                  color: AppColors.pink,
                  width: 4 * SC.screenWidthProportion,
                ),
              )
            ],
          ),
        ),
        Container(
          width: 12 * SC.screenWidthProportion,
          height: 55 * SC.screenHeightProportion,
          decoration:  ShapeDecoration(
            color: const Color(0xFFD9D9D9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(3* SC.screenWidthProportion),
                bottomRight: Radius.circular(3* SC.screenWidthProportion),
              ),
            ),
          ),
        )
      ],
    );
  }
}
