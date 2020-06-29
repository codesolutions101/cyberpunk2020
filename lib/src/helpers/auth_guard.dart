import 'package:flutter/material.dart';
import 'package:hackathon2020/src/helpers/user.dart';
import 'package:hackathon2020/src/my_home.dart';
import 'package:hackathon2020/src/register_or_login.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatefulWidget {
  @override
  _AuthGuardState createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      print('check user null: $user');
      return RegisterOrLogin();
    } else {
      print('check user got it: ${user.uid}');
      return MyHome(
        uid: user.uid,
      );
    }
  }
}
