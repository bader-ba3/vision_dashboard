import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import '../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/Parent_Model.dart';
import '../../responsive.dart';
import '../dashboard/components/date_table.dart';
import 'parent_user_details.dart';

class ParentUsersScreen extends StatelessWidget {
  ParentUsersScreen({super.key});

  final List<ParentModel> parents = generateRandomParents(10);
  final ScrollController _scrollController = ScrollController();

  DataRow parentDataRow(ParentModel parent) {
    return DataRow(
      cells: [
        DataCell(Text(parent.fullName!)),
        DataCell(Text(parent.number!)),
        DataCell(Text(parent.address!)),
        DataCell(Text(parent.work!)),
        DataCell(Text(parent.motherPhoneNumber.toString())),
        DataCell(Text(parent.phoneNumber.toString())),
        DataCell(Text(parent.emergencyPhone.toString())),
        // DataCell(Text(parent.age.toString())),
        // DataCell(Text(parent.children.join(', '))),
        DataCell(Text(parent.parentID.toString())),
        // DataCell(Text(parent.parentID.toString())),

        // DataCell(Text(parent.exams.map((exam) => exam.subject).join(', '))),
        DataCell(
            Text(parent.eventRecords!.map((event) => event.event).join(', '))),
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
                        width: Get.width,
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Text("الاسم NAME:",style: Styles.headLineStyle2.copyWith(color: Colors.black),),
                                SizedBox(width: 15,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: CustomPaint(
                                      painter: DottedUnderlinePainter(),
                                      child: TextField(
                                        style: TextStyle(color: Colors.black, fontSize: 18), // تعديل النمط هنا
                                        enabled: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),],
                            )

                          ],
                        ) ,
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


/*  Scrollbar(
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
  // DataColumn(label: Text("الأبناء")),
  DataColumn(label: Text("تاريخ البداية")),
  DataColumn(label: Text("سجل الأحداث")),
  DataColumn(label: Text("الامتحانات")),
  ],
  rows: parents
      .map((parent) => parentDataRow(parent))
      .toList(),
  ),
  ),
  )*/
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

  DataRow workingDriverDataRow(ParentModel parentModel) {
    return DataRow(
      cells: [
        DataCell(Text(parentModel.fullName.toString())),
        DataCell(Text(parentModel.parentID.toString())),
        DataCell(Text(parentModel.number.toString())),
        DataCell(Text(parentModel.address.toString())),
        DataCell(Text(parentModel.phoneNumber.toString())),
        DataCell(Text(parentModel.motherPhoneNumber.toString())),
        DataCell(Text(parentModel.emergencyPhone.toString())),
        DataCell(Text(parentModel.work.toString())),
        DataCell(Row(
          children: [
            IconButton(
              style: ButtonStyle(
                  // foregroundColor: MaterialStatePropertyAll(primaryColor),
                  ),
              onPressed: () {
                // Get.to(()=>UserDetailsScreen(record:record));
              },
              icon: Icon(
                Icons.remove_red_eye_outlined,
                color: primaryColor,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                  // foregroundColor: MaterialStatePropertyAll(primaryColor),
                  ),
              onPressed: () {
                // Get.to(()=>UserDetailsScreen(record:record));
              },
              icon: Icon(
                Icons.mode_edit_outlined,
                color: primaryColor,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                  // foregroundColor: MaterialStatePropertyAll(primaryColor),
                  ),
              onPressed: () {},
              icon: Icon(
                Icons.delete_outline_outlined,
                color: primaryColor,
              ),
            ),
          ],
        )),
      ],
    );
  }

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
class DottedUnderlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double dashWidth = 4, dashSpace = 4, startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, size.height), Offset(startX + dashWidth, size.height), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}