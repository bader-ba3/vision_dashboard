import 'package:vision_dashboard/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:vision_dashboard/controller/home_controller.dart';

import '../../controller/account_management_view_model.dart';
import '../../models/account_management_model.dart';

class AccountManagementScreen extends StatefulWidget {
  AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() => _AccountManagementScreenState();
}

Map accountType = {
  "user": "مستخدم",
  "admin": "مدير",
};

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  String? role;
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AccountManagementViewModel>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
              primary: false,
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (!Responsive.isDesktop(context))
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: homeViewModel.controlMenu,
                        ),
                      if (!Responsive.isMobile(context))
                        Text(
                          "إدارة المستخدمين",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      Expanded(
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
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
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
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: DropdownButton(
                        value: role??accountType.keys.first.toString(),
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
                          role ??=accountType.keys.first;
                          AccountManagementModel model = AccountManagementModel(id: DateTime.now().millisecondsSinceEpoch.toString(), userName: name.text, password: pass.text, type: role!, serialNFC: null, isActive: true);
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
                            "Add",
                            style: TextStyle(color: Color(0xff00308F), fontSize: 22),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
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
                          "All User",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columnSpacing: defaultPadding,
                            // minWidth: 600,
                            columns: [
                              DataColumn(
                                label: Text("الاسم"),
                              ),
                              DataColumn(
                                label: Text("كامة السر"),
                              ),
                              DataColumn(
                                label: Text("الدور"),
                              ),
                              DataColumn(
                                label: Text("الحالة"),
                              ),
                              DataColumn(
                                label: Text("العمليات"),
                              ),
                            ],
                            rows: List.generate(
                              controller.allAccountManagement.keys.length,
                              (index) => workingDriverDataRow(controller.allAccountManagement.values.toList()[index], index,controller),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      }),
    );
  }

  DataRow workingDriverDataRow(AccountManagementModel accountModel, index,AccountManagementViewModel controller ){
    return DataRow(
      cells: [
        DataCell(
          Text(accountModel.userName),
        ),
        DataCell(Text(accountModel.password)),
        DataCell(Text(accountModel.type)),
        DataCell(Text(
          accountModel.isActive?"فعال":"ملغى",
          style: TextStyle(color:  accountModel.isActive? Colors.green : Colors.red),
        )),
        DataCell(ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.red),
          ),
          onPressed: () {
          controller.deleteAccount(accountModel);
          },
          child: Text("حذف الحساب"),
        )),
      ],
    );
  }
}
