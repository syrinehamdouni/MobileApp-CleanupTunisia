/*import 'package:flutter/material.dart';



import '../helper/ui_helper.dart';
import '../home_page.dart';

class ExploreContentWidget extends StatelessWidget {
  final double currentExplorePercent;
  const ExploreContentWidget(
      {required Key key, required this.currentExplorePercent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentExplorePercent != 0) {
      return Positioned(
        top: realH(
            standardHeight + (100 - standardHeight) * currentExplorePercent),
        width: screenWidth,
        child: SizedBox(
          height: screenHeight,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: realW(22)),
                child: const Text("Demandes",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              Stack(
                children: <Widget>[
                  Card(
                    color: Colors.white38,
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              'assets/dechets.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF006064),
                                  borderRadius:
                                  BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon:
                                      const Icon(Icons.delete),
                                      color: Colors.white,
                                    ),
                                    const Text(
                                      ' type déchest',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(4),
                                ),
                                child:  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 14,
                                      color: Color(0xFF006064),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        color: Color(0xFF006064),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'titer',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(

                                child:  Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundImage: AssetImage(
                                          'assets/images/profile.png'),
                                    ),
                                    SizedBox(width: 8),
                                    Text('syrin'),
                                  ],
                                ),
                              ),
                              /*Row(
                                children: const [
                                  Icon(Icons.chat_bubble_outline, color: Color(0xFF00C853),),
                                  SizedBox(width: 8),
                                  Text('02/03/2023 10:30'),
                                ],
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(bottom: realH(262)),
              )
            ],
          ),
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(0),
      );
    }
  }
}*/
