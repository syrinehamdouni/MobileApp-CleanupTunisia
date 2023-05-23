/*import 'package:flutter/material.dart';
import '../helper/ui_helper.dart';

class ExploreWidget extends StatelessWidget {
  final double currentSearchPercent;

  final double currentExplorePercent;

  final Function(bool) animateExplore;

  final Function(DragUpdateDetails) onVerticalDragUpdate;
  final Function() onPanDown;

  final bool isExploreOpen;

  const ExploreWidget(
      {required Key key,
      required this.currentSearchPercent,
      required this.currentExplorePercent,
      required this.animateExplore,
      required this.isExploreOpen,
      required this.onVerticalDragUpdate,
      required this.onPanDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: realH(-122 * currentSearchPercent),
        left: (screenWidth - realW(159 + (standardWidth - 159) * currentExplorePercent)) / 2,
        child: GestureDetector(
          onTap: () {
            animateExplore(!isExploreOpen);
          },
          onVerticalDragUpdate: onVerticalDragUpdate,
          onVerticalDragEnd: (_) {
            _dispatchExploreOffset();
          },
          onPanDown: (_) => onPanDown(),
          child: Opacity(
            opacity: 1 - currentSearchPercent,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: realW(159 + (standardWidth - 159) * currentExplorePercent),
              height: realH(122 + (766 - 122) * currentExplorePercent),
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                    Color(0xFF00C853),Color(0xFF00695C)

                  ]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(realW(80 + (50 - 80) * currentExplorePercent)),
                      topRight: Radius.circular(realW(80 + (50 - 80) * currentExplorePercent)))),
              child: Stack(
                children: [
                  Positioned(
                      top: realH(90 + (-5 * currentExplorePercent)),
                      left: realW(30 + (91 - 49) * currentExplorePercent),
                      child: Text(
                        "user position",
                        style: TextStyle(color: Colors.white, fontSize: realW(18 + (32 - 18) * currentExplorePercent)),
                      )),
                  Positioned(
                      top: realH(30 + (60 - 20) * currentExplorePercent),
                      left: realW(60 + (44 - 63) * currentExplorePercent),
                      child: Icon(
                        Icons.location_on,
                        size: realW(34),
                        color: Colors.white,
                      )),
                  Positioned(
                      top: realH(currentExplorePercent < 0.9
                          ? realH(-35)
                          : realH(-35 + (6 + 35) * (currentExplorePercent - 0.9) * 8)),
                      left: realW(63 + (170 - 63) * currentExplorePercent),
                      child: GestureDetector(
                        onTap: () {
                          animateExplore(false);
                        },
                        child: Image.asset(
                          "assets/arrow.png",
                          width: realH(35),
                          height: realH(35),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  /// dispatch Explore state
  ///
  /// handle it by [isExploreOpen] and [currentExplorePercent]
  void _dispatchExploreOffset() {
    if (!isExploreOpen) {
      if (currentExplorePercent < 0.3) {
        animateExplore(false);
      } else {
        animateExplore(true);
      }
    } else {
      if (currentExplorePercent > 0.6) {
        animateExplore(true);
      } else {
        animateExplore(false);
      }
    }
  }
}
*/