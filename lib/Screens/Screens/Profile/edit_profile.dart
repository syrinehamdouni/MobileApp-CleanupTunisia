import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunisiacleanup/Values/values.dart';
import 'package:tunisiacleanup/widgets/Buttons/primary_progress_button.dart';
import 'package:tunisiacleanup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:tunisiacleanup/widgets/Forms/form_input_with%20_label.dart';
import 'package:tunisiacleanup/widgets/Navigation/app_header.dart';
import 'package:tunisiacleanup/widgets/dummy/profile_dummy.dart';

import '../../src/constants/colors.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String tabSpace = "\t\t\t";
    final _nameController = new TextEditingController();
    final _prenomController = new TextEditingController();
    final _passController = new TextEditingController();
    final _emailController = new TextEditingController();
    final _NumeroController = new TextEditingController();
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
                    TaskezAppHeader(
              title: "$tabSpace Réglages",
              widget: PrimaryProgressButton(
                width: 80,
                height: 40,
                label: "Sauver",
                textStyle: GoogleFonts.lato(
                    color: Colors.white, fontWeight: FontWeight.bold),


              ),
            ),
            SizedBox(height: 30),
            Stack(
              children: [
                ProfileDummy(
                    color: HexColor.fromHex("94F0F1"),
                    dummyType: ProfileDummyType.Image,
                    scale: 3.0,
                    image: "assets/images/profile.png"),
                Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: AppColors.primaryAccentColor.withOpacity(0.75),
                        shape: BoxShape.circle),
                    child: Icon(FeatherIcons.camera,
                        color: Colors.white, size: 20))
              ],
            ),
            AppSpaces.verticalSpace20,
            LabelledFormInput(
                placeholder: "hamdouni",
                keyboardType: "text",
                controller: _nameController,
                obscureText: false,
                label: "Nom"),
                    AppSpaces.verticalSpace20,
                    LabelledFormInput(
                        placeholder: "syrin",
                        keyboardType: "text",
                        controller: _prenomController,
                        obscureText: false,
                        label: "Prénom"),

                    AppSpaces.verticalSpace20,

                    LabelledFormInput(
                        placeholder: "exemple@gmail.com",
                        keyboardType: TextInputType.emailAddress.toString(),
                        controller: _emailController,
                        obscureText: true,
                        label: "Votre email"),

                   /* LabelledFormInput(
                        placeholder: "116 ",
                        keyboardType: TextInputType.number.toString(),
                        controller: _NumeroController,
                        obscureText: true,
                        label: "N° CIN"),*/

                    AppSpaces.verticalSpace20,

                    LabelledFormInput(
                        placeholder: "HikLHjD@&1?>",
                        keyboardType: "password",
                        controller: _passController,
                        obscureText: true,
                        label: "Votre mot de passe"),



          ]))))
    ]));
  }
}
