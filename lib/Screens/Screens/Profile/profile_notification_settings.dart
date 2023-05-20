import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunisiacleanup/Constants/constants.dart';
import 'package:tunisiacleanup/Values/values.dart';
import 'package:tunisiacleanup/widgets/Buttons/primary_progress_button.dart';
import 'package:tunisiacleanup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:tunisiacleanup/widgets/Navigation/app_header.dart';
import 'package:tunisiacleanup/widgets/container_label.dart';

import '../../src/constants/colors.dart';

class ProfileNotificationSettings extends StatelessWidget {
  ProfileNotificationSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _assignmedToMe = ValueNotifier(true);
    final _taskCompleted = ValueNotifier(false);
    final _mentionedMe = ValueNotifier(true);
    final _directMessage = ValueNotifier(false);
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
                    TaskezAppHeader(
              title: "$tabSpace Notifications",
              widget: PrimaryProgressButton(
                width: 80,
                height: 40,
                label: "Sauver",
                textStyle: GoogleFonts.lato(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            AppSpaces.verticalSpace40,
            Container(
                width: double.infinity,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryBackgroundColor),
                /*child: Column(children: [
                  LabelledOption(
                    label: '30 minutes',
                    icon: Icons.lock_clock,
                  ),
                  LabelledOption(
                    label: '1 hour',
                    icon: Icons.lock_clock,
                  ),
                  LabelledOption(
                    label: 'Until Tomorrow',
                    icon: Icons.calendar_today,
                  ),
                  LabelledOption(
                    label: 'Until next 2 days',
                    icon: Icons.calendar_today,
                  ),
                  LabelledOption(
                    label: 'Custom',
                    icon: Icons.calendar_today,
                  ),*/
                ),
            AppSpaces.verticalSpace40,
            ContainerLabel(label: "NOTIFY MY ABOUT"),
            AppSpaces.verticalSpace40,
            LabelledCheckbox(
              label: "Task assigned to me",
              notifierValue: _assignmedToMe,
            ),
            LabelledCheckbox(
                label: "Task completed", notifierValue: _taskCompleted),
            LabelledCheckbox(
                label: "Mentioned Me", notifierValue: _mentionedMe),
            LabelledCheckbox(
                label: "Direct Message", notifierValue: _directMessage),
          ]))))
    ]));
  }
}

class LabelledCheckbox extends StatelessWidget {
  final String label;
  final ValueNotifier<bool>? notifierValue;

  const LabelledCheckbox({
    required this.label,
    Key? key,
    this.notifierValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: GoogleFonts.lato(color: Colors.white, fontSize: 17)),
      Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.grey,
        ),
        child: ValueListenableBuilder(
            valueListenable: notifierValue!,
            builder: (BuildContext context, _, __) {
              return Checkbox(
                  value: notifierValue!.value,
                  activeColor: AppColors.primaryAccentColor,
                  onChanged: (bool? value) => notifierValue!.value = value!);
            }),
      ),
    ]);
  }
}
