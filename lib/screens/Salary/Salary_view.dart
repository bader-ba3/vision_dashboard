import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:vision_dashboard/screens/Salary/sign_view.dart';

import '../../constants.dart';
import '../../controller/account_management_view_model.dart';
import '../../controller/delete_management_view_model.dart';
import '../../controller/home_controller.dart';
import '../Widgets/AppButton.dart';
import '../Widgets/header.dart';

class SalaryView extends StatefulWidget {
  const SalaryView({super.key});

  @override
  State<SalaryView> createState() => _SalaryViewState();
}

class _SalaryViewState extends State<SalaryView> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }
  void _handleSaveButtonPressed() async {
    final data =
    await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(

                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }
  final ScrollController _scrollController = ScrollController();
  List data = [
    "User Name",
    "الاسم الكامل",
    "الحالة",
    "الراتب المستحق",
    "الراتب الكلي",
    "ساعات العمل",
    "الوظيفة",
    "العقد",
    "تاريخ البداية",
    "سجل الاحداث",
    "العمليات"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'ادارة رواتب الموظفين',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(
                  MediaQuery.sizeOf(context).width -
                      (controller.isDrawerOpen ? 240 : 120),
                  1000) -
              60;
          return Padding(
            padding: const EdgeInsets.all(8),
            child:
                GetBuilder<AccountManagementViewModel>(builder: (controller) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
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
                        SizedBox(
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
                                    columns: List.generate(
                                        data.length,
                                        (index) => DataColumn(
                                            label: Container(
                                                width: size / data.length,
                                                child: Center(
                                                    child:
                                                        Text(data[index]))))),
                                    rows: [
                                      for (var accountModel in controller
                                          .allAccountManagement.values)
                                        DataRow(cells: [
                                          dataRowItem(size / data.length,
                                              accountModel.userName.toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.fullName.toString()),
                                          dataRowItem(
                                            size / data.length,
                                            accountModel.isActive
                                                ? "فعال"
                                                : "ملغى",
                                          ),
                                          dataRowItem(size / data.length,
                                              accountModel.salary.toString()),
                                          dataRowItem(
                                              size / data.length, "1900"),
                                          dataRowItem(
                                              size / data.length,
                                              accountModel.dayOfWork
                                                  .toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.jobTitle.toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.contract.toString()),
                                          dataRowItem(
                                              size / data.length,
                                              accountModel.startDate
                                                  .toString()
                                                  .split(" ")[0]),
                                          dataRowItem(size / data.length, "عرض",
                                              color: Colors.blue, onTap: () {}),
                                          dataRowItem(size / data.length,
                                              "تسليم الراتب",
                                              color: Colors.green, onTap: () {

                                                showDialog(

                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        backgroundColor: secondaryColor,
                                                        actions: [
                                                        Container(
                                                          height: Get.height/2,
                                                          width: Get.width/2,
                                                          color: secondaryColor,
                                                          child: Column(
                                                              children: [

                                                                Text("يرجى التوقيع من قبل الموظف",style: Styles.headLineStyle1,),
                                                                Padding(
                                                                    padding: EdgeInsets.all(10),
                                                                    child: Container(
                                                                        child: SfSignaturePad(
                                                                            key: signatureGlobalKey,
                                                                            backgroundColor: Colors.white,
                                                                            strokeColor: Colors.black,
                                                                            minimumStrokeWidth: 1.0,
                                                                            maximumStrokeWidth: 4.0),
                                                                        decoration:
                                                                        BoxDecoration(border: Border.all(color: Colors.grey)))),
                                                                SizedBox(height: 10),
                                                                Row(children: <Widget>[

                                                                  AppButton(text: "حفظ", onPressed: _handleSaveButtonPressed),
                                                                  AppButton(text: "اعادة", onPressed: _handleClearButtonPressed),


                                                                ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
                                                              ],
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center),
                                                        )
                                                      ],),
                                                );

                                          }),
                                        ]),
                                    ]);
                              }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          );
        }),
      ),
    );
  }

  dataRowItem(size, text, {onTap, color}) {
    return DataCell(
      Container(
        width: size,
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
