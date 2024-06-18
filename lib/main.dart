import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/core/binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vision_dashboard/screens/login/login_screen.dart';

import 'package:vision_dashboard/screens/main/main_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.rtl,
      initialBinding: GetBinding(),
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'مركز رؤية التعليمي للتدريب',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Color(0xff00308F),
            displayColor: Color(0xff00308F),
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



