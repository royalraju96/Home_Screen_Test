import 'package:flutter/material.dart';

class GridWidget extends StatelessWidget {
  final String text;
  final List<Color> gradientColor;

  final BorderRadiusGeometry borderRadius;
  const GridWidget({
    Key key,
    @required this.gradientColor,
    @required this.text,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(colors: gradientColor)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0),
        ));
  }
}
