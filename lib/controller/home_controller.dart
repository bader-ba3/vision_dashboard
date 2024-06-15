import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'dart:js' as js;
//
// import 'package:universal_html/html.dart';

import '../screens/main/main_screen.dart';

class HomeViewModel extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int menuIndex = 0;
  void changeIndex(_) {
    menuIndex = _;
    update();
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

}
