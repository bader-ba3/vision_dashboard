import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';
import 'package:vision_dashboard/screens/account_management/Controller/Min_View_Model.dart';

import '../../constants.dart';
import '../../controller/delete_management_view_model.dart';
import '../../controller/home_controller.dart';


import '../Widgets/header.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  final ScrollController _scrollController = ScrollController();
  List data = [
    "User Name",
    "الاسم الكامل",
    "كامة السر",
    "الدور",
    "الحالة",
    "رقم الموبايل",
    "العنوان",
    "الجنسية",
    "الجنس",
    "العمر",
    "الوظيفة",
    "العقد",
    "الصفوف",
    "تاريخ البداية",
    "سجل الاحداث",
    "العمليات"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'ادارة المنصة',
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
            padding: const EdgeInsets.all(15),
            child:
                GetBuilder<AccountManagementViewModel>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: defaultPadding,
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
                                    columnSpacing: 25,
                                    columns: List.generate(
                                        data.length,
                                        (index) => DataColumn(
                                            label: Container(
                                                width: size / data.length+10,
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
                                          dataRowItem(size / data.length,
                                              accountModel.password.toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.type.toString()),
                                          dataRowItem(
                                            size / data.length,
                                            accountModel.isActive
                                                ? "فعال"
                                                : "ملغى",
                                          ),
                                          dataRowItem(
                                              size / data.length,
                                              accountModel.mobileNumber
                                                  .toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.address.toString()),
                                          dataRowItem(
                                              size / data.length,
                                              accountModel.nationality
                                                  .toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.gender.toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.age.toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.jobTitle.toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.contract.toString()),
                                          dataRowItem(size / data.length,
                                              accountModel.bus.toString()),
                                          dataRowItem(
                                              size / data.length,
                                              accountModel.startDate
                                                  .toString()
                                                  .split(" ")[0]),
                                          dataRowItem(size / data.length, "عرض",
                                              color: Colors.teal, onTap: () {}),
                                          dataRowItem(size / data.length, "حذف",
                                              color: Colors.red, onTap: () {
                                            if(enableUpdate)
                                            controller
                                                .deleteAccount(accountModel);
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

                  SizedBox(
                    height: defaultPadding*2,
                  ),
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: GetBuilder<MinViewModel>(
                        builder: (controller) {
                          return Column(
                            children: [
                              CustomDropDown(value: 'الافتراضي', listValue:controller.allArchive.map((e) => e.toString(),).toList(), label: "السنة المختارة", onChange: (value) {


                                if(value!=null)
                                { if(value!="الافتراضي") {
                                  controller.getOldData(value);
                                  enableUpdate = false;
                                  controller.update();
                                } else{
                                  controller.getDefaultData();
                                  enableUpdate = true;
                                  controller.update();

                                }

                                }
                              },

                              ),
                              SizedBox(
                                height: defaultPadding*2,
                              ),
                              Wrap(
                                runSpacing: 20,
                                alignment: WrapAlignment.spaceEvenly,
                                spacing: 50,
                                children: [
                                  AppButton(text: "ارشفة البيانات الحالية", onPressed: (){
                                    controller.archive();

                                  }),
                                  AppButton(text: "تصفير البيانات الحالية", onPressed: (){
                                    controller.archive();

                                  }),
                                ],
                              ),
                            ],
                          );
                        }
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
