import 'package:flutter/material.dart';
import 'package:ims_app/utils/size_config.dart';

class ListItemWD{


  build(String title, String? content,{String? char,bool boldContent = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$title ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18 * SC.fontProportion,
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        Text(
          (content ?? '--') + (char ?? ""),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18 * SC.fontProportion,
            fontWeight: boldContent ? FontWeight.w700 : FontWeight.w400,
            height: 0,
          ),
        )
      ],
    );
  }
}