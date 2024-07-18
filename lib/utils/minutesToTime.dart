import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

abstract class DateFun{
  static String minutesToTime(int time){
    return  printDuration(Duration(minutes:time),locale:ArabicDurationLocale(),delimiter: " و " );
  }
  static String dateToMinAndHour(DateTime dateTime){
    final format = DateFormat('hh:mm a'); // تنسيق 12 ساعة
    return format.format(dateTime).tr;
    // return "${dateTime.hour.toString().padLeft(2,"0")}:${dateTime.minute.toString().padLeft(2,"0")}";
  }
}