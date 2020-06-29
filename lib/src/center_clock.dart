import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class CenterClock extends StatefulWidget {
  const CenterClock({
    Key key,
  }) : super(key: key);

  @override
  _CenterClockState createState() => _CenterClockState();
}

class _CenterClockState extends State<CenterClock> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: DigitalClock(
        areaHeight: 100,
        areaWidth: 350,
        hourMinuteDigitDecoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        secondDigitDecoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        digitAnimationStyle: Curves.easeIn,
        is24HourTimeFormat: true,
        areaDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        hourMinuteDigitTextStyle: GoogleFonts.orbitron(
          color: AppColor.themeColor,
          fontSize: 70,
        ),
        amPmDigitTextStyle: GoogleFonts.orbitron(
            color: AppColor.themeColor, fontWeight: FontWeight.bold),
        secondDigitTextStyle: GoogleFonts.orbitron(
          color: AppColor.themeColor,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
      ),
    );
  }
}
