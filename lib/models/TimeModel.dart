import 'package:intl/intl.dart';

class TimesModel {
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final int seconds;
  final int milliSeconds;
  final DateTime dateTime;
  final String date;
  final String time;
  final String timeZone;
  final String dayOfWeek;
  final bool dstActive;

  TimesModel({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.seconds,
    required this.milliSeconds,
    required this.dateTime,
    required this.date,
    required this.time,
    required this.timeZone,
    required this.dayOfWeek,
    required this.dstActive,
  });

  factory TimesModel.fromJson(Map<String, dynamic> json) {
    return TimesModel(
      year: json['year'],
      month: json['month'],
      day: json['day'],
      // day: 19,
      hour: /*json['hour']*/   true  ?8:  14,
      minute: /*json['minute']*/ true ?45:  01,
      seconds: json['seconds'],
      milliSeconds: json['milliSeconds'],
      dateTime: DateTime.parse(json['dateTime']),
      date: json['date'],
      time: json['time'],
      timeZone: json['timeZone'],
      dayOfWeek: json['dayOfWeek'],
      dstActive: json['dstActive'],
    );
  }
  String get formattedTime {
    final dateTime = DateTime(year, month, day,/* hour, minute, seconds, milliSeconds*/);
    final format = DateFormat('yyyy-MM-dd');
    return format.format(dateTime);
  }
  bool isAfter(int hours,int mints) {
    final dateTime = DateTime(year, month, day, hour, minute, seconds, milliSeconds);
    final targetTime = DateTime(year, month, day, hours, mints);
    return dateTime.isAfter(targetTime);
  }
  bool isBefore(int hours,int mints) {
    final dateTime = DateTime(year, month, day, hour, minute, seconds, milliSeconds);
    final targetTime = DateTime(year, month, day, hours, mints);
    return dateTime.isBefore(targetTime);
  }

}