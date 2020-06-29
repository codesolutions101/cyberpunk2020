import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';
import 'package:hackathon2020/src/my_home.dart';

import 'helpers/common_widget/error_dialog.dart';
import 'helpers/common_widget/input_decoration.dart';
import 'helpers/user.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool selected = false;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  String id, displayName, email, password;

  login() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password))
            .user;
        print('login user: ${user.uid}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHome(
              uid: user.uid,
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
      } on FirebaseError catch (e) {
        errorDialogue(errorText: e.toString(), context: context);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              AppColor.cyberPunkImage,
              scale: 1.0,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 500,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: GoogleFonts.orbitron(
                            color: AppColor.themeColor,
                            fontSize: 50,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val.trim().length < 3 || val.isEmpty) {
                              return 'Enter a valid email';
                            } else if (val.trim().length > 40) {
                              return 'Enter a valid email';
                            } else
                              return null;
                          },
                          onChanged: (val) => setState(() => email = val),
                          decoration: kInputDecoration(
                              labelText: "Email", hintText: "Email"),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val.trim().length < 6 || val.isEmpty) {
                              return 'Password is Too Short, Min 6 Character';
                            } else if (val.trim().length > 20) {
                              return 'Password is Too Long';
                            } else
                              return null;
                          },
                          obscureText: true,
                          onChanged: (val) => setState(() => password = val),
                          decoration: kInputDecoration(
                              labelText: "Password", hintText: "Password"),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: Column(
                    children: [
                      isLoading
                          ? Column(
                              children: [
                                CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                  valueColor: AlwaysStoppedAnimation(
                                      AppColor.themeColor),
                                )
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: login,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.tealAccent,
                                            AppColor.themeColor
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          minHeight: 50.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Login",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
