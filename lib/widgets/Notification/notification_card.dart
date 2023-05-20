import 'package:flutter/material.dart';

class NotificationCard {
  final String name;
  final String profilePic;
  final String content;
  final String timeAgo;
  final bool hasStory;
  final bool userOnline;
  const NotificationCard({
    Key? key,
    required this.name,
    required this.profilePic,
    required this.content,
    required this.timeAgo,
    required this.hasStory,
    required this.userOnline,
  });
}
