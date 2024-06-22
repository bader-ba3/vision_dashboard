
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xff3E96F4);
const secondaryColor = Color(0xffCCC7BF);
const blueColor = Color(0xff00308F);
const bgColor = Color(0xffF6F6F4);  // تخفيف لون الخلفية
//Color(0xff3d0312)
//Color(0xff7e0303)
//Color(0xffc89665)
const defaultPadding = 16.0;
List<String>  employeeName =
["",
  'أحمد الأيوبي', 'محمد الأسدي', 'علي البغدادي', 'حسين الكرمي', 'عمر النجار', 'يوسف الراوي',
  'إبراهيم الحسيني', 'خالد الزبيدي', 'عبدالله العطار', 'سعيد الحداد', 'طارق البصري', 'ياسر الزهراني',
  'سامي الشمري', 'ماجد القيسي', 'عماد السعدي', 'فهد العتيبي', 'سليمان الجبوري', 'أنس الفارسي',
  'بسام الزهيري', 'جمال التميمي', 'هيثم الهاشمي', 'رامي الشميري', 'نادر العدني', ''
];
String generateId(String type) {
  var _ = DateTime.now().microsecondsSinceEpoch.toString();
  return "$type$_";
}
const String parentsCollection='Parents';
const String examsCollection='Exams';
class Styles {


  static Color textColor = primaryColor;


  static TextStyle textStyle =
  GoogleFonts.cairo(color: textColor, fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle headLineStyle1 =
  GoogleFonts.cairo(fontSize: 26, color: textColor, fontWeight: FontWeight.bold);

  static TextStyle headLineStyle2 =
  GoogleFonts.cairo(fontSize: 21, color: textColor, fontWeight: FontWeight.bold);

  static TextStyle headLineStyle3 = GoogleFonts.cairo(
      fontSize: 17, color: Colors.grey.shade500, fontWeight: FontWeight.w500);

  static TextStyle headLineStyle4 = GoogleFonts.cairo(
      fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
}

/*
import 'package:flutter/material.dart';

const primaryColor = Color(0xffc89665);
const secondaryColor = Color(0xff3d0312);
const bgColor = Color(0xff7e0303);
//Color(0xff3d0312)
//Color(0xff7e0303)
//Color(0xffc89665)
const defaultPadding = 16.0;
*/
