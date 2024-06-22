
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/account_management_view_model.dart';

import '../../constants.dart';
import '../../controller/delete_management_view_model.dart';
import '../../controller/home_controller.dart';

import '../../models/account_management_model.dart';

import '../Widgets/header.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  final ScrollController _scrollController = ScrollController();
  List data = ["الاسم", "كامة السر", "الدور", "الحالة", "العمليات"];
  Map accountType = {
    "user": "مستخدم",
    "admin": "مدير",
  };
  String? role;
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'ادارة المستخدمين',
      ),
      body: SingleChildScrollView(
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(MediaQuery
              .sizeOf(context)
              .width - (controller.isDrawerOpen ? 240 : 120), 1000) - 60;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: GetBuilder<AccountManagementViewModel>(builder: (controller) {
              return Column(
                children: [
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
                          "اضافة مستخدمين",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,),borderRadius: BorderRadius.circular(8)),
                                  child: TextField(
                                    controller: name,
                                    decoration: InputDecoration(
                                      hintText: "اسم المستخدم",
                                      fillColor: secondaryColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,),borderRadius: BorderRadius.circular(8)),
                                  child: TextField(
                                    controller: pass,
                                    decoration: InputDecoration(
                                      hintText: "كلمة السر",
                                      fillColor: secondaryColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: DropdownButton(
                                  value: role ?? accountType.keys.first.toString(),
                                  isExpanded: true,
                                  onChanged: (_) {
                                    role = _;
                                    setState(() {});
                                  },
                                  items: accountType.entries.map((e) => DropdownMenuItem(value: e.key.toString(), child: Text(e.value.toString()))).toList(),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                role ??= accountType.keys.first;
                                AccountManagementModel model = AccountManagementModel(
                                    id: DateTime
                                        .now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    userName: name.text,
                                    password: pass.text,
                                    type: role!,
                                    serialNFC: null,
                                    isActive: true,
                                    salary: 2000,
                                    dayOfWork: 20
                                );
                                name.clear();
                                pass.clear();
                                role = null;
                                controller.addAccount(model);
                                setState(() {});
                              },
                              child: Container(
                                height: 55,
                                width: 200,
                                decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Text(
                                      "إضافة",
                                      style: TextStyle(color: Color(0xff00308F), fontSize: 22),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                        SizedBox(
                          width: size + 60,
                          child: Scrollbar(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              child: GetBuilder<DeleteManagementViewModel>(builder: (_) {
                                return DataTable(columnSpacing: 0, columns: List.generate(data.length, (index) => DataColumn(label: Container(width: size / data.length, child: Center(child: Text(data[index]))))), rows: [
                                  for (var accountModel in controller.allAccountManagement.values)
                                    DataRow(
                                        cells: [
                                          dataRowItem(size / data.length, accountModel.userName.toString()),
                                          dataRowItem(size / data.length, accountModel.password.toString()),
                                          dataRowItem(size / data.length, accountModel.type.toString()),
                                          dataRowItem(size / data.length, accountModel.isActive ? "فعال" : "ملغى",),
                                          dataRowItem(size / data.length, "حذف", color: Colors.red, onTap: () {
                                            controller.deleteAccount(accountModel);
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
