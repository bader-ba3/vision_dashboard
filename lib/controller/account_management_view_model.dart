import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/login/login_screen.dart';

import '../models/account_management_model.dart';
import '../screens/main/main_screen.dart';
import '../utils/const.dart';

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

  initNFC() async {

    // var a = await js.context.callMethod(
    //   'initNFC',
    // );
    // if (a == "ok") {
    //   isSupportNfc = true;
    // } else {
    //   isSupportNfc = false;
    // }
    // update();
    // window.addEventListener("message", (event) {
    //   var state = js.JsObject.fromBrowserObject(js.context['state']);
    //   print(state['data']);
    //   String serialCode = state['data'].toString();
    //   signInUsingNFC(serialCode);
    // });

  }

  void signInUsingNFC(String serialCode) {
    Get.offAll(() => MainScreen());
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
}

String getMyUserId(){
  return "a";
  // return Get.find<AccountManagementViewModel>().myUserModel!.id;
}