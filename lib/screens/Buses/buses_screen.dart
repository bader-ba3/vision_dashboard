import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:vision_dashboard/controller/expenses_view_model.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/models/expenses_model.dart';
import 'package:vision_dashboard/screens/Buses/Buses_Detailes.dart';
import 'package:vision_dashboard/screens/Buses/Controller/Bus_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/header.dart';
import 'package:vision_dashboard/screens/expenses/expenses_input_form.dart';
import '../../constants.dart';

import '../../controller/delete_management_view_model.dart';
import '../../models/Bus_Model.dart';
import '../Student/Controller/Student_View_Model.dart';
import '../Widgets/AppButton.dart';
import '../Widgets/Data_Row.dart';

class BusesScreen extends StatefulWidget {
  @override
  State<BusesScreen> createState() => _BusesScreenState();
}

class _BusesScreenState extends State<BusesScreen> {
  /*final ScrollController _scrollController = ScrollController();

  DataRow busDataRow(BusModel bus) {
    return DataRow(
      cells: [
        DataCell(Text(bus.name)),
        DataCell(Text(bus.number)),
        DataCell(Text(bus.type)),
        DataCell(Text(bus.employees.length.toString())),
        DataCell(Text(bus.students.length.toString())),
        DataCell(Text(bus.startDate.toString())),
        DataCell(Text(bus.expense.toStringAsFixed(2))),
        DataCell(Text(bus.eventRecords.length.toString())),
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
                Header(title: "الحافلات"),
                SizedBox(height: defaultPadding),
                LineBusChart(
                  isShowingMainData: true,
                ),
                SizedBox(height: defaultPadding),
                Container(
                  width: double.infinity,
                  child: Wrap(
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
                                        sections: paiChartSelectionData,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: defaultPadding),
                                          Text(
                                            "1262",
                                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                                  color: Color(0xff00308F),
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.5,
                                                ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("of 1500")
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
                                              "Working Bus",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                          ),
                                        ),
                                        Text(
                                          "1262",
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
                                              "Stopped Bus",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                          ),
                                        ),
                                        Text(
                                          "88",
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
                                              "maintenance Bus",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                          ),
                                        ),
                                        Text(
                                          "50",
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
                      squareWidget("Bus waiting on station", "100"),
                      squareWidget("current Trip", "150"),
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
                                        sections: BusTicketChartSelectionData,
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
                                          Text("Bus")
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
                                              "All Ticket sold",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                          ),
                                        ),
                                        Text(
                                          "510",
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
                                              "some Ticket sold",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                          ),
                                        ),
                                        Text(
                                          "90",
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
                      squareWidget("available Bus working", "50"),
                      squareWidget("stopped Bus", "300"),
                      squareWidget("Maintenance Bus", "300"),
                      squareWidget("Total Ticket Today", "2000"),
                    ],
                  ),
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
                        "All Cars",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child:  Scrollbar(
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text("الاسم")),
                                DataColumn(label: Text("رقم")),
                                DataColumn(label: Text("نوع")),
                                DataColumn(label: Text("موظف")),
                                DataColumn(label: Text("طلاب")),
                                DataColumn(label: Text("تاريخ البداية")),
                                DataColumn(label: Text("مصروف")),
                                DataColumn(label: Text("سجل الأحداث")),
                              ],
                              rows: [],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                */ /* SizedBox(
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
                        "All Driver",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          columnSpacing: defaultPadding,
                          // minWidth: 600,
                          columns: [
                            DataColumn(
                              label: Text("Driver Name"),
                            ),
                            DataColumn(
                              label: Text("Number of Trip"),
                            ),
                            DataColumn(
                              label: Text("Total Distance"),
                            ),
                            DataColumn(
                              label: Text("Status"),
                            ),
                            DataColumn(
                              label: Text("Details"),
                            ),
                          ],
                          rows: List.generate(
                            listWorkingDriver.length,
                            (index) => workingDriverDataRow(listWorkingDriver[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/ /*
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget squareWidget(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: secondaryColor),
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

  DataRow recentTripDataRow(RecentFile fileInfo) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Container(
                // decoration: BoxDecoration(color: Color(0xff00308F),borderRadius: BorderRadius.circular(10)),
                // padding: EdgeInsets.all(8),
                child: Image.asset(
                  fileInfo.recId!,
                  height: 30,
                  width: 30,
                  // color: fileInfo.title == "Taxi"
                  //     ? primaryColor.withOpacity(0.5)
                  //     : fileInfo.title == "Bus"
                  //         ? Colors.cyan
                  //         : Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(fileInfo.provider!),
              ),
            ],
          ),
        ),
        DataCell(Text(fileInfo.date!)),
        DataCell(Text(fileInfo.location!)),
        // DataCell(Text(fileInfo.totalTicket!)),
      ],
    );
  }

final  List listRecentTrip = [
    RecentFile(
      recId: "assets/bus_icon.png",
      provider: "Rak -> Ajman",
      date: "01-03-2021",
      location: "3.5KM",
      // totalTicket: "30 Ticket",
    ),
    RecentFile(
      recId: "assets/bus_icon.png",
      provider: "Rak -> Dubai",
      date: "27-02-2021",
      location: "19.0KM",
      // totalTicket: "30 Ticket",
    ),
    RecentFile(
      recId: "assets/bus_icon.png",
      provider: "Rak -> Oman",
      date: "25-02-2021",
      location: "3.5KM",
      // totalTicket: "30 Ticket",
    ),
    RecentFile(
      recId: "assets/bus_icon.png",
      provider: "Rak -> Dubai",
      date: "25-02-2021",
      location: "3.5KM",
      // totalTicket: "30 Ticket",
    ),
    RecentFile(
      recId: "assets/bus_icon.png",
      provider: "Rak -> AlAeen",
      date: "25-02-2021",
      location: "3.5KM",
      // totalTicket: "30 Ticket",
    ),
    RecentFile(
      recId: "assets/bus_icon.png",
      provider: "Rak -> Sharja",
      date: "25-02-2021",
      location: "3.5KM",
      // totalTicket: "30 Ticket",
    ),
    RecentFile(
      recId: "assets/bus_icon.png",
      provider: "Rak -> Dubai",
      date: "25-02-2021",
      location: "3.5KM",
      // totalTicket: "30 Ticket",
    ),
    RecentFile(
      recId: "assets/bus_icon.png",
      provider: "Rak -> Sharja",
      date: "25-02-2021",
      location: "3.5KM",
      // totalTicket: "30 Ticket",
    ),
  ];

  DataRow workingDriverDataRow(({String driverName, String a, String b, String status}) record) {
    return DataRow(
      cells: [
        DataCell(
          Text(record.driverName),
        ),
        DataCell(Text(record.a)),
        DataCell(Text(record.b)),
        DataCell(Text(
          record.status,
          style: TextStyle(color: record.status == "Stopped" ? Colors.red : Colors.green),
        )),
        DataCell(
            ElevatedButton(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.blue),
          ),
          onPressed: () {

          },
          child: Text("Details"),
        )),
      ],
    );
  }

final  List<({String driverName, String a, String b, String status})> listWorkingDriver = [
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Stopped"),
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Working"),
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Working"),
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Stopped"),
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Working"),
  ];

 final List<PieChartSectionData> paiChartSelectionData = [
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
      color: Colors.pink.withOpacity(0.5),
      value: 188,
      showTitle: false,
      radius: 20,
    ),
  ];

 final List<PieChartSectionData> BusTicketChartSelectionData = [
    PieChartSectionData(
      color: Colors.green,
      value: 85,
      showTitle: false,
      radius: 20,
    ),
    PieChartSectionData(
      color: Colors.red,
      value: 15,
      showTitle: false,
      radius: 20,
    ),
  ];*/

