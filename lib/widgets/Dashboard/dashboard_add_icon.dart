import 'package:flutter/material.dart';
import 'package:tunisiacleanup/Screens/src/constants/colors.dart';


class DashboardAddButton extends StatelessWidget {
  final VoidCallback? iconTapped;
  const DashboardAddButton({
    Key? key,
    this.iconTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: iconTapped,
      child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              color: MyColors.colorScheme, shape: BoxShape.circle),
          child: const Icon(Icons.camera_alt_outlined, color: Colors.white)),
    );
  }
}
