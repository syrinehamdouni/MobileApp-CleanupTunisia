import 'package:animated_number/animated_number.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tunisiacleanup/Data/data_model.dart';
import 'package:tunisiacleanup/widgets/Navigation/app_header.dart';


class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Map<String, double> dataMap = {
    "Demandes envoyées": 50,
    "Demandes terminées": 35,
    "demandes rejetées": 15,
  };

  List<Color> colorList = [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];



  int activeDay = 3;

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF006064),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    List expenses = [
      {
        "icon": Icons.image,
        "color": Colors.purpleAccent,
        "label": "Photos totale",

      },
      {
        "icon": Icons.person,
        "color": Colors.blue,
        "label": "Utilisatrices totals",
        "cost": "3"
      }
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Color(0xFF006064), boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 20, left: 20, bottom: 25),
              child: Column(
                  children: [
                    TaskezAppHeader(
                      title: "Statistiques",
                      widget: Icon(Icons.query_stats,color:Color(0xFF80CBC4) ,),

                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(months.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeDay = index;
                              });
                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width - 40) / 6,
                              child: Column(
                                children: [
                                  Text(
                                    months[index]['label'],
                                    style: TextStyle(fontSize: 10, color: Colors.white,),

                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: activeDay == index
                                            ? Color(0xFF009624)
                                            : Colors.white.withOpacity(0.02),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: activeDay == index
                                                ? Color(0xFF009624)
                                                :  const Color(0xFF80CBC4))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12, top: 7, bottom: 7),
                                      child: Text(
                                        months[index]['day'],
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: activeDay == index
                                                ? Colors.white
                                                : Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  ]
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                     Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Collect des déchets",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: Color(0xFF004040)),
                          ),



                        ],
                      ),
                    ),



                    PieChart(
                      dataMap: dataMap,
                      colorList: colorList,
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      centerText: "Tunisie",
                      ringStrokeWidth: 50,
                      animationDuration: const Duration(seconds: 5),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValues: true,
                        showChartValuesOutside: true,
                        showChartValuesInPercentage: false,
                        showChartValueBackground: false,

                      ),
                      legendOptions: const LegendOptions(
                          showLegends: true,
                          legendShape: BoxShape.rectangle,
                          legendTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
                          legendPosition: LegendPosition.bottom,
                          showLegendsInRow: true),
                      // Increase the spacing between the chart and the legend
                      // animationController: _controller,
                    ),

                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
              spacing: 20,
              children: List.generate(expenses.length, (index) {
                return Container(
                  width: (size.width - 70) / 2,
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left:50, right: 50, top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: expenses[index]['color']),
                          child: Center(
                              child: Icon(
                                expenses[index]['icon'],
                                color: Colors.white,
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expenses[index]['label'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10,
                                  color: Color(0xFF004040)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const AnimatedNumber(
                              startValue: 0,
                              endValue: 10,
                              duration: Duration(seconds: 3),
                              isFloatingPoint: false,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }
}
