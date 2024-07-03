import 'package:flutter_svg/svg.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Buses/Buses_View.dart';
import 'package:vision_dashboard/screens/Exams/Exam_View.dart';
import 'package:vision_dashboard/screens/Parents/Parents_View.dart';
import 'package:vision_dashboard/screens/Salary/Salary_view.dart';
import 'package:vision_dashboard/screens/Store/Store_View.dart';
import 'package:vision_dashboard/screens/Student/Student_view_Screen.dart';
import 'package:vision_dashboard/screens/Study%20Fees/Study_Fees_View.dart';
import 'package:vision_dashboard/screens/classes/classes_view.dart';
import 'package:vision_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:vision_dashboard/screens/expenses/expenses_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_container/tab_container.dart';

import '../account_management/Employee_View.dart';

import '../employee_time/employee_time.dart';
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
    widget: SalaryView(),
    ),
    (
    name: "الحافلات",
    img: "assets/icons/menu_doc.svg",
    widget: BusesView(),
    ),
    (
    name: "الرسوم الدراسية",
    img: "assets/icons/garage.svg",
    widget: StudyFeesView(),
    ),
    (
    name: "الأحداث",
    img: "assets/icons/garage.svg",
    widget: EventViewScreen(),
    ),
    (
    name: "المصاريف",
    img: "assets/icons/menu_tran.svg",
    widget: ExpensesViewScreen(),
    ),
    (
    name: "ادارة المنصة",
    img: "assets/icons/menu_setting.svg",
    widget: EmployeeView(),
    ),
    (
    name: "المستودع",
    img: "assets/icons/garage.svg",
    widget: StoreView(),
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

    return GetBuilder<HomeViewModel>(builder: (controller) {

      return Scaffold(
        backgroundColor: secondaryColor,
        body: controller.isLoading?Center(child: CircularProgressIndicator(),): Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabContainer(
            textDirection: Get.locale.toString()=="ar_ar"?TextDirection.rtl:TextDirection.ltr,
            controller: tabController,
            tabEdge:Get.locale.toString()=="ar_ar"? TabEdge.right:TabEdge.left,
            tabsEnd: 1,
            tabsStart: 0.0,
            tabMaxLength: controller.isDrawerOpen ? 60 : 60,
            tabExtent: controller.isDrawerOpen ? 180 : 60,
            borderRadius: BorderRadius.circular(10),
            tabBorderRadius: BorderRadius.circular(20),
            childPadding: const EdgeInsets.all(0.0),
            selectedTextStyle: const TextStyle(
              color: secondaryColor,
              fontSize: 15.0,
            ),
            unselectedTextStyle: Styles.headLineStyle1.copyWith(
              color: primaryColor,
              fontSize: 13.0,
            ),
            colors: List.generate(allData.length, (index) => bgColor),
            tabs: List.generate(
              allData.length,
                  (index) {
                return DrawerListTile(


                  index: index,
                  title: allData[index].name.toString().tr,
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
        ),
      );
    });
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
      return Directionality(
        textDirection: Get.locale.toString()=="ar_ar"?TextDirection.rtl:TextDirection.ltr,
        child: controller.isDrawerOpen
            ? Center(child: Row(
          children: [
            SizedBox(width: 30,),
            SvgPicture.asset(
              svgSrc,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              height: 20,
            ),
            SizedBox(width: 10,),

            Text(title,),
          ],
        ))
            : Center(child: Row(
          children: [
            SizedBox(width: 20,),
            SvgPicture.asset(
              svgSrc,
              colorFilter: ColorFilter.mode(Color(0xff00308F), BlendMode.srcIn),
              height: 20,
            ),
          ],
        ),),
      );
    });
  }
}
