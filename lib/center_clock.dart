import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/const.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class CenterClock extends StatelessWidget {
  const CenterClock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 350,
          height: 100,
          child: DigitalClock(
            hourMinuteDigitDecoration:
                BoxDecoration(border: Border.all(color: Colors.transparent)),
            secondDigitDecoration:
                BoxDecoration(border: Border.all(color: Colors.transparent)),
            digitAnimationStyle: Curves.elasticOut,
            is24HourTimeFormat: false,
            areaDecoration: BoxDecoration(
              color: Colors.transparent,
            ),
            hourMinuteDigitTextStyle: GoogleFonts.orbitron(
              color: AppColor.themeColor,
              fontSize: 70,
            ),
            amPmDigitTextStyle: GoogleFonts.orbitron(
                color: AppColor.themeColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
