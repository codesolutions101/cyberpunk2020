import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          child: FlatButton(
              onPressed: null,
              child: Text(
                text,
                style: GoogleFonts.piedra(color: Colors.white, fontSize: 20),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
//      child:  DialPad(
//          enableDtmf: true,
//          outputMask: "(000) 000-0000",
//          backspaceButtonIconColor: Colors.red,
//          makeCall: (number){
//            print(number);
//          }
//      ),

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
                buildBtn('esc'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('0'),
                SizedBox(
                  width: 5,
                ),
                buildBtn('enter'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//class MyPhone extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(10),
//      child: ListView(
////      mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          NumberReadout(),
//          NumberPad(),
//          DialButton(),
//        ],
//      ),
//    );
//  }
//}
//
///// Decorated dialer UI
//class DecoratedDialer extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[
////        Positioned.fill(
////          child: Container(
////            decoration: BoxDecoration(
////                gradient: LinearGradient(
////                  begin: Alignment.topLeft,
////                  colors: <Color>[Colors.cyan, Colors.white],
////                )),
////            child: Opacity(
////              opacity: 0.2,
////              child: FlutterLogo(),
////            ),
////          ),
////        ),
//        MyPhone(),
//      ],
//    );
//  }
//}
//
///// Phone number pad
//class NumberPad extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.only(left: 20, right: 20),
//      child: Table(
//        children: <TableRow>[
//          TableRow(
//            children: ['1', '2', '3']
//                .map<Widget>((char) => DigitButton(char))
//                .toList(),
//          ),
//          TableRow(
//            children: ['4', '5', '6']
//                .map<Widget>((char) => DigitButton(char))
//                .toList(),
//          ),
//          TableRow(
//            children: ['7', '8', '9']
//                .map<Widget>((char) => DigitButton(char))
//                .toList(),
//          ),
//          TableRow(
//            children: ['*', '0', '#']
//                .map<Widget>((char) => DigitButton(char))
//                .toList(),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
///// Dialer button
//class DigitButton extends StatelessWidget {
//  DigitButton(this.char);
//  final String char;
//
//  @override
//  Widget build(BuildContext context) {
////    final phoneNumber = Provide.value<PhoneNumber>(context);
//    return Padding(
//      padding: const EdgeInsets.all(10.0),
//      child: RawMaterialButton(
//        shape: CircleBorder(),
//        elevation: 6,
//        fillColor: Colors.white,
//        padding: const EdgeInsets.all(10),
//        child: Text(char),
////        onPressed: () => phoneNumber.addDigit(char),
//      ),
//    );
//  }
//}
//
///// Another dialer button
//class FlatDigitButton extends StatelessWidget {
//  FlatDigitButton(this.char);
//  final String char;
//
//  @override
//  Widget build(BuildContext context) {
////    final phoneNumber = Provide.value<PhoneNumber>(context);
//    return Padding(
//      padding: const EdgeInsets.all(10),
//      child: FlatButton(
//        textColor: Colors.blue,
//        child: Text(char),
////        onPressed: () => phoneNumber.addDigit(char),
//      ),
//    );
//  }
//}
//
///// Dials the entered phone number
////class DialButton extends StatelessWidget {
////  @override
////  Widget build(BuildContext context) {
////    return Provide<PhoneNumber>(
////      builder: (context, _, number) => FloatingActionButton(
////        child: Icon(Icons.phone),
////        onPressed: () =>
////        number.hasNumber ? dialNumber(number.number, context) : null,
////      ),
////    );
////  }
////}
//
///// Phone number display
////class PhoneNumberDisplay extends StatelessWidget {
////  @override
////  Widget build(BuildContext context) {
////    return Expanded(
////      child: Provide<PhoneNumber>(
////        builder: (context, _, phoneNumber) {
////          return Text(
////            phoneNumber.formattedNumber,
////            textAlign: TextAlign.center,
////          );
////        },
////      ),
////    );
////  }
////}
//
///// Delete button for phone number
//class DeleteButton extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return IconButton(
//      icon: Icon(Icons.backspace),
////      onPressed: () => Provide.value<PhoneNumber>(context).removeDigit(),
//    );
//  }
//}
//
///// Displays the entered phone number
//class NumberReadout extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: const EdgeInsets.all(15),
//      padding: const EdgeInsets.all(5),
//      decoration: BoxDecoration(
//        // border: BorderDirectional(bottom: BorderSide(color: darkBlue)),
//        border: Border.all(color: Colors.blue),
//        borderRadius: BorderRadius.circular(20),
//      ),
//      child: Row(
//        children: <Widget>[
////          PhoneNumberDisplay(),
//          DeleteButton(),
//        ],
//      ),
//    );
//  }
//}
//
