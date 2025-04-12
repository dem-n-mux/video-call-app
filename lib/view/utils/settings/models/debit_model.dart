import 'package:flutter/material.dart';

class Debit {
  Image image;
  String cardType;
  String time;
  double amount;
  void Function() onTap;

  Debit({required this.image,required this.cardType,required this.time,required this.amount,required this.onTap});

}


class HostDebitModel {
  Image image;
  String cardType;
  String time;
  double amount;
  void Function() onTap;

  HostDebitModel({required this.image,required this.cardType,required this.time,required this.amount,required this.onTap});

}