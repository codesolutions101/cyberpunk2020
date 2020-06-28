import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/const.dart';
import 'package:table_calendar/table_calendar.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> with TickerProviderStateMixin {
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return buildTableCalendarWithBuilders();
  }

  Widget buildTableCalendarWithBuilders() {
    return TableCalendar(
//      locale: 'pl_PL',
      headerVisible: true,
      calendarController: _calendarController,
      holidays: _holidays,
      rowHeight: 50,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
//        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
        renderDaysOfWeek: true,
        holidayStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
        outsideHolidayStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
        outsideStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
        outsideWeekendStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
        todayStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
        weekdayStyle: GoogleFonts.orbitron(color: Color(0xffabd0d1)),
        selectedStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
        unavailableStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
        weekdayStyle: GoogleFonts.orbitron(color: Color(0xffabd0d1)),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
        titleTextStyle: GoogleFonts.orbitron(color: AppColor.themeColor),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: AppColor.themeColor,
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: GoogleFonts.orbitron(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.white70,
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: GoogleFonts.orbitron(fontSize: 16.0, color: Colors.red),
            ),
          );
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }
}
