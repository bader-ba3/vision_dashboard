import 'dart:math';

import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSecure = true;
  // AccountManagementViewModel accountManagementViewModel = Get.find<AccountManagementViewModel>();

  @override
  void initState() {
    // accountManagementViewModel.initNFC(typeNFC.login);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.locale.toString()!="en_US"?TextDirection.rtl:TextDirection.ltr,
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: GetBuilder<AccountManagementViewModel>(builder: (controller) {

          return SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(height: 100,),
                      Container(
                        width: (Get.width),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("تسجيل الدخول الى لوحة التحكم \n ".tr+"مركز رؤية التعليمي للتدريب".tr, style:

                          Get.width<500?Styles.headLineStyle2:  Styles.headLineStyle1,textAlign: TextAlign.center,),
                            // Text("مركز رؤية التعليمي للتدريب".tr, style: Styles.headLineStyle1,textAlign: TextAlign.center,),
                            SizedBox(height: 50,),
                       /*     if(controller.isSupportNfc)
                              Column(
                                children: [
                                 Text("Login Using Your Card",style: TextStyle(fontSize: 22),)
                                ],
                              )
                            else*/
                              Column(
                                children: [
                                  TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: "اسم المستخدم".tr,
                                      hintStyle: Styles.headLineStyle2,
                                      fillColor: bgColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  TextField(
                                    controller: passwordController,
                                    obscureText: isSecure,
                                    decoration: InputDecoration(
                                      hintText: "كلمة المرور".tr,
                                      hintStyle: Styles.headLineStyle2,
                                      fillColor: bgColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          isSecure=!isSecure;
                                          setState(() {});
                                        },
                                       /* onLongPressDown: (_) {
                                          isSecure = false;
                                          setState(() {});
                                        },
                                        onLongPressUp: () {
                                          isSecure = true;
                                          setState(() {});
                                        },*/
                                        child: Container(
                                          padding: EdgeInsets.all(defaultPadding * 0.75),
                                          margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Icon(Icons.remove_red_eye_sharp, size: 20, color: Color(0xff00308F),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  InkWell(
                                    onTap: () {
                                      controller.userName=nameController.text;
                                      controller.password=passwordController.text;
                                      controller.checkUserStatus();
                                      // Get.offAll(() => MainScreen());
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(defaultPadding * 0.75),
                                      // margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Center(child: Text("تسجيل الدخول".tr, style: TextStyle(fontSize: 22, color: bgColor),)),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
