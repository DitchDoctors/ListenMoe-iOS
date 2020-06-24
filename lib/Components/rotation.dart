import 'dart:math';

import 'package:flutter/material.dart';

class RotationMoe extends StatelessWidget {
final double value;
final Widget child;
RotationMoe({Key key, this.value, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      child: child,
      transform: Matrix4.identity()
      ..rotateX(value*(pi/180)),
    );
  }

}