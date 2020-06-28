import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/const.dart';
import 'package:js/js.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather/weather_library.dart';
import 'locationJs.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController controller1;
  AnimationController controller2;
  AnimationController controller3;
  AnimationController controller4;
  TabController tabController;

  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  WeatherStation ws;
  var lat, lon;
  List<Weather> _data = [];

  @override
  void initState() {
    super.initState();
    ws = new WeatherStation(key);
    _getCurrentLocation();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    controller3 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    controller4 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    tabController = TabController(length: 3, vsync: this);

    ////mamun
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  _getCurrentLocation() async {
    if (kIsWeb) {
      getCurrentPosition(allowInterop((pos) => success(pos)));
    }
  }

  success(pos) {
    try {
      lat = pos.coords.latitude;
      lon = pos.coords.longitude;
      queryWeather();
    } catch (ex) {
      print("Exception thrown : " + ex.toString());
    }
  }

  void queryWeather() async {
    Weather weather = await ws.currentWeather(lat, lon);
    setState(() {
      _data = [weather];
    });
  }

  Widget buildTableCalendarWithBuilders() {
    return TableCalendar(
//      locale: 'pl_PL',
      headerVisible: false,
      calendarController: _calendarController,
      events: _events,
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
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.black12,
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: _buildEventsMarker(date, events),
                ),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
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

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: MediaQuery.of(context).size.width,
      height: 16.0,
      child: Center(
        child: Text(
          '${events[0]}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  int currentTab = 0;

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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Hack2020'),
      ),
      body: Container(
        width: double.infinity,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: [
                //Left Icons
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, top: 50),
                  child: SingleChildScrollView(
                    child: Container(
                      width: 200,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller1.reverse(
                                  from: controller1.value == 0.0
                                      ? 1.0
                                      : controller1.value);
                            },
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: CustomPaint(
                                painter: CustomCirclePainter(
                                  animation: controller1,
                                  backgroundColor: Colors.white,
                                  color: AppColor.themeColor,
                                ),
                                child: Icon(
                                  Icons.laptop,
                                  color: AppColor.themeColor,
                                  size: 100,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller2.reverse(
                                  from: controller2.value == 0.0
                                      ? 1.0
                                      : controller2.value);
                            },
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: CustomPaint(
                                painter: CustomCirclePainter(
                                  animation: controller2,
                                  backgroundColor: Colors.white,
                                  color: AppColor.themeColor,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.globe,
                                  color: AppColor.themeColor,
                                  size: 100,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller3.reverse(
                                  from: controller3.value == 0.0
                                      ? 1.0
                                      : controller3.value);
                            },
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: CustomPaint(
                                painter: CustomCirclePainter(
                                  animation: controller3,
                                  backgroundColor: Colors.white,
                                  color: AppColor.themeColor,
                                ),
                                child: Icon(
                                  Icons.map,
                                  color: AppColor.themeColor,
                                  size: 100,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller4.reverse(
                                  from: controller4.value == 0.0
                                      ? 1.0
                                      : controller4.value);
                            },
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: CustomPaint(
                                painter: CustomCirclePainter(
                                  animation: controller4,
                                  backgroundColor: Colors.white,
                                  color: AppColor.themeColor,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.music,
                                  color: AppColor.themeColor,
                                  size: 100,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //Middle
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      controller1.reverse(
                          from: controller1.value == 0.0
                              ? 1.0
                              : controller1.value);
                    },
                    child: SizedBox(
                      width: 350,
                      height: 350,
                      child: CustomPaint(
                        painter: CustomCirclePainter(
                          animation: controller1,
                          backgroundColor: Colors.white,
                          color: AppColor.themeColor,
                        ),
                        child: Icon(
                          Icons.laptop,
                          color: AppColor.themeColor,
                          size: 200,
                        ),
                      ),
                    ),
                  ),
                ),
                //Right Top
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: CustomPaint(
                        painter: RectanglePainter(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                            itemCount: _data.length,
                            itemBuilder: (context, index) {
                              return Text(
                                _data[index].toString(),
                                style: GoogleFonts.orbitron(
                                    color: AppColor.themeColor),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //Right bottom
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 250,
                      height: 350,
                      child: CustomPaint(
                        painter: RectanglePainter(),
                        child: Stack(
                          children: [
                            TabBarView(
                              controller: tabController,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Container(
                                      color: Colors.white,
                                        child:
                                            buildTableCalendarWithBuilders()),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: 10,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                'Tab Two $index',
                                                style: GoogleFonts.orbitron(
                                                    fontSize: 10,
                                                    color: AppColor.themeColor),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: 10,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                'Tab Three $index',
                                                style: GoogleFonts.orbitron(
                                                    fontSize: 10,
                                                    color: AppColor.themeColor),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                child: AppBar(
                                  backgroundColor: Colors.black,
                                  flexibleSpace: TabBar(
                                    controller: tabController,
                                    isScrollable: false,
                                    indicatorColor: AppColor.themeColor,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorWeight: 2,
                                    tabs: [
                                      Icon(
                                        Icons.phone,
                                        color: AppColor.themeColor,
                                      ),
                                      Icon(
                                        Icons.note_add,
                                        color: AppColor.themeColor,
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: AppColor.themeColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Draws a circle if placed into a square widget.
class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = AppColor.themeColor
    ..strokeWidth = 10
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomCirclePainter extends CustomPainter {
  CustomCirclePainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomCirclePainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class RectanglePainter extends CustomPainter {
  final _paint = Paint()
    ..color = AppColor.themeColor
    ..strokeWidth = 4
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
