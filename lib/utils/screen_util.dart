import 'package:flutter/material.dart';

class ScreenUtils {

  static double getRemainingHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double statusBarHeight = MediaQuery.of(context).padding.top;

    double appBarHeight = AppBar().preferredSize.height;

    double bottomNavigatorBarHeight = kBottomNavigationBarHeight;

    double remainingHeight = screenHeight - (statusBarHeight + appBarHeight + bottomNavigatorBarHeight);
    return remainingHeight;
  }
}