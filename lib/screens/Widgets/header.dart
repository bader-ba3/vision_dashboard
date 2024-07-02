import 'package:get/get.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';

import '../../constants.dart';

// class Header extends StatelessWidget {
//   const Header({
//     Key? key,
//     required String this.title,
//   }) : super(key: key);
// final String title;
//   @override
//   Widget build(BuildContext context) {
//     return
//     // return GetBuilder<HomeViewModel>(
//     //   builder: (controller) {
//     //     return Row(
//     //       children: [
//     //           IconButton(
//     //             icon: Icon(Icons.menu),
//     //             onPressed: controller.controlMenu,
//     //           ),
//     //           Text(
//     //             title,
//     //             style: Theme.of(context).textTheme.titleLarge,
//     //           ),
//     //         SizedBox(width: 10,),
//     //         if(MediaQuery.sizeOf(context).width >800 )
//     //         Spacer(flex:  1 ),
//     //         Expanded(child: SearchField()),
//     //       ],
//     //     );
//     //   }
//     // );
//   }
// }

AppBar Header({required String  title,required String middleText}) {
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
        Text(
          title,
          style: Get.textTheme.titleLarge,
        ),
        IconButton(
            onPressed: () {
              Get.defaultDialog(

                  title: title,
                  middleText: middleText,
                  backgroundColor: secondaryColor,
                  confirm: AppButton(
                    text: "تم".tr,
                    onPressed: () => Get.back(),
                  ));
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
        hintText: "ابحث",
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
