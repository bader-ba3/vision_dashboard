import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';



AppBar Header({required String  title,required String middleText,required BuildContext context}) {

  return AppBar(
    toolbarHeight: 60,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        HomeViewModel homeViewModel = Get.find<HomeViewModel>();
        homeViewModel.controlMenu();
      },
    ),
    centerTitle: false,
    title: Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: Styles.headLineStyle1.copyWith(color: primaryColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
            onPressed: () {
              QuickAlert.show(
                  width: Get.width/2,
                  context: context,
                  type: QuickAlertType.info,
                title: middleText,
                confirmBtnText: "تم".tr
              );

            },
            icon: Icon(Icons.info_outline))
      ],
    ),
    actions: [

    ],
  );
}


