import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/random_match/random_call_model.dart';
import 'package:hokoo_flutter/Api_Service/random_match/random_match_service.dart';

class RandomMatchController extends GetxController {

  RandomCallModel? randomCallModel;

  Future randomCallData(String type, String userId) async {

    randomCallModel = await RandomMatchService.randomMatch(type, userId);

    log("Random Call Data :- ${jsonEncode(randomCallModel)}");

  }
}
