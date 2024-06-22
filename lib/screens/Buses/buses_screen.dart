
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Widgets/header.dart';
import '../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/Bus_Model.dart';
import '../../models/RecentFile.dart';
import '../../responsive.dart';
import 'Buses_Detailes.dart';
import 'line_chart_bus.dart';

class BusesScreen extends StatelessWidget {
  final List<BusModel> buses = generateRandomBuses(10);
  final ScrollController _scrollController = ScrollController();

  DataRow busDataRow(BusModel bus) {
    return DataRow(
      cells: [
        DataCell(Text(bus.name)),
        DataCell(Text(bus.number)),
        DataCell(Text(bus.type)),
        DataCell(Text(bus.employee)),
        DataCell(Text(bus.students.join(', '))),
        DataCell(Text(bus.startDate.toIso8601String())),
        DataCell(Text(bus.expense.toStringAsFixed(2))),
        DataCell(Text(bus.eventRecords.map((event) => event.body).join(', '))),
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
                      squrWidget("Bus waiting on station", "100"),
                      squrWidget("current Trip", "150"),
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
                      squrWidget("available Bus working", "50"),
                      squrWidget("stopped Bus", "300"),
                      squrWidget("Maintenance Bus", "300"),
                      squrWidget("Total Ticket Today", "2000"),
                    ],
                  ),
                ),

                /*ElevatedButton(
                  onPressed: () {
                    Get.to(BusInputForm());
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      WidgetStateProperty.all(secondaryColor),
                      padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30))),
                  child: Text(
                    "اضافة حافلة جديدة",
                    style: Styles.headLineStyle2,
                  ),
                ),*/
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
                              rows: buses.map((bus) => busDataRow(bus)).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /* SizedBox(
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
                ),*/
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

  List listRecentTrip = [
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
        DataCell(ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.blue),
          ),
          onPressed: () {

          },
          child: Text("Details"),
        )),
      ],
    );
  }

  List<({String driverName, String a, String b, String status})> listWorkingDriver = [
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Stopped"),
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Working"),
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Working"),
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Stopped"),
    (driverName: "Driver Name", a: "12", b: "3.5KM", status: "Working"),
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
      color: Colors.pink.withOpacity(0.5),
      value: 188,
      showTitle: false,
      radius: 20,
    ),
  ];

  List<PieChartSectionData> BusTicketChartSelectionData = [
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
  ];
}
