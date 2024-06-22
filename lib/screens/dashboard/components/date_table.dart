import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../constants.dart';


class DateTables extends StatefulWidget {
  const DateTables({
    Key? key,
  }) : super(key: key);

  @override
  State<DateTables> createState() => _DateTablesState();
}

var _selectedDay;
DateTime _focusedDay = DateTime.now();
CalendarFormat _calendarFormat = CalendarFormat.month;

class _DateTablesState extends State<DateTables> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TableCalendar(
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        weekendDays: [DateTime.sunday, DateTime.saturday],
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: TextStyle(
            color: Colors.redAccent,
          ),
          selectedDecoration: BoxDecoration(
            color: primaryColor, // قم بتحديد اللون الذي تريده
            shape: BoxShape.circle, // يمكنك تغيير الشكل هنا إذا كنت ترغب في مربع بدلاً من دائرة
          ),
          selectedTextStyle: TextStyle(
            color: Color(0xff00308F), // لون النص داخل اليوم المحدد
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: primaryColor),
          weekendStyle: TextStyle(color: primaryColor),
        ),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },
        pageJumpingEnabled: true,
        headerStyle: HeaderStyle(
          leftChevronIcon: Icon(Icons.arrow_back_ios),
          rightChevronIcon: Icon(Icons.arrow_forward_ios),
          formatButtonShowsNext: false,
          formatButtonVisible: false,
          titleCentered: true,
        ),
        currentDay: _selectedDay,
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2010),
        lastDay: DateTime.utc(2099),
      )
      ,
    );
  }
}
