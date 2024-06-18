import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/employee_time_model.dart';
import 'package:vision_dashboard/screens/login/login_screen.dart';
import '../models/account_management_model.dart';
import '../screens/main/main_screen.dart';
import '../utils/const.dart' ;
import 'nfc/conditional_import.dart';
enum UserManagementStatus {
  first,
  login,
  block,
  auth,
}
class AccountManagementViewModel extends GetxController{
  RxMap<String,AccountManagementModel> allAccountManagement = <String,AccountManagementModel>{}.obs;
  final accountManagementFireStore = FirebaseFirestore.instance.collection(Const.accountManagementCollection).withConverter<AccountManagementModel>(
    fromFirestore: (snapshot, _) => AccountManagementModel.fromJson(snapshot.data()!),
    toFirestore: (account, _) => account.toJson(),
  );

  AccountManagementViewModel(){
    accountManagementFireStore.snapshots().listen((event) {
      allAccountManagement = Map<String,AccountManagementModel>.fromEntries(event.docs.toList().map((i)=>MapEntry(i.id.toString(), i.data()))).obs;
      update();
    },);
  }

  addAccount(AccountManagementModel accountModel){
    accountManagementFireStore.doc(accountModel.id).set(accountModel);
  }

  updateAccount(AccountManagementModel accountModel){
    accountManagementFireStore.doc(accountModel.id).update(accountModel.toJson());
  }

  deleteAccount(AccountManagementModel accountModel){
    accountManagementFireStore.doc(accountModel.id).delete();
  }

  toggleStatusAccount(AccountManagementModel accountModel){
    accountManagementFireStore.doc(accountModel.id).update({
      "isActive":!accountModel.isActive
    });
  }

  bool isSupportNfc = false;

  initNFC(bool isLogin) async {
    initNFCWorker(isLogin).then((value) {
      if(value){
        isSupportNfc= value;
        update();
      }
    },);
  }



  String? userName;
  String? password;

  String? serialNFC;
  AccountManagementModel? myUserModel;
  UserManagementStatus? userStatus ;
  void checkUserStatus() async {
    if (userName != null) {
      FirebaseFirestore.instance.collection(Const.accountManagementCollection).where('userName', isEqualTo: userName).where("password",isEqualTo: password).snapshots().listen((value) {
        if (userName == null) {
          userStatus = UserManagementStatus.first;
          Get.offAll(() => LoginScreen());
        } else if (value.docs.isNotEmpty) {
          myUserModel = AccountManagementModel.fromJson(value.docs.first.data());
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
    } 
    else if (serialNFC != null) {
      FirebaseFirestore.instance.collection(Const.accountManagementCollection).where('serialNFC', isEqualTo: serialNFC).snapshots().listen((value) {
        if (serialNFC == null) {
          userStatus = UserManagementStatus.first;
          Get.offAll(() => LoginScreen());
        } else if (value.docs.first.data()["isDisabled"]) {
          Get.snackbar("خطأ", "تم إلغاء تفعيل البطاقة");
          userStatus = UserManagementStatus.first;
          Get.offAll(() => LoginScreen());
        } else if (value.docs.isNotEmpty) {
          myUserModel = AccountManagementModel.fromJson(value.docs.first.data()!);
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
      WidgetsFlutterBinding.ensureInitialized().waitUntilFirstFrameRasterized.then((value) {
        userStatus = UserManagementStatus.first;
        Get.offAll(() => LoginScreen());
      });
    }
  }

  void signInUsingNFC(String cardId) {
    print(cardId);
    Get.offAll(()=>MainScreen());
  }
 String? loginUserPage;
  Future<void> addTime(String cardId) async {
    print(cardId);
    print("add Time");
    AccountManagementModel? user  = allAccountManagement.values.where((element) => element.serialNFC == cardId,).firstOrNull;
    if(user!=null){
      String date = DateTime.now().toString().split(" ")[0];
      if(user.employeeTime[date] == null){
        user.employeeTime[date] = EmployeeTimeModel(dayName: date, startDate: DateTime.now(), endDate: null, totalDate: null, isDayEnd: false);
      }else if( user.employeeTime[date]!.isDayEnd!){
        print("You close the day already");
      }else{
          user.employeeTime[date]!.endDate = DateTime.now();
          user.employeeTime[date]!.isDayEnd = true;
          user.employeeTime[date]!.totalDate = DateTime.now().difference(user.employeeTime[date]!.startDate!).inMinutes;
      }
      accountManagementFireStore.doc(user.id).update({
        "employeeTime":Map.fromEntries(user.employeeTime.entries.map((e) => MapEntry(e.key, e.value.toJson())).toList())
      });
      loginUserPage = user.userName;
      update();
     await Future.delayed(Duration(seconds: 4));
      loginUserPage=null;
      update();
    }else{
      print("Not found");
    }
  }

  void disposeNFC() {

  }
}

String getMyUserId(){
  return "a";
  // return Get.find<AccountManagementViewModel>().myUserModel!.id;
}