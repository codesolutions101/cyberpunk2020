import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/src/register_page.dart';

import 'helpers/user.dart';
import 'helpers/utils/const.dart';
import 'login_page.dart';

class RegisterOrLogin extends StatefulWidget {
  RegisterOrLogin({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterOrLoginState createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {
  bool selected = false;

  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  String id, displayName, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: selected ? -300 : 200,
            curve: Curves.slowMiddle,
//            right: selected ? 2000 : 0,
            child: Image.asset(
              AppColor.cyberPunkImage,
              scale: 1.0,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            left: selected ? 2000 : 500,
            curve: Curves.slowMiddle,
//            right: selected ? 2000 : 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
                Future.delayed(Duration(milliseconds: 2000), () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
              child: Text(
                'Login',
                style: GoogleFonts.orbitron(
                  color: AppColor.themeColor,
                  fontSize: 50,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            right: selected ? 2000 : 570,
//            left: selected ? 2000 : 500,
            top: 500,
            curve: Curves.slowMiddle,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
                Future.delayed(Duration(milliseconds: 2000), () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Register',
                    style: GoogleFonts.orbitron(
                      color: AppColor.kPurple,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
