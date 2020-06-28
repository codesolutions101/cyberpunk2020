// The stateful widget + animation controller
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RadialMenu extends StatefulWidget {
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key, this.controller})
      : scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;

  build(context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {
          return Stack(alignment: Alignment.center, children: [
            Transform.scale(
              scale: scale.value -
                  1.5, // subtract the beginning value to run the opposite animation
              child: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.timesCircle),
                  onPressed: _close,
                  backgroundColor: Colors.red),
            ),
            Transform.scale(
              scale: scale.value,
              child: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.solidDotCircle),
                  onPressed: _open),
            )
          ]);
        });
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
