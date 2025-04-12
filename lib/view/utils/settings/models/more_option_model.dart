import 'package:flutter/material.dart';


class MoreOption {
  Container container;
  String name;
  void Function() onTap;

  MoreOption(
      {required this.container, required this.name, required this.onTap});
}



class HostMoreOptionModel {
  Container container;
  String name;
  void Function() onTap;

  HostMoreOptionModel(
      {required this.container, required this.name, required this.onTap});
}

