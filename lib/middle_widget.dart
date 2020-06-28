import 'package:flutter/material.dart';

import 'const.dart';
import 'my_home.dart';

class MiddleWidget extends StatelessWidget {
  const MiddleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          showGeneralDialog(
              context: context,
              // ignore: missing_return
              pageBuilder: (context, anim1, anim2) {},
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.4),
              barrierLabel: '',
              transitionDuration: Duration(milliseconds: 200),
              transitionBuilder: (context, anim1, anim2, child) {
                return ScaleTransition(
                  scale: anim1,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dialogBackgroundColor: Colors.transparent),
                    child: AlertDialog(
                      contentPadding: EdgeInsets.all(1),
                      content: Material(
                        color: Colors.redAccent,
                        child: new Align(
                          alignment: Alignment.center,
                          child: new Stack(
                            children: <Widget>[
                              new Positioned(
                                child: new CircleButton(
                                    onTap: () => print("Cool"),
                                    iconData: Icons.favorite_border),
                                top: 10.0,
                                left: 130.0,
                              ),
                              new Positioned(
                                child: new CircleButton(
                                    onTap: () => print("Cool"),
                                    iconData: Icons.timer),
                                top: 120.0,
                                left: 10.0,
                              ),
                              new Positioned(
                                child: new CircleButton(
                                    onTap: () => print("Cool"),
                                    iconData: Icons.place),
                                top: 120.0,
                                right: 10.0,
                              ),
                              new Positioned(
                                child: new CircleButton(
                                    onTap: () => print("Cool"),
                                    iconData: Icons.local_pizza),
                                top: 240.0,
                                left: 130.0,
                              ),
                              new Positioned(
                                child: new CircleButton(
                                    onTap: () => print("Cool"),
                                    iconData: Icons.satellite),
                                top: 120.0,
                                left: 130.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        child: SizedBox(
          width: 350,
          height: 350,
          child: CustomPaint(
            painter: CirclePainter(),
            child: Icon(
              Icons.laptop,
              color: AppColor.themeColor,
              size: 200,
            ),
          ),
        ),
      ),
    );
  }
}

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
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}
