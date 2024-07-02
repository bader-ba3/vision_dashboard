import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vision_dashboard/models/Salary_Model.dart';
import 'package:vision_dashboard/models/employee_time_model.dart';

import 'package:vision_dashboard/screens/Salary/controller/Salary_View_Model.dart';

import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/screens/login/login_screen.dart';

import 'package:vision_dashboard/utils/minutesToTime.dart';
import '../constants.dart';
import '../models/account_management_model.dart';
import '../screens/main/main_screen.dart';
import 'nfc/conditional_import.dart';

enum UserManagementStatus {
  first,
  login,
  block,
  auth,
}

class AccountManagementViewModel extends GetxController {
  RxMap<String, AccountManagementModel> allAccountManagement =
      <String, AccountManagementModel>{}.obs;
  final accountManagementFireStore = FirebaseFirestore.instance
      .collection(accountManagementCollection)
      .withConverter<AccountManagementModel>(
        fromFirestore: (snapshot, _) =>
            AccountManagementModel.fromJson(snapshot.data()!),
        toFirestore: (account, _) => account.toJson(),
      );
  final FirebaseStorage _storage = FirebaseStorage.instance;

  AccountManagementViewModel() {
  getAllEmployee();
  }
  late StreamSubscription<QuerySnapshot<AccountManagementModel>> listener;

  getAllEmployee(){
    listener= accountManagementFireStore.snapshots().listen(
          (event) {
        allAccountManagement = Map<String, AccountManagementModel>.fromEntries(
            event.docs
                .toList()
                .map((i) => MapEntry(i.id.toString(), i.data()))).obs;
        update();
      },
    );
  }

  addAccount(AccountManagementModel accountModel) {
    accountManagementFireStore.doc(accountModel.id).set(accountModel);
  }

  updateAccount(AccountManagementModel accountModel) {
    accountManagementFireStore
        .doc(accountModel.id)
        .update(accountModel.toJson());
  }

  deleteAccount(AccountManagementModel accountModel) {
    accountManagementFireStore.doc(accountModel.id).delete();
  }

  toggleStatusAccount(AccountManagementModel accountModel) {
    accountManagementFireStore
        .doc(accountModel.id)
        .update({"isActive": !accountModel.isActive});
  }

  Future<String> uploadImage(bytes, fileName) async {
    try {
      await _storage.ref(fileName).putData(bytes!.buffer.asUint8List());
      return await _storage.ref(fileName).getDownloadURL();
    } catch (e) {
      print('Error uploading signature: $e');
      return 'Error';
    }
  }

  adReceiveSalary(String accountId, String paySalary, String salaryDate,
      String constSalary, String dilaySalary, bytes) async {
    String fileName = 'signatures/$accountId/$salaryDate.png';

    uploadImage(bytes, fileName).then(
      (value) async {
        if (value != Error) {
          String salaryId = "${salaryDate} ${generateId("SALARY")}";
          await FirebaseFirestore.instance
              .collection(accountManagementCollection)
              .doc(accountId)
              .set({
            "salaryReceived": FieldValue.arrayUnion([salaryId])
          }, SetOptions(merge: true));
          Get.find<SalaryViewModel>().addSalary(SalaryModel(
            salaryId: salaryId,
            constSalary: constSalary,
            employeeId: accountId,
            dilaySalary: dilaySalary,
            paySalary: paySalary,
            signImage: fileName,
          ));
        }
      },
    );
  }

  bool isSupportNfc = false;

  initNFC(bool isLogin) async {
    initNFCWorker(isLogin).then(
      (value) {
        if (value) {
          isSupportNfc = value;
          update();
        }
      },
    );
  }

  String? userName;
  String? password;

  String? serialNFC;
  AccountManagementModel? myUserModel;
  UserManagementStatus? userStatus;

