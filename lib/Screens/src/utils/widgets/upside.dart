import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';




class Upside extends StatelessWidget {
  const Upside({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: new BoxDecoration(gradient: new LinearGradient( colors: [MyColors.primaryColor,MyColors.colorScheme],)),
          width: size.width,
          height: size.height / 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Image.asset(
              imgUrl,
              alignment: Alignment.topCenter,
              scale: 8,
            ),
          ),
        ),

        Positioned(
          left: 0,
          top: 175,
          child: Image.network(
            "https://ouch-cdn2.icons8.com/gEMjZ4ZC639WYTYjpan-J3XByArwXzS7lUcNL-UMVdk/rs:fit:196:289/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMi80/NzU5OTI4ZS04OWE3/LTRhOTYtYjdjMi0w/ZDA0MWI2Y2E3MTQu/c3Zn.png",
            scale: 3,
          ),
        ),
        Positioned(
          right: 0,
          top: 60,
          child: Image.network(
            "https://ouch-cdn2.icons8.com/vKz7XNZvZiNKlkUWT2HjP8oNZ8hZ0UblhuF8J6sGRGI/rs:fit:196:112/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNjg3/LzA3ZDZiZjRmLWFj/OTYtNGRmMy05ZGYz/LTNhNWQzOWI5NGYz/MC5zdmc.png",
            scale: 3,
          ),
        ),
      ],
    );
  }
}

class PageTitleBar extends StatelessWidget {
  const PageTitleBar({ Key? key,required this.title }) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 260.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: const BoxDecoration(
          color: Color(0xFFA5D6A7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Color(0xfff575861)
            ),
          ),
        ),
      ),
    );
  }
}


