import 'dart:math' as math;

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/const.dart';
import 'package:hackathon2020/my_calendar.dart';
import 'package:js/js.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/weather_library.dart';

import 'center_clock.dart';
import 'locationJs.dart';
import 'my_notes.dart';
import 'my_phone.dart';

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
//  AnimationController animationController2;
//  Animation<double> rotateAnimation;
  AnimationController animatedIconController;

  AnimationController weatherAnim;

  final audioPlayer = AssetsAudioPlayer();

  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  WeatherStation ws;
  var lat, lon;
  List<Weather> _data = [];
  Weather weather;
  var tempCel;
  var scale;
  var scale2;
  bool isPlaying = false;

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
      duration: Duration(seconds: 1),
    );
    controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(milliseconds: 2000), () {
            launchWeb();
          });
        }
      });
    controller3 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(milliseconds: 2000), () {
            launchMap();
          });
        }
      });
    controller4 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    tabController = TabController(length: 3, vsync: this);

    animationController =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);

    weatherAnim =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);

    scale = Tween<double>(
      begin: 1.5,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );

    scale2 = Tween<double>(
      begin: 1.5,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: weatherAnim, curve: Curves.fastOutSlowIn),
    );

//    animationController2 =
//        AnimationController(duration: Duration(seconds: 5), vsync: this);
//
//    rotateAnimation = Tween<double>(begin: 0, end: 2 * math.pi)
//        .chain(CurveTween(curve: Curves.ease))
//        .animate(
//          CurvedAnimation(parent: animationController2, curve: Curves.ease),
//        );

    animatedIconController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
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
    weather = await ws.currentWeather(lat, lon);
    setState(() {
      tempCel = weather.temperature.celsius;
      _data = [weather];
    });
  }

  _open() {
    animationController.forward();
  }

  _close() {
    animationController.reverse();
  }

  Future<void> playAudio() async {
    try {
      if (audioPlayer.playerState.value == PlayerState.play) {
        setState(() {
          isPlaying = false;
        });
        isPlaying
            ? animatedIconController.forward()
            : animatedIconController.reverse();
        audioPlayer.pause();
      } else {
        setState(() {
          isPlaying = true;
        });
        isPlaying
            ? animatedIconController.forward()
            : animatedIconController.reverse();
        await audioPlayer.open(
          Audio.network(
            "https://whsh4u-panel.com//proxy/xegagooy?mp=/live",
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  launchWeb() async {
    print('hererer');
    const url = 'https://www.flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchMap() async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Left Icons
          Flexible(
            child: SingleChildScrollView(
              child: Container(
//                    color: Colors.red,
                width: MediaQuery.of(context).size.width * 0.2,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller1.reverse(
                              from: controller1.value == 0.0
                                  ? 1.0
                                  : controller1.value);
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CustomPaint(
                            painter: CustomCirclePainter(
                              animation: controller1,
                              backgroundColor: Colors.black,
                              color: AppColor.themeColor,
                            ),
                            child: Icon(
                              Icons.laptop,
                              color: AppColor.themeColor,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller2.reverse(
                              from: controller2.value == 0.0
                                  ? 1.0
                                  : controller2.value);
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CustomPaint(
                            painter: CustomCirclePainter(
                              animation: controller2,
                              backgroundColor: Colors.black,
                              color: AppColor.themeColor,
                            ),
                            child: Icon(
                              FontAwesomeIcons.globe,
                              color: AppColor.themeColor,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller3.reverse(
                              from: controller3.value == 0.0
                                  ? 1.0
                                  : controller3.value);
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CustomPaint(
                            painter: CustomCirclePainter(
                              animation: controller3,
                              backgroundColor: Colors.black,
                              color: AppColor.themeColor,
                            ),
                            child: Icon(
                              Icons.map,
                              color: AppColor.themeColor,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller4.reverse(
                              from: controller4.value == 0.0
                                  ? 1.0
                                  : controller4.value);
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CustomPaint(
                            painter: CustomCirclePainter(
                              animation: controller4,
                              backgroundColor: Colors.black,
                              color: AppColor.themeColor,
                            ),
                            child: Icon(
                              FontAwesomeIcons.music,
                              color: AppColor.themeColor,
                              size: 50,
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
          //Middle
          Flexible(
            child: Container(
//                  color: Colors.blue,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Container(
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
                                  child: Transform.rotate(
                                    angle: math.pi,
                                    child: Container(
                                      width: 300,
                                      height: 300,
                                      color: Colors.transparent,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            child: CircleButton(
                                                onTap: () => print("Cool"),
                                                iconData:
                                                    Icons.favorite_border),
                                            top: 10.0,
                                            left: 130.0,
                                          ),
                                          Positioned(
                                            child: CircleButton(
                                                onTap: () => print("Cool"),
                                                iconData: Icons.timer),
                                            top: 120.0,
                                            left: 10.0,
                                          ),
                                          Positioned(
                                            child: CircleButton(
                                                onTap: () => print("Cool"),
                                                iconData: Icons.place),
                                            top: 120.0,
                                            right: 10.0,
                                          ),
                                          Positioned(
                                            child: CircleButton(
                                                onTap: () => print("Cool"),
                                                iconData: Icons.local_pizza),
                                            top: 240.0,
                                            left: 130.0,
                                          ),
                                          Positioned(
                                            child: new CircleButton(
                                                onTap: _close,
                                                iconData: FontAwesomeIcons
                                                    .timesCircle),
                                            top: 120.0,
                                            left: 130.0,
                                          ),
                                        ],
                                      ),
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
                  ),
                  Positioned(
                    top: 50,
                    child: CenterClock(),
                  ),
                ],
              ),
            ),
          ),
          //Right
          Flexible(
            child: Container(
//                  color: Colors.greenAccent,
//                  alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: AnimatedBuilder(
                      animation: weatherAnim,
                      builder: (context, child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 50.0, right: 50),
                          child: Stack(
                            children: [
                              Transform.scale(
                                scale: scale2.value,
                                child: GestureDetector(
                                  onTap: () {
                                    print(_data);
                                    weatherAnim.forward();
                                  },
                                  child: SizedBox(
                                    width: 125,
                                    height: 125,
                                    child: CustomPaint(
                                      painter: CustomCirclePainter(
                                        animation: weatherAnim,
                                        backgroundColor: Colors.black,
                                        color: AppColor.themeColor,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: tempCel == null
                                            ? CircularProgressIndicator(
                                                backgroundColor: Colors.black,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        AppColor.themeColor),
                                              )
                                            : RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color:
                                                                Colors.black),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: tempCel
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .orbitron(
                                                                    color: AppColor
                                                                        .themeColor,
                                                                    fontSize:
                                                                        30),
                                                          ),
                                                          TextSpan(
                                                            text: 'º',
                                                            style: GoogleFonts
                                                                .orbitron(
                                                                    color: AppColor
                                                                        .themeColor,
                                                                    fontSize:
                                                                        30),
                                                          ),
                                                          TextSpan(
                                                            text: 'C',
                                                            style: GoogleFonts
                                                                .orbitron(
                                                                    color: AppColor
                                                                        .themeColor,
                                                                    fontSize:
                                                                        30),
                                                          ),
                                                        ]),
//                                          Text(
//                                            tempCel.toString(),
//                                            textAlign: TextAlign.center,
//                                            style: GoogleFonts.orbitron(
//                                                color: AppColor.themeColor,
//                                                fontSize: 30),
//                                          ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Transform.scale(
                                scale: scale2.value - 1.5,
                                child: Transform.rotate(
                                  angle: math.pi,
                                  child: GestureDetector(
                                    onTap: () {
                                      print(_data);
                                      weatherAnim.reverse();
                                    },
                                    child: SizedBox(
                                      width: 200,
                                      height: 150,
                                      child: CustomPaint(
                                        painter: RectanglePainter(),
                                        child: Container(
                                          child: ListView.builder(
                                            padding: const EdgeInsets.all(8.0),
                                            shrinkWrap: true,
                                            itemCount: _data.length,
                                            itemBuilder: (context, index) {
                                              return Text(
                                                _data[index].toString(),
                                                style: GoogleFonts.orbitron(
                                                  color: AppColor.themeColor,
                                                  fontSize: 10,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
//                      Expanded(
//                        child: Padding(
//                          padding: const EdgeInsets.only(right: 8.0, top: 8.0),
//                          child: Align(
//                            alignment: Alignment.topRight,
//                            child: SizedBox(
//                              width: 300,
//                              height: 250,
//                              child: CustomPaint(
//                                painter: RectanglePainter(),
//                                child: Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: ListView.separated(
//                                    itemCount: _data.length,
//                                    itemBuilder: (context, index) {
//                                      return Text(
//                                        _data[index].toString(),
//                                        style: GoogleFonts.orbitron(
//                                            color: AppColor.themeColor),
//                                      );
//                                    },
//                                    separatorBuilder: (context, index) {
//                                      return Divider();
//                                    },
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 300,
                          height: 150,
                          child: CustomPaint(
                            painter: RectanglePainter(),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Live Radio',
                                          style: GoogleFonts.orbitron(
                                            color: AppColor.themeColor,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        color: AppColor.themeColor,
                                        icon: AnimatedIcon(
                                          icon: AnimatedIcons.play_pause,
                                          progress: animatedIconController,
                                        ),
                                        onPressed: () => playAudio(),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
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
                                        Column(
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              child: MyPhone(),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          color: Colors.transparent,
                                          child: MyPhone(),
                                        ),
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
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
                                    ),
                                    MyNotes(),
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
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
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
                  ),
                ],
              ),
            ),
          )
        ],
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
      ..strokeWidth = 5.0
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
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(10.0)),
        _paint);
//    canvas.drawDRRect(
//      RRect.fromRectAndCorners(Rect.fromLTWH(0, 0, size.width, size.height),
//          topLeft: Radius.circular(50)),
//      RRect.fromRectAndCorners(Rect.fromLTWH(10, 10, size.width, size.height),
//          topLeft: Radius.circular(1)),
//      _paint,
//    );
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
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: AppColor.themeColor,
        ),
      ),
    );
  }
}