  void checkUserStatus() async {
    if (userName != null) {
      FirebaseFirestore.instance
          .collection(accountManagementCollection)
          .where('userName', isEqualTo: userName)
          .where("password", isEqualTo: password)
          .snapshots()
          .listen((value) {
        if (userName == null) {
          userStatus = UserManagementStatus.first;
          Get.offAll(() => LoginScreen());
        } else if (value.docs.isNotEmpty) {
          myUserModel =
              AccountManagementModel.fromJson(value.docs.first.data());
          userStatus = UserManagementStatus.login;
          Get.offAll(() => MainScreen());
        } else if (value.docs.isEmpty) {
          if (Get.currentRoute != "/LoginScreen") {
            userStatus = UserManagementStatus.first;
            Get.offAll(() => LoginScreen());
          } else {
            Get.snackbar("error", "not matched");
          }
          userName = null;
          serialNFC = null;
        } else {
          userStatus = null;
        }
        update();
      });
    } else if (serialNFC != null) {
      FirebaseFirestore.instance
          .collection(accountManagementCollection)
          .where('serialNFC', isEqualTo: serialNFC)
          .snapshots()
          .listen((value) {
        if (serialNFC == null) {
          userStatus = UserManagementStatus.first;
          Get.offAll(() => LoginScreen());
        } else if (value.docs.first.data()["isDisabled"]) {
          Get.snackbar("خطأ", "تم إلغاء تفعيل البطاقة");
          userStatus = UserManagementStatus.first;
          Get.offAll(() => LoginScreen());
        } else if (value.docs.isNotEmpty) {
          myUserModel =
              AccountManagementModel.fromJson(value.docs.first.data());
          userStatus = UserManagementStatus.login;
          Get.offAll(() => MainScreen());
        } else if (value.docs.isEmpty) {
          if (Get.currentRoute != "/LoginScreen") {
            userStatus = UserManagementStatus.first;
            Get.offAll(() => LoginScreen());
          } else {
            Get.snackbar("error", "not matched");
          }
          userName = null;
          password = null;
          serialNFC = null;
        } else {
          userStatus = null;
        }
        update();
      });
    } else {
      WidgetsFlutterBinding.ensureInitialized()
          .waitUntilFirstFrameRasterized
          .then((value) {
        userStatus = UserManagementStatus.first;
        Get.offAll(() => LoginScreen());
      });
    }
  }

  void signInUsingNFC(String cardId) {
    print(cardId);
    Get.offAll(() => MainScreen());
  }

  String? loginUserPage;

