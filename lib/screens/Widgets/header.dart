import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          /*    Get.defaultDialog(

                  title: title,
                  middleText: middleText,
                  backgroundColor: secondaryColor,
                  confirm: AppButton(
                    text: "تم".tr,
                    onPressed: () => Get.back(),
                  ));*/
            },
            icon: Icon(Icons.info_outline))
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: Builder(builder: (context) {
          return SizedBox(
              width: MediaQuery.sizeOf(context).width / 3,
              child: SearchField());
        }),
      ),
    ],
  );
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "ابحث".tr,
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
