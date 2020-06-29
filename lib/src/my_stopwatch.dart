import 'package:flutter/material.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class MyStopWatch extends StatefulWidget {
  @override
  _MyStopWatchState createState() => _MyStopWatchState();
}

class _MyStopWatchState extends State<MyStopWatch> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    onChange: (value) => print('onChange $value'),
    onChangeSecond: (value) => print('onChangeSecond $value'),
    onChangeMinute: (value) => print('onChangeMinute $value'),
  );

  @override
  void initState() {
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColor.themeColor,
              size: 50,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppColor.cyberPunkImage,
              scale: 1.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value);
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          displayTime,
                          style: TextStyle(
                            fontSize: 150,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            color: AppColor.kPurple,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            padding: const EdgeInsets.all(20),
                            color: AppColor.kPurple,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.start);
                            },
                            child: Text(
                              'Start',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          RaisedButton(
                            padding: const EdgeInsets.all(20),
                            color: AppColor.kPurple,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.stop);
                            },
                            child: Text(
                              'Stop',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          RaisedButton(
                            padding: const EdgeInsets.all(20),
                            color: AppColor.kPurple,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.reset);
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
