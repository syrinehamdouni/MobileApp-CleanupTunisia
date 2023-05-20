// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class DashModel {
  File name;
  bool isSelected;
  String imageUrl; // added
  DashModel({
    required this.name,
    required this.isSelected,
    this.imageUrl = '', // added
  });
}