  final ScrollController _scrollController = ScrollController();
  List data = [
    "رقم الحافلة",
    "اسم الحافلة",
    "النوع",
    "عدد الطلاب",
    "عدد الموظفين",
    "المصروف",
    "تاريخ البداية",
    "الخيارات",
    ""
  ];
  final TextEditingController subNameController = TextEditingController();
  final TextEditingController subQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          context: context,
        title: 'الحافلات'.tr,middleText: "تعرض معلومات الحافلات مع امكانية اضافة حافلة جديدة او اضافة مصروف الى حافلة موجودة سابقا".tr
      ),
      body: SingleChildScrollView(
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(
                  MediaQuery.sizeOf(context).width -
                      (controller.isDrawerOpen ? 240 : 120),
                  1000) -
              60;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<BusViewModel>(builder: (controller) {
                    return SizedBox(
                      width: size + 60,
                      child: Scrollbar(
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: GetBuilder<DeleteManagementViewModel>(
                              builder: (_) {
                            return DataTable(
                                columnSpacing: 0,
                                dividerThickness: 0.3,
                                columns: List.generate(
                                    data.length,
                                    (index) => DataColumn(
                                        label: Container(
                                            width: size / (data.length),
                                            child: Center(
                                                child: Text(data[index].toString().tr))))),
                                rows: [
                                  ...List.generate(
                                    controller.busesMap.values.length,
                                    (index) {
                                      int expenses = 0;
                                      BusModel busModel = controller
                                          .busesMap.values
                                          .elementAt(index);
                                      for (var ex in busModel.expense ?? []) {
                                        expenses +=
                                            Get.find<ExpensesViewModel>()
                                                .allExpenses[ex]!
                                                .total;
                                      }
                                      return DataRow(
                                          color: WidgetStatePropertyAll(
                                              checkIfPendingDelete(
                                                      affectedId:
                                                          busModel.busId!)
                                                  ? Colors.redAccent.withOpacity(0.2)
                                                  : Colors.transparent),
                                          cells: [
                                            dataRowItem(size / (data.length),
                                                busModel.number.toString()),
                                            dataRowItem(size / (data.length),
                                                busModel.name.toString()),
                                            dataRowItem(size / (data.length),
                                                busModel.type.toString()),
                                            dataRowItem(
                                                size / (data.length),
                                                busModel.students!.length
                                                    .toString(), onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (builder) =>
                                                      buildStudentDialog(
                                                          busModel.students!));
                                            }),
                                            dataRowItem(
                                                size / (data.length),
                                                busModel.employees!.length
                                                    .toString(), onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (builder) =>
                                                      buildEmployeeDialog(
                                                          busModel.employees!));
                                            }),
                                            DataCell(
                                                GetBuilder<ExpensesViewModel>(
                                                    builder:
                                                        (expensesController) {
                                              return Container(
                                                width: size / (data.length),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          List<ExpensesModel>
                                                              expenses = [];
                                                          for (var expen
                                                              in busModel
                                                                      .expense ??
                                                                  []) {
                                                            expenses.add(
                                                                expensesController
                                                                        .allExpenses[
                                                                    expen]!);
                                                          }
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                buildExpensesDialog(
                                                                    expenses),
                                                          );
                                                        },
                                                        child: Text(expenses
                                                            .toString())),
                                                    IconButton(
                                                        onPressed: () {
                                                          showExpensesInputDialog(
                                                              context,
                                                              busModel.busId!);
                                                        },
                                                        icon: Icon(
                                                          Icons.add,
                                                          color: blueColor,
                                                        ))
                                                  ],
                                                ),
                                              );
                                            })),
                                            dataRowItem(
                                              size / (data.length),
                                              busModel.startDate
                                                  .toString()
                                                  .split(" ")[0],
                                            ),
                                            dataRowItem(
                                                size / (data.length), "تعديل".tr,
                                                color: Colors.green,onTap: (){
                                              showBusnputDialog(context, busModel);
                                            }),
                                            DataCell(Container(
                                                width: size / (data.length),
                                                child: IconButton(
                                                    onPressed: () {
                                                      checkIfPendingDelete(
                                                              affectedId:
                                                                  busModel
                                                                      .busId!)
                                                          ? _.returnDeleteOperation(
                                                              affectedId:
                                                                  busModel
                                                                      .busId!)
                                                          : addDeleteOperation(
                                                              collectionName:
                                                                  busesCollection,
                                                              affectedId:
                                                                  busModel
                                                                      .busId!);
                                                    },
                                                    icon: Row(
                                                      children: [
                                                        Spacer(),
                                                        Icon(
                                                          checkIfPendingDelete(
                                                                  affectedId:
                                                                      busModel
                                                                          .busId!)
                                                              ? Icons.check
                                                              : Icons.delete,
                                                          color: checkIfPendingDelete(
                                                                  affectedId:
                                                                      busModel
                                                                          .busId!)
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(checkIfPendingDelete(
                                                                affectedId:
                                                                    busModel
                                                                        .busId!)
                                                            ? "استرجاع".tr
                                                            : "حذف".tr),
                                                        Spacer(),
                                                      ],
                                                    ))))
                                          ]);
                                    },
                                  )
                                ]);
                          }),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void showExpensesInputDialog(BuildContext context, String busId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: Get.height / 2,
            width: Get.width / 1.5,
            child: ExpensesInputForm(busId: busId),
          ),
        );
      },
    );
  }

  AlertDialog buildStudentDialog(List<String> student) {
    return AlertDialog(
      backgroundColor: secondaryColor,
      actions: [
        Column(
          children: [
            Container(
              width: Get.width / 3,
              height: Get.height / 3.5,
              child: ListView.builder(
                itemCount: student.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("الاسم الكامل: "),
                      Text(
                        Get.find<StudentViewModel>()
                                .studentMap[student[index]]
                                ?.studentName
                                .toString() ??
                            'sd',
                        style: Styles.headLineStyle2,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppButton(
              text: "تم",
              onPressed: () {
                Get.back();
              },
            )
          ],
        )
      ],
    );
  }

  AlertDialog buildExpensesDialog(List<ExpensesModel> expenses) {
    return AlertDialog(
      backgroundColor: secondaryColor,
      actions: [
        Column(
          children: [
            Container(
              width: Get.width / 2.5,
              height: Get.height / 3.5,
              child: ListView.builder(padding: EdgeInsets.all(15),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(
                        width: (Get.width / 2) / 2.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("العنوان: ", style: Styles.headLineStyle3),
                            Spacer(),
                            Text(
                              expenses[index].title.toString(),
                              style: Styles.headLineStyle2,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Spacer(),
                         SizedBox(
                        width: (Get.width / 2) / 3.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Text(
                              "القيمة: ",
                              style: Styles.headLineStyle3,
                            ),
                            Spacer(),
                            Text(
                              expenses[index].total.toString(),
                              style: Styles.headLineStyle2,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppButton(
              text: "تم",
              onPressed: () {
                Get.back();
              },
            )
          ],
        )
      ],
    );
  }

  AlertDialog buildEmployeeDialog(List<String> employee) {
    return AlertDialog(
      backgroundColor: secondaryColor,
      actions: [
        SizedBox(
          height: Get.height / 2,
          child: Column(
            children: [
              Spacer(),
              Container(
                width: Get.width / 3,
                height: Get.height / 3.5,
                child: ListView.builder(
                  itemCount: employee.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("الاسم الكامل: "),
                        Text(
                          Get.find<AccountManagementViewModel>()
                                  .allAccountManagement[employee[index]]
                                  ?.fullName
                                  .toString() ??
                              'sd',
                          style: Styles.headLineStyle2,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Spacer(),
              AppButton(
                text: "تم",
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        )
      ],
    );
  }



  void showBusnputDialog(BuildContext context, dynamic bus) {
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: Get.height / 2,
            width: Get.width/1.5,
            child: BusInputForm(busModel: bus),
          ),
        );
      },
    );
  }



}
