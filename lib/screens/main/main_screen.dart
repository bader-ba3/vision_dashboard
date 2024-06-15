import 'package:flutter_svg/svg.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Activity/Activity_screen.dart';
import 'package:vision_dashboard/screens/Employee/Employee_users_screen.dart';
import 'package:vision_dashboard/screens/account_management/account_management_screen.dart';
import 'package:vision_dashboard/screens/buses/buses_screen.dart';
import 'package:vision_dashboard/screens/classes/classes_view.dart';
import 'package:vision_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:vision_dashboard/screens/expenses/expenses_users_screen.dart';
import 'package:vision_dashboard/screens/notification/notification_screen.dart';
import 'package:vision_dashboard/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_container/tab_container.dart';

import '../Parents/parent_users_screen.dart';
import '../Student/student_users_screen.dart';
import '../event/event_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
  final text = ["لوحة التحكم", "أولياء الامور", "الطلاب", "الصفوف", "الموظفين","الرواتب","الاشعارات", "الحافلات", "الرسوم الدراسية", "المصروف", "اراء المستفيدين", "ادارة الحسابات", "الاعدادات"];
  final image = [
    "assets/icons/menu_dashboard.svg",
    "assets/icons/menu_profile.svg",
    "assets/icons/menu_profile.svg",
    "assets/icons/menu_tran.svg",
    "assets/icons/menu_task.svg",
    "assets/icons/trip.svg",
    "assets/icons/menu_notification.svg",
    "assets/icons/menu_doc.svg",
    "assets/icons/garage.svg",
    "assets/icons/menu_tran.svg",
    "assets/icons/menu_profile.svg",
    "assets/icons/menu_setting.svg",
    "assets/icons/menu_setting.svg",
  ];
  late TabController tabController ;
  late PageController pageController ;
  @override
  void initState() {
   tabController =  TabController(length: text.length, vsync: this);
   pageController = PageController();
   tabController.addListener(() {
     pageController.jumpToPage(tabController.index);
     setState(() {});
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<HomeViewModel>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: secondaryColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: Stack(
                  children: [
                    TabContainer(
                      textDirection: TextDirection.rtl,
                      controller: tabController,
                      tabEdge: TabEdge.right,
                      tabsEnd: 0.95,
                      tabsStart: 0.125,
                      tabMaxLength: 60,
                      tabExtent: 250,
                      borderRadius: BorderRadius.circular(10),
                      tabBorderRadius: BorderRadius.circular(20),
                      childPadding: const EdgeInsets.all(10.0),
                      selectedTextStyle: const TextStyle(
                        color: Color(0xff00308F),
                        fontSize: 15.0,
                      ),
                      unselectedTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                      ),
                      colors:  List.generate(
                          text.length,
                            (index) => bgColor
                      ),
                      tabs: List.generate(
                        text.length,
                            (index) {
                          return DrawerListTile(
                            index: index,
                            title: text[index],
                            svgSrc: image[index],
                            press: () {
                              setState(() {});
                            },
                          );
                            },
                      ),
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: pageController,
                        children: [
                          EventScreen(),
                          DashboardScreen(),
                          ParentUsersScreen(),
                          StudentUsersScreen(),
                          ClassesView(),
                          EmployeeUsersScreen(),
                          SizedBox(),
                          NotificationScreen(),
                          BusesScreen(),
                          SizedBox(),
                          ExpensesScreen(),
                          SizedBox(),
                          AccountManagementScreen(),
                          SettingsScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

        }
      ),
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 25),
        child: ClipRect(
          clipBehavior: Clip.hardEdge,
          child: ListTile(

            // onTap: press,
            horizontalTitleGap: 0.0,
            leading: SizedBox(
              width: 30,
              child: SvgPicture.asset(
                svgSrc,
                colorFilter: ColorFilter.mode(Color(0xff00308F), BlendMode.srcIn),
                height: 24,
              ),
            ),
            title: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Color(0xff00308F)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

