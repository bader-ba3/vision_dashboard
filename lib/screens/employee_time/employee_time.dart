import 'package:accordion/accordion.dart';
import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/main/main_screen.dart';
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

  @override
  Widget build(BuildContext context) {
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
                              Text(
                                "تسجيل الدوام",
                                style: Styles.headLineStyle1,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              if (controller.isSupportNfc)
                                Column(
                                  children: [
                                    Text(
                                      "سجل الدخول باستخدام بطاقتك",
                                      style: TextStyle(fontSize: 22),
                                    )
                                  ],
                                )
                              else
                                Column(
                                  children: [
                                    TextField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        hintText: "اسم المستخدم",
                                        hintStyle: Styles.headLineStyle2,
                                        fillColor: bgColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    TextField(
                                      controller: passwordController,
                                      obscureText: isSecure,
                                      decoration: InputDecoration(
                                        hintText: "كلمة المرور",
                                        hintStyle: Styles.headLineStyle2,
                                        fillColor: bgColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onLongPressDown: (_) {
                                            isSecure = false;
                                            setState(() {});
                                          },
                                          onLongPressUp: () {
                                            isSecure = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(defaultPadding * 0.75),
                                            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: Icon(
                                              Icons.remove_red_eye_sharp,
                                              size: 20,
                                              color: Color(0xff00308F),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(defaultPadding * 0.75),
                                        // margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "تسجيل الدخول",
                                          style: TextStyle(fontSize: 22, color: bgColor),
                                        )),
                                      ),
                                    ),
                                  ],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                )),
                            Container(
                              width: Get.width * 0.125,
                              child: Text(
                                "اجمالي التأخير ",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // Text("اجمالي الخصم : " +((totalTime / 60 ).floor()*0.5).toString()+" ايام",style: TextStyle(fontSize: 20),),
                            Container(
                              width: Get.width * 0.125,
                              child: Text(
                                "اجمالي خصم ",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: Get.width * 0.125,
                              child: Text(
                                "الراتب المقطوع ",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: Get.width * 0.125,
                              child: Text(
                                "الراتب المستحق ",
                                style: TextStyle(fontSize: 20),
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
                        Accordion(
                          paddingListTop: 0,
                          headerBackgroundColor: Colors.grey,
                        contentBorderColor: Colors.white,
                        rightIcon: Icon(Icons.keyboard_arrow_down,color: Colors.black,),
                        scaleWhenAnimating:false,
                          children: [
                            for (var i in controller.allAccountManagement.values)
                              AccordionSection(
                                isOpen: true,
                                header: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Builder(
                                    builder: (_) {
                                      int totalLate = i.employeeTime.values.map((e) => e.totalLate ?? 0,).reduce((value, element) => value + element);
                                      int totalEarlier = i.employeeTime.values.map((e) => e.totalEarlier ?? 0,).reduce((value, element) => value + element);
                                      int totalTime = totalLate + totalEarlier;
                                      return SizedBox(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                                width: Get.width * 0.125,
                                                child: Text(
                                                  i.userName,
                                                  style: TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                )),
                                            Container(
                                                width: Get.width * 0.125,
                                                child: Text(
                                                  DateFun.minutesToTime(totalTime),
                                                  style: TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                )),
                                            // Text("اجمالي الخصم : " +((totalTime / 60 ).floor()*0.5).toString()+" ايام",style: TextStyle(fontSize: 20),),
                                            Container(
                                                width: Get.width * 0.125,
                                                child: Text(
                                                  ((i.salary! / i.dayOfWork!) * ((totalTime / 60).floor() * 0.5)).toString(),
                                                  style: TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                )),
                                            Container(
                                                width: Get.width * 0.125,
                                                child: Text(
                                                  (i.salary!).toString(),
                                                  style: TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                )),
                                            Container(
                                                width: Get.width * 0.125,
                                                child: Text(
                                                  ((i.salary!) - ((i.salary! / i.dayOfWork!) * ((totalTime / 60).floor() * 0.5))).toString(),
                                                  style: TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ],
                                        ),
                                      );
                                    }
                                  ),
                                ),
                                content: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: MediaQuery.sizeOf(context).width,
                                  // decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                child: DataTable(
                                                    columns: [
                                                  DataColumn(label: Text("اليوم")),
                                                  DataColumn(label: Text("الدخول")),
                                                  DataColumn(label: Text("الخروج")),
                                                  DataColumn(label: Text("المجموع")),
                                                  DataColumn(label: Text("تأخر بالدخول")),
                                                  DataColumn(label: Text("مجموع التأخير")),
                                                  DataColumn(label: Text("عرض المبرر")),
                                                  DataColumn(label: Text("خروج المبكر")),
                                                  DataColumn(label: Text("مجموع الخروج المبكر")),
                                                  DataColumn(label: Text("عرض المبرر")),
                                                ], rows: [
                                                  for (var j in i.employeeTime.values)
                                                    DataRow(
                                                        cells: [
                                                      DataCell(Text( j.dayName.toString()),),
                                                      DataCell(Text(DateFun.dateToMinAndHour(j.startDate!), textDirection: TextDirection.ltr,),),
                                                      DataCell(Text((j.endDate == null ? "" : DateFun.dateToMinAndHour(j.endDate!)),
                                                        textDirection: TextDirection.ltr,
                                                      ),),
                                                      DataCell( Text( DateFun.minutesToTime(j.totalDate ?? 0)),),
                                                      DataCell( Text((j.isLateWithReason == null ?"": (j.isLateWithReason! ? "مع مبرر" : "بدون مبرر")))),
                                                      DataCell( Text(  j.totalLate == null ||j.totalLate == 0?"": DateFun.minutesToTime(j.totalLate!))),
                                                      DataCell( TextButton(
                                                          onPressed: (){
                                                            Get.defaultDialog(
                                                                title: "المبرر",
                                                                backgroundColor: Colors.white, content: Container(
                                                              height: Get.height/2,
                                                              width:  Get.height/2,
                                                              child: Text(j.reasonOfLate.toString()),
                                                            ));
                                                          },
                                                          child: Text(j.reasonOfLate !=null && j.reasonOfLate!=""?"عرض":""))),
                                                      DataCell( Text((j.isEarlierWithReason == null ?"": (j.isEarlierWithReason! ? "مع مبرر" : "بدون مبرر")))),
                                                      DataCell( Text( j.totalEarlier == null||j.totalEarlier == 0 ?"":DateFun.minutesToTime(j.totalEarlier!))),
                                                      DataCell( TextButton(
                                                          onPressed: (){
                                                            Get.defaultDialog(
                                                                title: "المبرر",
                                                                backgroundColor: Colors.white, content: Container(
                                                              height: Get.height/2,
                                                              width:  Get.height/2,
                                                                  child: Text(j.reasonOfEarlier.toString()),
                                                                ));
                                                          },
                                                          child: Text(j.reasonOfEarlier !=null&& j.reasonOfEarlier!=""?"عرض":""))),

                                                    ]),
                                                ]),
                                              ),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Text("اليوم " + j.dayName.toString()),
                                              //     Text(
                                              //       "الدخول " + DateFun.dateToMinAndHour(j.startDate!),
                                              //       textDirection: TextDirection.ltr,
                                              //     ),
                                              //     Text(
                                              //       "الخروج: " + (j.endDate == null ? "لم يخرج بعد" : DateFun.dateToMinAndHour(j.endDate!)),
                                              //       textDirection: TextDirection.ltr,
                                              //     ),
                                              //     Text("المجموع: " + DateFun.minutesToTime(j.totalDate ?? 0)),
                                              //     SizedBox(
                                              //       width: 30,
                                              //     ),
                                              //   ],
                                              // ),
                                              // if (j.isLateWithReason != null)
                                              //   Column(
                                              //     children: [
                                              //       SizedBox(
                                              //         height: 20,
                                              //       ),
                                              //       Row(
                                              //         children: [
                                              //           if (j.isLateWithReason != null) SizedBox(width: 130, child: Text("تأخر بالدخول " + (j.isLateWithReason! ? "مع مبرر" : "بدون مبرر"))),
                                              //           SizedBox(
                                              //             width: 30,
                                              //           ),
                                              //           if (j.totalLate != null && j.totalLate != 0) SizedBox(width: 250, child: Text("مجموع التأخير " + DateFun.minutesToTime(j.totalLate!))),
                                              //           SizedBox(
                                              //             width: 30,
                                              //           ),
                                              //           if (j.isLateWithReason != null && j.isLateWithReason!)
                                              //             ElevatedButton(
                                              //                 onPressed: () {
                                              //                   Get.defaultDialog(backgroundColor: Colors.white, content: Text(j.reasonOfLate.toString()));
                                              //                 },
                                              //                 child: Text("عرض المبرر"))
                                              //         ],
                                              //       ),
                                              //     ],
                                              //   ),
                                              // if (j.isEarlierWithReason != null)
                                              //   Column(
                                              //     children: [
                                              //       SizedBox(
                                              //         height: 20,
                                              //       ),
                                              //       Row(
                                              //         children: [
                                              //           if (j.isEarlierWithReason != null) SizedBox(width: 130, child: Text("خروج مبكر " + (j.isEarlierWithReason! ? "مع مبرر" : "بدون مبرر"))),
                                              //           SizedBox(
                                              //             width: 30,
                                              //           ),
                                              //           if (j.totalEarlier != null && j.totalEarlier != 0) SizedBox(width: 250, child: Text("مجموع الخروج مبكر " + DateFun.minutesToTime(j.totalEarlier!))),
                                              //           SizedBox(
                                              //             width: 30,
                                              //           ),
                                              //           if (j.isEarlierWithReason != null && j.isEarlierWithReason!)
                                              //             ElevatedButton(
                                              //                 onPressed: () {
                                              //                   Get.defaultDialog(backgroundColor: Colors.white, content: Text(j.reasonOfEarlier.toString()));
                                              //                 },
                                              //                 child: Text("عرض المبرر"))
                                              //         ],
                                              //       ),
                                              //     ],
                                              //   ),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              // Container(
                                              //   height: 2,
                                              //   color: Colors.grey.withOpacity(0.5),
                                              // ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            ],
          ),
        ),
      );
    });
  }
}
