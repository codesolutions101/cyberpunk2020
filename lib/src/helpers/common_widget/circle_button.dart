import 'package:flutter/material.dart';

import '../utils/const.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 50.0;
    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: AppColor.themeColor,
          size: 50,
        ),
      ),
    );
  }
}
