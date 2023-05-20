import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/ui_helper.dart';

class MapButton extends StatelessWidget {
  final double currentSearchPercent;
  final double currentExplorePercent;

  final double bottom;
  final double offsetX;
  final double width;
  final double height;

  final IconData icon;
  final Widget? page;
  final Color iconColor;
  final bool isRight;
  final Gradient gradient;
  final  Function()? onPressed;
  const MapButton({
    required Key key,
    required this.currentSearchPercent,
    required this.currentExplorePercent,
    required this.bottom,
    required this.offsetX,
    required this.width,
    required this.height,
    required this.icon,
    required this.page,
    required this.iconColor,
    required this.onPressed,
    this.isRight = true,
    required this.gradient,
  })  : assert(currentSearchPercent != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: realH(bottom),
      left: !isRight
          ? realW(offsetX * (currentExplorePercent + currentSearchPercent))
          : null,
      right: isRight
          ? realW(offsetX * (currentExplorePercent + currentSearchPercent))
          : null,
      child: Opacity(
        opacity: 1 - (currentSearchPercent + currentExplorePercent),
        child: Container(
          width: realW(width),
          height: realH(height),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: realW(17)),
          decoration: BoxDecoration(
            color: gradient == null ? Colors.white : null,
            gradient: gradient,
            borderRadius: isRight
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(realW(36)),
                    topLeft: Radius.circular(realW(36)))
                : BorderRadius.only(
                    bottomRight: Radius.circular(realW(36)),
                    topRight: Radius.circular(realW(36))),
            boxShadow: [
              BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                  blurRadius: realW(36)),
            ],
          ),
          child: InkWell(
            onTap: onPressed,
            child: Stack(
              children: <Widget>[
                Icon(
                  icon,
                  size: realW(34),
                  color: iconColor ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
