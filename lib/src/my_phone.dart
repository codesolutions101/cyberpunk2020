import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';

class MyPhone extends StatefulWidget {
  @override
  _MyPhoneState createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  Expanded buildBtn(String text) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            left: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
            top: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style:
                GoogleFonts.orbitron(color: AppColor.themeColor, fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Row(
              children: [
                buildBtn('1'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('2'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('3'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                buildBtn('4'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('5'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('6'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                buildBtn('7'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('8'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('9'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                buildBtn('*'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('0'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('#'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.phone,
                color: AppColor.themeColor,
              ),
              label: Text(
                'Call',
                style: GoogleFonts.orbitron(
                    color: AppColor.themeColor, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
