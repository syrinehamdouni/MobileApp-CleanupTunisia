import 'package:flutter/material.dart';
import '../Values/values.dart';

class AppData {

  static final List<Map<String, dynamic>> notificationMentions = [

    {
      "name": "Employé municipal",
      "profilePic": "assets/memoji/1.png",
      "content":  " envoyer un message. ",
      "timeAgo":  "1m",
      "hasStory" :   true,
      "userOnline": true,
    },
    {
      "name": "syrin",
      "profilePic": "assets/memoji/2.png",
      "content":  " envoyer un message. ",
      "timeAgo":  "1m",
      "hasStory" :   true,
      "userOnline": true,
    },

  ];

  static final List<String> profileImages = [
    "assets/memoji/1.png",
    "assets/memoji/2.png",

  ];

  static final List<Color> groupBackgroundColors = [
    HexColor.fromHex("BCF2C7"),
    HexColor.fromHex("8D96FF"),
    HexColor.fromHex("A5F69C"),
    HexColor.fromHex("FCA3FF")
  ];

  static final List<Map<String, dynamic>> onlineUsers = [
    {
      "name": "Employé municipal",
      "profileImage": "assets/memoji/1.png",
      "color": "BAF0C5",

    },
    {
      "name": "syrin",
      "profileImage": "assets/memoji/2.png",
      "color": "DACFFE",

    },

  ];


}
List months = [
  {"label": "2023", "day": "Janv"},
  {"label": "2023", "day": "Févr"},
  {"label": "2023", "day": "Mars"},
  {"label": "2023", "day": "Avr"},
  {"label": "2023", "day": "Mai"},
  {"label": "2023", "day": "Juin"},
  {"label": "2023", "day": "Juil"},
  {"label": "2023", "day": "Aout"},
  {"label": "2023", "day": "Sept"},
  {"label": "2023", "day": "Oct"},
  {"label": "2023", "day": "Nov"},
  {"label": "2023", "day": "Déc"},
];