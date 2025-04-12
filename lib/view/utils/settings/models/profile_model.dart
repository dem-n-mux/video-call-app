import 'package:flutter/material.dart';


class UserProfile {
  String name;
  String icon;
  Color color;
  void Function() onTap;

  UserProfile(
      {required this.color,
      required this.onTap,
      required this.icon,
      required this.name});
}


class HostProfileModel {
  String name;
  String icon;
  Color color;
  void Function() onTap;

  HostProfileModel(
      {required this.color,
        required this.onTap,
        required this.icon,
        required this.name});
}