  Future<void> addTime(
      {String? cardId, String? userName, String? password}) async {
    bool? isLateWithReason;
    bool? isEarlierWithReason;
    int totalLate = 0;
    int totalEarlier = 0;
    TextEditingController lateReasonController = TextEditingController();
    TextEditingController earlierReasonController = TextEditingController();
    print(cardId);
    print("add Time");
    AccountManagementModel? user;
    if (cardId != null) {
      user = allAccountManagement.values
          .where(
            (element) => element.serialNFC == cardId,
          )
          .firstOrNull;
    } else {
      user = allAccountManagement.values
          .where(
            (element) =>
                element.userName == userName && element.password == password,
          )
          .firstOrNull;
    }
    if (user != null) {
      String date = DateTime.now().toString().split(" ")[0];
      print(DateTime.now().hour);
      print(DateTime.now().minute);
      if (user.employeeTime[date] == null) {
        if (DateTime.now().hour > 7 ||
            (DateTime.now().hour == 7 && DateTime.now().minute > 30)) {
          isLateWithReason = false;
          totalLate = DateTime.now()
              .difference(
                  DateTime.now().copyWith(hour: 7, minute: 30, second: 0))
              .inMinutes;
          print(totalLate);
          List listOfTotalLate = user.employeeTime.values
              .map(
                (e) => e.totalLate ?? 0,
              )
              .toList();

          int AllTotalLate = listOfTotalLate.isEmpty
              ? 0
              :listOfTotalLate.length>2?listOfTotalLate[0]: listOfTotalLate.reduce(
                    (value, element) => int.parse(value) + int.parse(element),
                  ) +
                  totalLate.toInt();
          await Get.defaultDialog(
              barrierDismissible: false,
              backgroundColor: Colors.white,
              title: "أنت متأخر ",
              content: Container(
                height: Get.width / 4,
                width: Get.width / 3,
                child: StatefulBuilder(
                  builder: (context, setstate) {
                    return Column(
                      children: [
                        Text("تأخرت اليوم " + DateFun.minutesToTime(totalLate)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("مجموع التأخر " +
                            DateFun.minutesToTime(AllTotalLate)),
                        Row(
                          children: [
                            Checkbox(
                                value: !isLateWithReason!,
                                onChanged: (_) {
                                  isLateWithReason = !_!;
                                  setstate(() {});
                                }),
                            Text("تأخر غير مبرر")
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: isLateWithReason,
                                onChanged: (_) {
                                  isLateWithReason = _!;
                                  setstate(() {});
                                }),
                            Text("تأخر مبرر"),
                          ],
                        ),
                        Expanded(
                          child: TextFormField(
                            enabled: isLateWithReason,
                            decoration: InputDecoration(hintText: "سبب التأخر"),
                            controller: lateReasonController,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              actions: [
                AppButton(
                    text: "موافق",
                    onPressed: () {
                      Get.back();
                    })
              ]);
        }
        user.employeeTime[date] = EmployeeTimeModel(
            dayName: date,
            startDate: DateTime.now(),
            endDate: null,
            totalDate: null,
            isDayEnd: false,
            isLateWithReason: isLateWithReason,
            reasonOfLate: lateReasonController.text,
            totalLate: totalLate,
            isEarlierWithReason: null,
            reasonOfEarlier: null,
            totalEarlier: null);
        loginUserPage = "اهلا بك " + user.userName;
      } else if (user.employeeTime[date]!.isDayEnd!) {
        loginUserPage = "لقد قمت بالخروج بالفعل " + user.userName;
        print("You close the day already");
      } else {
        if (DateTime.now().hour < 14 ||
            (DateTime.now().hour == 14 && DateTime.now().minute < 30)) {
          isEarlierWithReason = false;
          totalEarlier = DateTime.now()
              .copyWith(hour: 14, minute: 30, second: 0)
              .difference(DateTime.now())
              .inMinutes;
          print(totalEarlier);
          int AllTotalEarlier = (user.employeeTime.values
                      .map(
                        (e) => e.totalEarlier ?? 0,
                      )
                      .reduce(
                        (value, element) => value + element,
                      ) +
                  totalEarlier)
              .toInt();

          await Get.defaultDialog(
              barrierDismissible: false,
              backgroundColor: Colors.white,
              title: "لقد خرجت مبكرا ",
              content: Container(
                height: Get.width / 4,
                width: Get.width / 3,
                child: StatefulBuilder(
                  builder: (context, setstate) {
                    return Column(
                      children: [
                        Text("خرجبت مبكرا اليوم " +
                            DateFun.minutesToTime(totalEarlier)),
                        Text("مجموع الخروج المبكر " +
                            DateFun.minutesToTime(AllTotalEarlier)),
                        Row(
                          children: [
                            Checkbox(
                                value: !isEarlierWithReason!,
                                onChanged: (_) {
                                  isEarlierWithReason = !_!;
                                  setstate(() {});
                                }),
                            Text("خروج مبكر غير مبرر")
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: isEarlierWithReason,
                                onChanged: (_) {
                                  isEarlierWithReason = _!;
                                  setstate(() {});
                                }),
                            Text("خروج مبكر مبرر"),
                          ],
                        ),
                        Expanded(
                          child: TextFormField(
                            enabled: isEarlierWithReason,
                            decoration:
                                InputDecoration(hintText: "سبب الخروج المبكر"),
                            controller: earlierReasonController,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("موافق"))
              ]);
        }
        if (isEarlierWithReason != null) {
          user.employeeTime[date]!.isEarlierWithReason = isEarlierWithReason;
          user.employeeTime[date]!.totalEarlier = totalEarlier;
          user.employeeTime[date]!.reasonOfEarlier =
              earlierReasonController.text;
        }
        loginUserPage = "وداعا " + user.userName;
        user.employeeTime[date]!.endDate = DateTime.now();
        user.employeeTime[date]!.isDayEnd = true;
        user.employeeTime[date]!.totalDate = DateTime.now()
            .difference(user.employeeTime[date]!.startDate!)
            .inMinutes;
      }
      accountManagementFireStore.doc(user.id).update({
        "employeeTime": Map.fromEntries(user.employeeTime.entries
            .map((e) => MapEntry(e.key, e.value.toJson()))
            .toList())
      });

      update();
      await Future.delayed(Duration(seconds: 4));
      loginUserPage = null;
      update();
    } else {
      print("Not found");
    }
  }

  void disposeNFC() {}



   getOldData(String value) {
  FirebaseFirestore.instance.collection(archiveCollection).doc(value).collection(accountManagementCollection).get().then(
          (event) {
        allAccountManagement = Map<String, AccountManagementModel>.fromEntries(
            event.docs
                .toList()
                .map((i) => MapEntry(i.id.toString(),AccountManagementModel.fromJson(i.data())  ))).obs;
        listener.cancel();
        update();
      },
    );
  }
}

String getMyUserId() {
  return "a";
  // return Get.find<AccountManagementViewModel>().myUserModel!.id;
}
