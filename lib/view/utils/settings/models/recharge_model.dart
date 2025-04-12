import 'package:flutter/material.dart';

class Recharge {
  Image image;
  String cardType;
  String time;
  double amount;
  void Function() onTap;

  Recharge({required this.image,required this.cardType,required this.time,required this.amount,required this.onTap});



}


class HostRechargeModel {
  Image image;
  String cardType;
  String time;
  double amount;
  void Function() onTap;

  HostRechargeModel({required this.image,required this.cardType,required this.time,required this.amount,required this.onTap});



}