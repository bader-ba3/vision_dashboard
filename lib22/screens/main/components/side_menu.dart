import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);
  final text = ["Dashboard", "Users", "All Drivers", "All Cars", "Taxi", "Buss", "Ferry", "Notification", "Reports", "Maps", "AI", "customer Happiness", "Account Management", "Settings"];
  final image = [
    "assets/icons/menu_dashboard.svg",
    "assets/icons/menu_profile.svg",
    "assets/icons/menu_profile.svg",
    "assets/icons/menu_task.svg",
    "assets/icons/car2.svg",
    "assets/icons/bus2.svg",
    "assets/icons/boat2.svg",
    "assets/icons/menu_notification.svg",
    "assets/icons/menu_doc.svg",
    "assets/icons/menu_task.svg",
    "assets/icons/menu_tran.svg",
    "assets/icons/menu_profile.svg",
    "assets/icons/menu_setting.svg",
    "assets/icons/menu_setting.svg",
  ];
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<HomeViewModel>(builder: (controller) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            controller: scrollController,
            children: [
              DrawerHeader(
                child: Image.asset(
                  "assets/RAKTA-LOGO.png",
                ),
              ),
              ...List.generate(
                text.length,
                (index) => DrawerListTile(
                  index: index,
                  title: text[index],
                  svgSrc: image[index],
                  press: () {
                    controller.changeIndex(index);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.index,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(color: controller.menuIndex == index ? Colors.blueAccent : Colors.transparent, borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            onTap: press,
            horizontalTitleGap: 0.0,
            leading: SizedBox(
              width: 30,
              child: SvgPicture.asset(
                svgSrc,
                colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
                height: 24,
              ),
            ),
            title: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
