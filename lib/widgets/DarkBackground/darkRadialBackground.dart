import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DarkRadialBackground extends StatelessWidget {
  final String position;
  final Color color;
  var list = List.generate(
    3,
    (index) => Color(0xFF00C853),
  );
  DarkRadialBackground({required this.color, required this.position});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [...list, this.color],
        center: (position == "bottomRight")
            ? Alignment(1.0, 1.0)
            : Alignment(-1.0, -1.0),
      ),
    )));
  }
}
