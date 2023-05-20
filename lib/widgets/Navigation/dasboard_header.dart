import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunisiacleanup/Screens/src/constants/colors.dart';
import '../../Screens/Screens/Dashboard/HistoryScreen.dart';
import '../../Values/values.dart';
import '../dummy/profile_dummy.dart';

class DashboardNav extends StatelessWidget {
  final String title;
  final String image;
  final IconData icon;
  final StatelessWidget? page;
  final VoidCallback? onImageTapped;
  final String notificationCount;

  DashboardNav(
      {Key? key,
      required this.title,
      required this.icon,
      required this.image,
      required this.notificationCount,
      this.page,
      this.onImageTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(this.title, style: AppTextStyles.header2),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        InkWell(
          onTap: () {
            Get.to(()=>HistoryScreen());
          },
          child: Stack(children: <Widget>[
            Icon(icon, color: Colors.white, size: 30),
            Positioned(
              // draw a red marble
              top: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: HexColor.fromHex("FF9B76")),
                alignment: Alignment.center,
                child: Text(notificationCount,
                    style: GoogleFonts.lato(fontSize: 11, color: Colors.white)),
              ),
            )
          ]),
        ),
        SizedBox(width: 40),
        InkWell(
          onTap: onImageTapped,
          child: ProfileDummy(
              color: MyColors.primaryColor,
              dummyType: ProfileDummyType.Image,
              image: this.image,
              scale: 1.2),
        )
      ])
    ]);
  }
}

