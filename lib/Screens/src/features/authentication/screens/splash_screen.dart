import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tunisiacleanup/Screens/src/features/authentication/screens/page_indicator/home_page.dart';
import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
      });
    });

    Timer(
      const Duration(milliseconds: 10),(){
        setState(() {
          _isVisible = true; // Now it is showing fade effect and navigating to Login page
        });
      }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColors.primaryColor, MyColors.colorScheme],
          begin: FractionalOffset(0, 0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: const Center(
          child: SizedBox(
            height: 300.0,
            width: 300.0,
            child: Center(
              child: ClipOval(
                child: Image(image: AssetImage(tSplashImage)), //put your logo here
              ),
            ),
          ),
        ),
      ),
    );

  }
}