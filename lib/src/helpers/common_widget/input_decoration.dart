import 'package:flutter/material.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';

InputDecoration kInputDecoration({String labelText, hintText}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: AppColor.themeColor,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: AppColor.themeColor,
        width: 2.0,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: const BorderSide(color: Colors.white, width: 1.0),
    ),
    labelText: labelText,
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white70),
    labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
  );
}
