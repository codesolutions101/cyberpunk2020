import 'dart:math' as math;

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/main.dart';
import 'package:hackathon2020/src/helpers/user.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';
import 'package:hackathon2020/src/my_calendar.dart';
import 'package:js/js.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/weather_library.dart';

import 'center_clock.dart';
import 'helpers/common_widget/circle_button.dart';
import 'helpers/common_widget/my_custom_painters.dart';
import 'helpers/locationJs.dart';
import 'my_notes.dart';
import 'my_phone.dart';
import 'my_stopwatch.dart';

class MyHome extends StatefulWidget {
  MyHome({this.uid});
  final String uid;
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController controller1;
  AnimationController controller2;
  AnimationController controller3;
  TabController tabController;
  AnimationController animationController;
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
  AuthService authService = AuthService();

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
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(milliseconds: 2000), () {
            authService.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage()));
          });
        }
      });
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
  void dispose() {
    controller.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    tabController.dispose();
    animationController.dispose();
    animatedIconController.dispose();
    weatherAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
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
                width: MediaQuery.of(context).size.width * 0.2,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    children: [
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
                              color: AppColor.kPurple,
                            ),
                            child: Icon(
                              FontAwesomeIcons.globe,
                              color: AppColor.kPurple,
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
                              color: AppColor.kPurple,
                            ),
                            child: Icon(
                              Icons.map,
                              color: AppColor.kPurple,
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
                              color: AppColor.kPurple,
                            ),
                            child: Icon(
                              Icons.exit_to_app,
                              color: AppColor.kPurple,
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 50,
                    left: 80,
                    child: Image.asset(
                      AppColor.cyberPunkImage,
                      scale: 1.6,
                    ),
                  ),
                  Positioned(
                    left: 170,
                    child: Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          showGeneralDialog(
                              context: context,
                              // ignore: missing_return
                              pageBuilder: (context, anim1, anim2) {},
                              barrierDismissible: true,
                              barrierColor: Colors.black.withOpacity(0.5),
                              barrierLabel: '',
                              transitionDuration: Duration(milliseconds: 1000),
                              transitionBuilder:
                                  (context, anim1, anim2, child) {
                                return RotationTransition(
                                  turns: anim1,
                                  alignment: Alignment.center,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dialogBackgroundColor: Colors.black),
                                    child: AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: Container(
                                        height: 440,
                                        width: 440,
//                                        color: Colors.red,
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            CircleButton(
                                                onTap: () async {
                                                  const url =
                                                      'https://www.instagram.com/explore/tags/cyberpunk/';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                iconData:
                                                    Icons.favorite_border),
                                            Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CircleButton(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyStopWatch(),
                                                          ),
                                                        );
                                                      },
                                                      iconData: Icons.timer),
                                                  CircleButton(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      iconData: FontAwesomeIcons
                                                          .timesCircle),
                                                  CircleButton(
                                                      onTap: launchMap,
                                                      iconData: Icons.place),
                                                ],
                                              ),
                                            ),
                                            CircleButton(
                                                onTap: () async {
                                                  final url =
                                                      'https://www.youtube.com/watch?v=Q9yn1DpZkHQ&list=RDQMWA2PUmwF9Uw&start_radio=1';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                iconData: Icons.music_note),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Image.asset(
                          'assets/images/middle.jpg',
                          scale: 1.2,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 180,
                    child: CenterClock(),
                  ),
                ],
              ),
            ),
          ),
          //Right
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
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
                                    color: AppColor.kPurple,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: tempCel == null
                                        ? CircularProgressIndicator(
                                            backgroundColor: Colors.black,
                                            valueColor: AlwaysStoppedAnimation(
                                                AppColor.kPurple),
                                          )
                                        : RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.black),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: tempCel.toString(),
                                                      style:
                                                          GoogleFonts.orbitron(
                                                              color: AppColor
                                                                  .kPurple,
                                                              fontSize: 30),
                                                    ),
                                                    TextSpan(
                                                      text: 'º',
                                                      style:
                                                          GoogleFonts.orbitron(
                                                              color: AppColor
                                                                  .kPurple,
                                                              fontSize: 30),
                                                    ),
                                                    TextSpan(
                                                      text: 'C',
                                                      style:
                                                          GoogleFonts.orbitron(
                                                              color: AppColor
                                                                  .kPurple,
                                                              fontSize: 30),
                                                    ),
                                                  ],
                                                ),
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
                                              color: AppColor.kPurple,
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
                Flexible(
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
                                        'Cyberpunk 2020 Live',
                                        style: GoogleFonts.orbitron(
                                          color: AppColor.kPurple,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      color: AppColor.kPurple,
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
                Flexible(
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
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Container(
                                          color: Colors.transparent,
                                          child: MyCalendar(),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                  MyNotes(
                                    uid: user.uid,
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
                                      indicatorColor: AppColor.kPurple,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorWeight: 2,
                                      tabs: [
                                        Icon(
                                          FontAwesomeIcons.calendarAlt,
                                          color: AppColor.kPurple,
                                        ),
                                        Icon(
                                          Icons.phone,
                                          color: AppColor.kPurple,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.stickyNote,
                                          color: AppColor.kPurple,
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
          )
        ],
      ),
    );
  }
}
