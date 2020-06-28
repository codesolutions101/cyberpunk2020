import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/const.dart';
import 'package:hackathon2020/my_calendar.dart';
import 'package:js/js.dart';
import 'package:weather/weather_library.dart';

import 'center_clock.dart';
import 'locationJs.dart';
import 'my_phone.dart';

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
  AnimationController animationController;

  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  WeatherStation ws;
  var lat, lon;
  List<Weather> _data = [];
  var scale;

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
    animationController =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);

    scale = Tween<double>(
      begin: 1.5,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
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

  _open() {
    animationController.forward();
  }

  _close() {
    animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                  child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, builder) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.scale(
                              scale: scale.value - 1.5,
                              // subtract the beginning value to run the opposite animation
                              child: Container(
                                width: 300,
                                height: 300,
                                color: Colors.transparent,
                                child: Stack(
                                  children: <Widget>[
                                    new Positioned(
                                      child: new CircleButton(
                                          onTap: () => print("Cool"),
                                          iconData: Icons.favorite_border),
                                      top: 10.0,
                                      left: 130.0,
                                    ),
                                    new Positioned(
                                      child: new CircleButton(
                                          onTap: () => print("Cool"),
                                          iconData: Icons.timer),
                                      top: 120.0,
                                      left: 10.0,
                                    ),
                                    new Positioned(
                                      child: new CircleButton(
                                          onTap: () => print("Cool"),
                                          iconData: Icons.place),
                                      top: 120.0,
                                      right: 10.0,
                                    ),
                                    new Positioned(
                                      child: new CircleButton(
                                          onTap: () => print("Cool"),
                                          iconData: Icons.local_pizza),
                                      top: 240.0,
                                      left: 130.0,
                                    ),
                                    new Positioned(
                                      child: new CircleButton(
                                          onTap: _close,
                                          iconData:
                                              FontAwesomeIcons.timesCircle),
                                      top: 120.0,
                                      left: 130.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: scale.value,
                              child: Container(
                                child: GestureDetector(
                                  onTap: _open,
                                  child: Image.asset(
                                    'assets/images/middle.jpg',
                                    scale: 2.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
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
                //Center top clock
                CenterClock(),
                //Right bottom
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 300,
                      height: 425,
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
                                      height: 40,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      child: MyPhone(),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      child: MyCalendar(),
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
                                        FontAwesomeIcons.calendarAlt,
                                        color: AppColor.themeColor,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.stickyNote,
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

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 50.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}
