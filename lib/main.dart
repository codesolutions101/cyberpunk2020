import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/src/helpers/auth_guard.dart';
import 'package:hackathon2020/src/helpers/user.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';
import 'package:provider/provider.dart';

import 'src/my_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cyberpunk 2020',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
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
            top: 450,
            curve: Curves.slowMiddle,
//            right: selected ? 2000 : 0,
            child: Text(
              'Welcome to the future',
              style: GoogleFonts.orbitron(
                color: AppColor.themeColor,
                fontSize: 50,
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
                if (user == null) {
                  Future.delayed(Duration(milliseconds: 2000), () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AuthGuard()));
                  });
                } else {
                  Future.delayed(Duration(milliseconds: 2000), () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MyHome(
                              uid: user.uid,
                            )));
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Click here to begin',
                    style: GoogleFonts.orbitron(
                      color: AppColor.kPurple,
                      fontSize: 20,
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
