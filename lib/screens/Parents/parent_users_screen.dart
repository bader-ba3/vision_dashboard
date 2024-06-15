import 'dart:math';

import 'package:vision_dashboard/models/Parent_Model.dart';
import 'package:vision_dashboard/models/RecentFile.dart' hide demoRecentFiles;
import 'package:vision_dashboard/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dashboard/components/date_table.dart';
import 'parent_user_details.dart';

class ParentUsersScreen extends StatelessWidget {
  ParentUsersScreen({super.key});
  final List<ParentModel> parents = generateRandomParents(10);
  final ScrollController _scrollController = ScrollController();

  DataRow parentDataRow(ParentModel parent) {
    return DataRow(
      cells: [
        DataCell(Text(parent.fullName)),
        DataCell(Text(parent.number)),
        DataCell(Text(parent.address)),
        DataCell(Text(parent.nationality)),
        DataCell(Text(parent.gender)),
        DataCell(Text(parent.age.toString())),
        DataCell(Text(parent.children.join(', '))),
        DataCell(Text(parent.startDate.toIso8601String())),
        DataCell(Text(parent.exams.map((exam) => exam.subject).join(', '))),
        DataCell(Text(parent.eventRecords
            .map((event) => event.event)
            .join(', '))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: GetBuilder<HomeViewModel>(builder: (controller) {
            return Column(
              children: [
                Row(
                  children: [
                    if (!Responsive.isDesktop(context))
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: controller.controlMenu,
                      ),
                    if (!Responsive.isMobile(context))
                      Text(
                        "اولياء الامور",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    if (!Responsive.isMobile(context))
                      Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        hintText: "بحث",
                        fillColor: secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding * 0.75),
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: SvgPicture.asset("assets/icons/Search.svg"),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                SizedBox(height: defaultPadding),
                Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  child: /* Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 200,
                          width: 450,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: secondaryColor),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: Stack(
                                  children: [
                                    PieChart(
                                      PieChartData(
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 70,
                                        startDegreeOffset: -90,
                                        sections: sexChartSelectionData,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: defaultPadding),
                                          Text(
                                            "600",
                                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                              color: Color(0xff00308F),
                                              fontWeight: FontWeight.w600,
                                              height: 0.5,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("User")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              "Male",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                          ),
                                        ),
                                        Text(
                                          "270",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              "Female",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                          ),
                                        ),
                                        Text(
                                          "330",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      squrWidget("Total Request", "15000"),
                      squrWidget("Customer Happiness Rate", "95%"),
                      SizedBox(

                          width:900,child: DateTables()),


                    ],
                  )*/


                  ParentInputForm()
/*
                      ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(secondaryColor),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30))),
                    child: Text(
                      "اضافة ولي امر جديد",
                      style: Styles.headLineStyle2,
                    ),
                  ),*/
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "كل المستخدمين",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child:Scrollbar(
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text("الاسم الكامل")),
                                DataColumn(label: Text("رقم")),
                                DataColumn(label: Text("العنوان")),
                                DataColumn(label: Text("الجنسية")),
                                DataColumn(label: Text("الجنس")),
                                DataColumn(label: Text("العمر")),
                                DataColumn(label: Text("الأبناء")),
                                DataColumn(label: Text("تاريخ البداية")),
                                DataColumn(label: Text("الامتحانات")),
                                DataColumn(label: Text("سجل الأحداث")),
                              ],
                              rows: parents.map((parent) => parentDataRow(parent)).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget squrWidget(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: secondaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
              ),
            ),
            Text(
              body,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget squrWidget2(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: secondaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
              ),
            ),
            Text(
              body,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  DataRow workingDriverDataRow(
      ({
        String name,
        String lastName,
        String numOfChild,
        String phone,
        String sex,
        String Date
      }) record) {
    return DataRow(
      cells: [
        DataCell(
          Text(record.name),
        ),
        DataCell(Text(record.lastName)),
        DataCell(Text(record.numOfChild)),
        DataCell(Text(
          record.phone,
        )),
        DataCell(Text(
          record.sex,
          style:
              TextStyle(color: record.sex == "ذكر" ? Colors.blueAccent : Colors.pinkAccent),
        )),
        DataCell(Text(
          record.Date,
        )),
        DataCell(Row(
          children: [
            IconButton(
              style: ButtonStyle(
                // foregroundColor: MaterialStatePropertyAll(primaryColor),
              ),
              onPressed: () {
                // Get.to(()=>UserDetailsScreen(record:record));
              },
              icon: Icon(Icons.remove_red_eye_outlined,color: primaryColor,),
            ),
            IconButton(
              style: ButtonStyle(
                // foregroundColor: MaterialStatePropertyAll(primaryColor),
              ),
              onPressed: () {
                // Get.to(()=>UserDetailsScreen(record:record));
              },
              icon: Icon(Icons.mode_edit_outlined,color: primaryColor,),
            ),
            IconButton(
              style: ButtonStyle(
                // foregroundColor: MaterialStatePropertyAll(primaryColor),
              ),
              onPressed: () {},
              icon: Icon(Icons.delete_outline_outlined,color: primaryColor,),
            ),
          ],
        )),
      ],
    );
  }

  List<
      ({
        String name,
        String lastName,
        String numOfChild,
        String phone,
        String sex,
        String Date
      })> listWorkingDriver = [
    (
      name: "نبيل",
      lastName: "شغيب",
      numOfChild: "٢",
      phone: "٠٥٨٤-٥٦٤٨-٤٤",
      sex: "ذكر",
      Date: "12-02-2020"
    ),
    (
      name: "علي",
      lastName: "أحمد",
      numOfChild: "٣",
      phone: "٠٥٤٣-٥٦٧٨-٣٤",
      sex: "ذكر",
      Date: "15-03-2019"
    ),
    (
      name: "فاطمة",
      lastName: "محمد",
      numOfChild: "٢",
      phone: "٠٥٧٤-٦٥٤٣-٢٣",
      sex: "أنثى",
      Date: "22-05-2018"
    ),
    (
      name: "خالد",
      lastName: "يوسف",
      numOfChild: "١",
      phone: "٠٥٣٢-٦٥٧٨-٤٥",
      sex: "ذكر",
      Date: "11-11-2021"
    ),
    (
      name: "ليلى",
      lastName: "علي",
      numOfChild: "٤",
      phone: "٠٥٥٣-٥٤٦٧-٥٦",
      sex: "أنثى",
      Date: "30-06-2020"
    ),
    (
      name: "سعيد",
      lastName: "سليمان",
      numOfChild: "٣",
      phone: "٠٥٤٢-٥٦٨٧-٣٢",
      sex: "ذكر",
      Date: "20-07-2019"
    ),
    (
      name: "سارة",
      lastName: "خالد",
      numOfChild: "١",
      phone: "٠٥٧٨-٥٦٧٨-٤٥",
      sex: "أنثى",
      Date: "18-12-2020"
    ),
    (
      name: "أحمد",
      lastName: "ناصر",
      numOfChild: "٢",
      phone: "٠٥٣٤-٥٦٧٨-٣٤",
      sex: "ذكر",
      Date: "25-01-2018"
    ),
    (
      name: "مريم",
      lastName: "عيسى",
      numOfChild: "٣",
      phone: "٠٥٦٧-٦٥٤٣-٢١",
      sex: "أنثى",
      Date: "10-02-2019"
    ),
    (
      name: "حسن",
      lastName: "عمر",
      numOfChild: "٤",
      phone: "٠٥٤٣-٥٦٨٧-٢٣",
      sex: "ذكر",
      Date: "08-04-2020"
    ),
    (
      name: "نور",
      lastName: "جمال",
      numOfChild: "١",
      phone: "٠٥٣٢-٦٥٤٣-٤٥",
      sex: "أنثى",
      Date: "03-09-2021"
    ),
    (
      name: "إبراهيم",
      lastName: "عبد الله",
      numOfChild: "٢",
      phone: "٠٥٥٧-٥٦٤٨-٣٤",
      sex: "ذكر",
      Date: "19-10-2020"
    ),
    (
      name: "هدى",
      lastName: "إسماعيل",
      numOfChild: "٣",
      phone: "٠٥٤٢-٥٦٧٨-٤٥",
      sex: "أنثى",
      Date: "17-11-2019"
    ),
    (
      name: "طارق",
      lastName: "فؤاد",
      numOfChild: "١",
      phone: "٠٥٧٨-٥٦٤٣-٣٢",
      sex: "ذكر",
      Date: "14-08-2018"
    ),
    (
      name: "ريم",
      lastName: "نزار",
      numOfChild: "٢",
      phone: "٠٥٣٤-٦٥٤٣-٢١",
      sex: "أنثى",
      Date: "21-06-2019"
    ),
    (
      name: "سامر",
      lastName: "جلال",
      numOfChild: "٣",
      phone: "٠٥٥٣-٥٦٨٧-٤٥",
      sex: "ذكر",
      Date: "09-03-2020"
    ),
    (
      name: "نجوى",
      lastName: "حسن",
      numOfChild: "٤",
      phone: "٠٥٤٣-٦٥٤٣-٣٤",
      sex: "أنثى",
      Date: "05-12-2021"
    ),
    (
      name: "عمر",
      lastName: "ياسين",
      numOfChild: "١",
      phone: "٠٥٦٧-٥٦٤٨-٢٣",
      sex: "ذكر",
      Date: "28-07-2020"
    ),
    (
      name: "حنان",
      lastName: "علي",
      numOfChild: "٢",
      phone: "٠٥٤٢-٥٦٧٨-٣٢",
      sex: "أنثى",
      Date: "12-01-2019"
    ),
    (
      name: "ماهر",
      lastName: "سامي",
      numOfChild: "٣",
      phone: "٠٥٧٨-٦٥٤٣-٤٥",
      sex: "ذكر",
      Date: "04-05-2018"
    ),
    (
      name: "لينا",
      lastName: "رائد",
      numOfChild: "٤",
      phone: "٠٥٣٢-٥٦٤٨-٣٤",
      sex: "أنثى",
      Date: "23-11-2020"
    ),
  ];

  List<PieChartSectionData> paiChartSelectionData = [
    PieChartSectionData(
      color: Colors.teal.withOpacity(0.5),
      value: 50,
      showTitle: false,
      radius: 20,
    ),
    PieChartSectionData(
      color: Colors.cyan,
      value: 1262,
      showTitle: false,
      radius: 20,
    ),
    PieChartSectionData(
      color: Colors.green.withOpacity(0.5),
      value: 188,
      showTitle: false,
      radius: 20,
    ),
  ];

  List<PieChartSectionData> sexChartSelectionData = [
    PieChartSectionData(
      color: primaryColor,
      value: 330,
      showTitle: false,
      radius: 20,
    ),
    PieChartSectionData(
      color: Colors.pink.withOpacity(0.5),
      value: 270,
      showTitle: false,
      radius: 20,
    ),
  ];
}
