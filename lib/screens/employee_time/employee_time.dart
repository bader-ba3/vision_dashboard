import 'dart:math';

import 'package:accordion/accordion.dart';

import 'package:vision_dashboard/controller/account_management_view_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../utils/minutesToTime.dart';

class EmployeeTimeView extends StatefulWidget {
  @override
  State<EmployeeTimeView> createState() => _EmployeeTimeViewState();
}

class _EmployeeTimeViewState extends State<EmployeeTimeView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSecure = true;
  AccountManagementViewModel accountManagementViewModel = Get.find<AccountManagementViewModel>();

  @override
  void initState() {
    accountManagementViewModel.initNFC(false);
    super.initState();
  }

  @override
  void dispose() {
    accountManagementViewModel.disposeNFC();
    super.dispose();
  }

  bool isShowLogin = true;
  List<String> data = ["اليوم","الدخول","الخروج","المجموع","تأخر بالدخول"," التأخير","عرض المبرر","خروج المبكر"," الخروج المبكر","عرض المبرر"];

  @override
  Widget build(BuildContext context) {
    double size = max(MediaQuery.sizeOf(context).width - 300, 1000);
    return GetBuilder<AccountManagementViewModel>(builder: (controller) {
      return SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade300,
                ),
                width: MediaQuery.sizeOf(context).width * 0.7,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              isShowLogin = true;
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.sizeOf(context).width * 0.35,
                              decoration: BoxDecoration(
                                  color: isShowLogin ? Colors.blueAccent.shade700 : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              child: Center(
                                  child: Text(
                                "تسجيل دخول الموظف",
                                style: TextStyle(color: isShowLogin ? Colors.white : Colors.black),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              isShowLogin = false;
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.sizeOf(context).width * 0.35,
                              decoration: BoxDecoration(
                                  color: isShowLogin ? Colors.transparent : Colors.blueAccent.shade700,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )),
                              child: Center(
                                  child: Text(
                                "عرض تفاصيل دوام الموظفين",
                                style: TextStyle(color: isShowLogin ? Colors.black : Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (isShowLogin)
                Expanded(
                  child: Container(
                    width: 400,
                    child: controller.loginUserPage != null
                        ? Center(
                            child: Text(
                              controller.loginUserPage.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (controller.isSupportNfc)
                                Column(
                                  children: [
                                    Text(
                                      "تسجيل الدوام",
                                      style: Styles.headLineStyle1,
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      "سجل الدخول باستخدام بطاقتك",
                                      style: TextStyle(fontSize: 22),
                                    )
                                  ],
                                )
                              else
                                Container(
                                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      "هذا الجهاز لا يحتوي قارئ NFC",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                  ),
                )
              else
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: Get.width * 0.125,
                                  child: Text(
                                    "الموظف ",
                                    style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                width: Get.width * 0.125,
                                child: Text(
                                  "اجمالي التأخير ",
                                  style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Text("اجمالي الخصم : " +((totalTime / 60 ).floor()*0.5).toString()+" ايام",style: TextStyle(fontSize: 20),),
                              Container(
                                width: Get.width * 0.125,
                                child: Text(
                                  "اجمالي الخصم ",
                                  style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.125,
                                child: Text(
                                  "الراتب المقطوع ",
                                  style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.125,
                                child: Text(
                                  "الراتب المستحق ",
                                  style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 5,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7.0),
                            child: Accordion(
                              paddingListTop: 0,
                              disableScrolling: true,
                              headerBackgroundColor: Colors.white,
                              headerBackgroundColorOpened: Colors.grey,
                              contentBorderColor: Colors.white,
                              paddingListHorizontal: 0,
                              rightIcon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              scaleWhenAnimating: false,
                              children: [
                                for (var i in controller.allAccountManagement.values)
                                  AccordionSection(
                                    isOpen: true,
                                    header: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Builder(builder: (_) {
                                        int totalLate = i.employeeTime.isEmpty
                                            ? 0
                                            : i.employeeTime.values
                                                .map(
                                                  (e) => e.totalLate ?? 0,
                                                )
                                                .toList()
                                                .reduce((value, element) => value + element);
                                        int totalEarlier = i.employeeTime.isEmpty
                                            ? 0
                                            : i.employeeTime.values
                                                .map(
                                                  (e) => e.totalEarlier ?? 0,
                                                )
                                                .toList()
                                                .reduce((value, element) => value + element);
                                        int totalTime = totalLate + totalEarlier;
                                        return SizedBox(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  width: Get.width * 0.125,
                                                  child: Text(
                                                    i.userName,
                                                    style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Container(
                                                  width: Get.width * 0.125,
                                                  child: Text(
                                                    DateFun.minutesToTime(totalTime),
                                                    style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              // Text("اجمالي الخصم : " +((totalTime / 60 ).floor()*0.5).toString()+" ايام",style: TextStyle(fontSize: 20),),
                                              Container(
                                                  width: Get.width * 0.125,
                                                  child: Text(
                                                    ((i.salary! / i.dayOfWork!) * ((totalTime / 60).floor() * 0.5)).toString(),
                                                    style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Container(
                                                  width: Get.width * 0.125,
                                                  child: Text(
                                                    (i.salary!).toString(),
                                                    style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Container(
                                                  width: Get.width * 0.125,
                                                  child: Text(
                                                    ((i.salary!) - ((i.salary! / i.dayOfWork!) * ((totalTime / 60).floor() * 0.5))).toString(),
                                                    style: TextStyle(fontSize: Get.width < 700 ? 16 : 20),
                                                    textAlign: TextAlign.center,
                                                  )),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    content: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(columnSpacing: 0, columns:
                                      List.generate(data.length,(index)=> DataColumn(label: Container(width: size / data.length, child: Center(child: Text(data[index]))))),
                                          rows: [
                                        for (var j in i.employeeTime.values)
                                          DataRow(cells: [
                                            dataRowItem(size / data.length, j.dayName.toString()),
                                            dataRowItem(size / data.length, DateFun.dateToMinAndHour(j.startDate!)),
                                            dataRowItem(size / data.length, (j.endDate == null ? "" : DateFun.dateToMinAndHour(j.endDate!))),
                                            dataRowItem(size / data.length, DateFun.minutesToTime(j.totalDate ?? 0)),
                                            dataRowItem(size / data.length, (j.isLateWithReason == null ? "" : (j.isLateWithReason! ? "مع مبرر" : "بدون مبرر"))),
                                            dataRowItem(size / data.length, j.totalLate == null || j.totalLate == 0 ? "" : DateFun.minutesToTime(j.totalLate!)),
                                            dataRowItem(size / data.length, j.reasonOfLate != null && j.reasonOfLate != "" ? "عرض" : "", onTap: () {
                                              Get.defaultDialog(
                                                  title: "المبرر",
                                                  backgroundColor: Colors.white,
                                                  content: Container(
                                                    height: Get.height / 2,
                                                    width: Get.height / 2,
                                                    child: Text(j.reasonOfLate.toString()),
                                                  ));
                                            }, color: Colors.teal),
                                            dataRowItem(size / data.length, (j.isEarlierWithReason == null ? "" : (j.isEarlierWithReason! ? "مع مبرر" : "بدون مبرر"))),
                                            dataRowItem(size / data.length, j.totalEarlier == null || j.totalEarlier == 0 ? "" : DateFun.minutesToTime(j.totalEarlier!)),
                                            dataRowItem(size / data.length, j.reasonOfEarlier != null && j.reasonOfEarlier != "" ? "عرض" : "", onTap: () {
                                              Get.defaultDialog(
                                                  title: "المبرر",
                                                  backgroundColor: Colors.white,
                                                  content: Container(
                                                    height: Get.height / 2,
                                                    width: Get.height / 2,
                                                    child: Text(j.reasonOfEarlier.toString()),
                                                  ));
                                            }, color: Colors.teal),
                                          ]),
                                      ]),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  dataRowItem(size, text, {onTap, color}) {
    return DataCell(
      Container(
        width: size ,
        child: InkWell(
            onTap: onTap,
            child: Center(
                child: Text(
              text,
              textAlign: TextAlign.center,
              style: color == null ? null : TextStyle(color: color),
            ))),
      ),
    );
  }
}
