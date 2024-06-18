import 'package:vision_dashboard/models/Employee_Model.dart';
import 'package:vision_dashboard/responsive.dart';
import 'package:vision_dashboard/screens/Employee/Employee_user_details.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeUsersScreen extends StatelessWidget {
  EmployeeUsersScreen({super.key});
  ScrollController _scrollController = ScrollController();

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
                        "الموظيفين",
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
     /*           Container(
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  child: *//* Wrap(
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
                  )*//*

                      ElevatedButton(
                    onPressed: () {
                      Get.to(EmployeeInputForm());
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(secondaryColor),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30))),
                    child: Text(
                      "اضافة موظف جديد",
                      style: Styles.headLineStyle2.copyWith(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),*/
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
                        "كل الموظفين",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(),

                              showCheckboxColumn: true,
                              showBottomBorder: true,
                              // columnSpacing: defaultPadding,
                              // minWidth: 600,
                              columns: [
                                DataColumn(
                                  label: Text("الاسم الكامل"),
                                ),
                                DataColumn(
                                  label: Text("رقم الموبايل"),
                                ),
                                DataColumn(
                                  label: Text("العنوان"),
                                ),
                                DataColumn(
                                  label: Text("الجنسية "),
                                ),
                                DataColumn(
                                  label: Text("الجنس"),
                                ),
                                DataColumn(label: Text("العمر")),
                                DataColumn(label: Text("الوظيفة")),
                                DataColumn(label: Text("الراتب")),
                                DataColumn(label: Text("العقد")),
                                DataColumn(label: Text("الصفوف")),
                                DataColumn(label: Text("تاريخ البداية")),
                                DataColumn(label: Text("سجل الاحداث")),
                                DataColumn(
                                  label: Text("خيارات"),
                                ),
                              ],
                              rows: List.generate(
                                listWorkingDriver.length,
                                (index) => workingDriverDataRow(
                                   generateRandomEmployees(20)[index]),
                              ),
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

  DataRow workingDriverDataRow(EmployeeModel employeeModel) {
    return DataRow(
      cells: [
        DataCell(Text(employeeModel.fullName.toString())),
        DataCell(Text(employeeModel.mobileNumber.toString())),
        DataCell(Text(employeeModel.address.toString())),
        DataCell(Text(employeeModel.nationality.toString())),
        DataCell(Text(employeeModel.gender.toString())),
        DataCell(Text(employeeModel.age.toString())),
        DataCell(Text(employeeModel.jobTitle.toString())),
        DataCell(Text(employeeModel.salary.toString())),
        DataCell(Text(employeeModel.contract.toString())),
        DataCell(Text(employeeModel.bus.toString())),
        DataCell(Text(employeeModel.startDate.toString())),
        DataCell(Text(employeeModel.eventRecords.toString())),
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

  List<
      EmployeeModel > listWorkingDriver = generateRandomEmployees(20);

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
