import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/const.dart';

class MyPhone extends StatefulWidget {
  @override
  _MyPhoneState createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Do DialPad design here. use this given google font',
              style: GoogleFonts.orbitron(color: AppColor.themeColor),
            ),
          ),
        ],
      ),
    );
  }
}
