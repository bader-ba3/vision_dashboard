import 'package:flutter_svg/svg.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Activity/Activity_screen.dart';
import 'package:vision_dashboard/screens/Buses/Buses_View.dart';
import 'package:vision_dashboard/screens/Employee/Employee_View.dart';
import 'package:vision_dashboard/screens/Employee/Employee_users_screen.dart';
import 'package:vision_dashboard/screens/Exams/Exam_View.dart';
import 'package:vision_dashboard/screens/Exams/Exam_screen.dart';
import 'package:vision_dashboard/screens/Parents/Parents_View.dart';
import 'package:vision_dashboard/screens/Student/Student_view_Screen.dart';
import 'package:vision_dashboard/screens/account_management/account_management_screen.dart';
import 'package:vision_dashboard/screens/buses/buses_screen.dart';
import 'package:vision_dashboard/screens/classes/classes_view.dart';
import 'package:vision_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:vision_dashboard/screens/expenses/expenses_users_screen.dart';
import 'package:vision_dashboard/screens/expenses/expenses_view_screen.dart';
import 'package:vision_dashboard/screens/notification/notification_screen.dart';
import 'package:vision_dashboard/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_container/tab_container.dart';

import '../Parents/parent_users_screen.dart';
import '../Student/student_users_screen.dart';
import '../delete_management/delete_management_view.dart';
import '../employee_time/employee_time.dart';
import '../event/event_screen.dart';
import '../event/event_view_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  List<({String name, String img, Widget widget})> allData = [
    (
      name: "لوحة التحكم",
      img: "assets/icons/menu_dashboard.svg",
      widget: DashboardScreen(),
    ),
    (
      name: "أولياء الامور",
      img: "assets/icons/menu_profile.svg",
      widget: ParentsView(),
    ),
    (
      name: "الطلاب",
      img: "assets/icons/menu_profile.svg",
      widget: StudentView(),
    ),
    (
      name: "الصفوف",
      img: "assets/icons/menu_tran.svg",
      widget: ClassesView(),
    ),
    (
      name: "الموظفين",
      img: "assets/icons/menu_task.svg",
      widget: EmployeeView(),
    ),
    (
    name: "الدوام",
    img: "assets/icons/menu_task.svg",
    widget: EmployeeTimeView(),
    ),
    (
      name: "الامتحانات",
      img: "assets/icons/menu_task.svg",
      widget: ExamView(),
    ),
    (
      name: "الرواتب",
      img: "assets/icons/trip.svg",
      widget: SizedBox(),
    ),
    (
      name: "الاشعارات",
      img: "assets/icons/menu_notification.svg",
      widget: NotificationScreen(),
    ),
    (
      name: "الحافلات",
      img: "assets/icons/menu_doc.svg",
      widget: BusesView(),
    ),
    (
      name: "الرسوم الدراسية",
      img: "assets/icons/garage.svg",
      widget: SizedBox(),
    ),
    (
      name: "اللأحداث",
      img: "assets/icons/garage.svg",
      widget: EventViewScreen(),
    ),
    (
      name: "المصاريف",
      img: "assets/icons/menu_tran.svg",
      widget: ExpensesViewScreen(),
    ),
    (
      name: "اراء المستفيدين",
      img: "assets/icons/menu_profile.svg",
      widget: SizedBox(),
    ),
    (
      name: "منصة الحذف",
      img: "assets/icons/menu_setting.svg",
      widget: DeleteManagementView(),
    ),
    (
      name: "ادارة الحسابات",
      img: "assets/icons/menu_setting.svg",
      widget: AccountManagementScreen(),
    ),
    (
      name: "الاعدادات",
      img: "assets/icons/menu_setting.svg",
      widget: SettingsScreen(),
    ),
  ];

  late TabController tabController;
  late PageController pageController;
  @override
  void initState() {
    tabController = TabController(length: allData.length, vsync: this);
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
      child: GetBuilder<HomeViewModel>(builder: (controller) {
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
                    unselectedTextStyle: Styles.headLineStyle1.copyWith(
                      color: Colors.black,
                      fontSize: 13.0,
                    ),
                    colors: List.generate(allData.length, (index) => bgColor),
                    tabs: List.generate(
                      allData.length,
                      (index) {
                        return DrawerListTile(
                          index: index,
                          title: allData[index].name,
                          svgSrc: allData[index].img,
                          press: () {
                            setState(() {});
                          },
                        );
                      },
                    ),
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: List.generate(allData.length, (index) => allData[index].widget),
                    ),
                  ),
                ],
              ),
            ),
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
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
