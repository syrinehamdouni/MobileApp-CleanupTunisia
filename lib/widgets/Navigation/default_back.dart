import 'package:flutter/material.dart';


import '../../Screens/Screens/Profile/edit_profile.dart';
import '../../Values/values.dart';
import '../Profile/text_outlined_button.dart';
import '../dummy/profile_dummy.dart';
import 'back_button.dart';

class DefaultNav extends StatelessWidget {
  final String title;
  final ProfileDummyType? type;
  const DefaultNav({Key? key, this.type, required this.title})
      : super(key: key);

  get Get => null;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      AppBackButton(),
      Text(
        this.title,
        style: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      Builder(builder: (context) {
        if (type == ProfileDummyType.Icon) {
          return ProfileDummy(
              color: HexColor.fromHex("93F0F0"),
              dummyType: ProfileDummyType.Image,
              image: "assets/man-head.png",
              scale: 1.2);
        } else if (type == ProfileDummyType.Image) {
          return ProfileDummy(
              color: HexColor.fromHex("9F69F9"),
              dummyType: ProfileDummyType.Icon,
              scale: 1.0);
        } else if (type == ProfileDummyType.Button) {
          return OutlinedButtonWithText(
            width: 100,
            content: "Modifier",
            onPressed: () {
              Get.to(() => EditProfilePage());
            },
          );
        } else {
          return Container();
        }
      }),
    ]);
  }
}
