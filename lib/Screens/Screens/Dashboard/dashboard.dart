import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunisiacleanup/Screens/Screens/Dashboard/dashboardmodel.dart';
import 'package:tunisiacleanup/Screens/Screens/TagWastePage.dart';
import 'package:tunisiacleanup/Values/values.dart';
import 'package:tunisiacleanup/widgets/Buttons/primary_tab_buttons.dart';
import 'package:tunisiacleanup/widgets/Navigation/dasboard_header.dart';
import '../Profile/profile_overview.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.data}) : super(key: key);
  final List<DashModel> data;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ValueNotifier<int> _buttonTrigger = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardNav(
                icon: FontAwesomeIcons.history,
                image: "assets/images/profile.png",
                notificationCount: "3",
                title: "CleanUp",
                onImageTapped: () {
                  Get.to(() => ProfileOverview());
                },
              ),
              AppSpaces.verticalSpace20,
              Text("Bienvenue, 👋",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              Text("كيما قالو ناس بكري : لي فاتك بالزين فوتو بالنظافة ",
                  style: GoogleFonts.sacramento(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              AppSpaces.verticalSpace20,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //tab indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PrimaryTabButton(
                        callback: () {
                          setState(() {
                            widget.data.removeWhere(
                              (element) => element.isSelected == true,
                            );
                          });
                        },
                        buttonText: "Supprimer",
                        itemIndex: 0,
                        notifier: _buttonTrigger),
                    PrimaryTabButton(
                        callback: () {
                          for (DashModel element in widget.data) {
                            if (element.isSelected) {
                              final argument = element.name;
                              if (argument != null) {
                                Get.to(() => WasteTypePage(), arguments: argument);
                              }
                            }
                          }
                        },

                        buttonText: "Envoyer",
                        itemIndex: 1,
                        notifier: _buttonTrigger)
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                )
              ]),
              AppSpaces.verticalSpace20,
              GridView.builder(
                itemCount: widget.data.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.data[index].isSelected =
                          !widget.data[index].isSelected;
                    });
                  },
                  child: Card(
                    elevation: 10,
                    color: Colors.white10,
                    child: Stack(children: [
                      Image.file(widget.data[index].name,
                          fit: BoxFit.cover,
                          height: Get.height,
                          width: Get.width),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Checkbox(
                          value: widget.data[index].isSelected,
                          onChanged: (value) {},
                        ),
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
