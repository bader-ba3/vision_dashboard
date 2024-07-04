import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:vision_dashboard/Translate/App_Translation.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/core/binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:vision_dashboard/screens/main/main_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      translationsKeys: AppTranslation.translationKes,
      locale: /*Get.deviceLocale*/const Locale("ar","ar"),
      fallbackLocale: const Locale("ar","ar"),
      textDirection:Get.locale.toString()!="en_US"?TextDirection.rtl:TextDirection.ltr,
      initialBinding: GetBinding(),
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'مركز رؤية التعليمي للتدريب',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        canvasColor: secondaryColor,
      ),
      home: MainScreen(),
      // home: LoginScreen(),
      // home: LoginScreen(),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}



