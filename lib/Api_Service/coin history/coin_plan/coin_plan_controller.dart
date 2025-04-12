import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'coin_plan_model.dart';
import 'coin_plan_services.dart';

class CoinPlanController extends GetxController {
  CoinPlanModel? coinPlanCreateHistoryModel;

  Future coinPlanHistory(
      String userId, String coinPlanId, String paymentGateway) async {
    coinPlanCreateHistoryModel = await CreateHistoryService.createCoinHistory(
        userId, coinPlanId, paymentGateway);
    log("Coin Plan data Is :- ${jsonEncode(coinPlanCreateHistoryModel)}");
  }
}
