import 'package:flutter/material.dart';

class Credit {
  Image image;
  String cardType;
  String time;
  double amount;
  void Function() onTap;

  Credit({required this.image,required this.cardType,required this.time,required this.amount,required this.onTap});



}


class HostCreditModel {
  Image image;
  String cardType;
  String time;
  double amount;
  void Function() onTap;

  HostCreditModel({required this.image,required this.cardType,required this.time,required this.amount,required this.onTap});



}