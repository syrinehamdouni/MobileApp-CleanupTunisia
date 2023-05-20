
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunisiacleanup/Values/values.dart';
import 'package:tunisiacleanup/widgets/Buttons/progress_card_close_button.dart';
import 'package:tunisiacleanup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:tunisiacleanup/widgets/Profile/badged_container.dart';
import 'package:tunisiacleanup/widgets/Profile/text_outlined_button.dart';
import 'package:tunisiacleanup/widgets/container_label.dart';
import 'package:tunisiacleanup/widgets/dummy/profile_dummy.dart';
import '../../src/constants/colors.dart';
import '../../src/features/authentication/screens/splash_screen.dart';
import 'edit_profile.dart';
import 'profile_notification_settings.dart';

class ProfileOverview extends StatelessWidget {
 ProfileOverview({Key? key}) : super(key: key);




  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('userscitoyen');



  //document Ids
 List<String>docIDs =[];
 //get docIds
 Future getDocId() async{}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      DarkRadialBackground(
        color: MyColors.primaryColor,
        position: "topLeft",
      ),
      Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
                    AppSpaces.verticalSpace20,
            Align(
              alignment: Alignment.center,
              child: ProfileDummy(
                  color: HexColor.fromHex("94F0F1"),
                  dummyType: ProfileDummyType.Image,
                  scale: 3.0,
                  image: "assets/images/profile.png"),
            ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
              child: Text("",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
            ),
            Text("hamdounisyrin@email.com",
                style: GoogleFonts.lato(
                    color: HexColor.fromHex("B0FFE1"), fontSize: 17)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: OutlinedButtonWithText(
                width: 150,
                content: "Réglage",
                onPressed: () {
                  Get.to(() => EditProfilePage());
                },
              ),
            ),
            AppSpaces.verticalSpace20,

            ContainerLabel(label: "Mon compte"),
            AppSpaces.verticalSpace10,
            BadgedContainer(
              label: "Nom",
              callback: () {
                Get.to(() => ProfileNotificationSettings());
              },
              value: "hamdouni",
              badgeColor: "FDA5FF",
            ),
                    AppSpaces.verticalSpace10,
                    BadgedContainer(
                      label: "Prénom",
                      callback: () {
                        Get.to(() => ProfileNotificationSettings());
                      },
                      value: "syrin",
                      badgeColor: "FDA5FF",
                    ),
                    AppSpaces.verticalSpace10,
                    BadgedContainer(
                      label: "Email",
                      callback: () {
                        Get.to(() => ProfileNotificationSettings());
                      },
                      value: "hamdounisyrin@gmail.com",
                      badgeColor: "FDA5FF",
                    ),

                    AppSpaces.verticalSpace20,
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: new LinearGradient( colors: [MyColors.primaryColor,MyColors.colorScheme],)),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => SplashScreen(title: 'Cleanup Tunisia',));
                        },
                        child: Text(
                          "Se déconnecter",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    )



                  ])))),
      Positioned(
          top: 50,
          left: 20,

          child: Transform.scale(
              scale: 1.2,
              child: ProgressCardCloseButton(onPressed: () {
                Get.back();
              })))
    ]));
  }
}
