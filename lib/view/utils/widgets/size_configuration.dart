import 'package:flutter/widgets.dart';


class SizeConfig {
  static late MediaQueryData queryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double blockScreenRatio;

  void init(BuildContext context) {
    queryData = MediaQuery.of(context);
    screenWidth = queryData.size.width ;
    screenHeight = queryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    blockScreenRatio= screenWidth/screenHeight;
  }
}


