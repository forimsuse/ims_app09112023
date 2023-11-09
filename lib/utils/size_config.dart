import 'package:flutter/material.dart';

class SC {
  final double _screenWidthInit = 390;
  final double _screenHeightInit = 844;
  static late double screenWidthProportion;
  static late double screenHeightProportion;
  static double fontProportion = 1;
  // static late final double defaultProportion;
  static late double screenWidth;
  static late double screenHeight;
  // static late final double _blockSizeHorizontal;
  // static late final double _blockSizeVertical;

  // static late double textMultiplier;
  // static late double imageSizeMultiplier;
  // static late double heightMultiplier;
  // static late double widthMultiplier;
  // static late double heightStatusBar;
  // static late double heightAppBar;
  static bool? isPortrait = true;
  static bool isMobilePortrait = false;
  // static bool isStartSizeConfig = false;

  void init(BoxConstraints constraints, Orientation orientation,BuildContext context) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      screenWidthProportion = screenWidth/_screenWidthInit;
      screenHeightProportion = screenHeight/_screenHeightInit;
      // defaultProportion = screenHeight/_screenHeightInit;
      isPortrait = true;
      if (screenWidth < 1000) {
        isMobilePortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      screenWidthProportion = screenWidth/_screenWidthInit;
      screenHeightProportion = screenHeight/_screenHeightInit;
      // defaultProportion = screenHeight/_screenHeightInit;
      isPortrait = false;
      isMobilePortrait = false;
    }
    fontProportion = screenHeightProportion;
    // _blockSizeHorizontal = screenWidth / 100;
    // _blockSizeVertical = screenHeight / 100;

    // textMultiplier = _blockSizeVertical;
    // imageSizeMultiplier = _blockSizeHorizontal;
    // heightMultiplier = _blockSizeVertical;
    // widthMultiplier = _blockSizeHorizontal;
    // heightStatusBar = MediaQuery.of(context).padding.top;
    // heightAppBar = AppBar().preferredSize.height + heightStatusBar;
  }

  static getHeightStatusBar(BuildContext context) => MediaQuery.of(context).padding.top;
  static getHeightAppBar(BuildContext context) => AppBar().preferredSize.height + MediaQuery.of(context).padding.top;

// static double heightCustomAppBar(){
//   return 160*screenHeightProportion + heightStatusBar;
// }

}

