import 'package:duration/duration.dart';
import 'package:duration/locale.dart';

abstract class DateFun{
  static String minutesToTime(int time){
    return  printDuration(Duration(minutes:time),locale:ArabicDurationLocale(),delimiter: " و " );
  }
  static String dateToMinAndHour(DateTime dateTime){
    return "${dateTime.hour.toString().padLeft(2,"0")}:${dateTime.minute.toString().padLeft(2,"0")}";
  }
}