import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/get_coin_plan_model.dart';
import 'package:hokoo_flutter/Api_Service/service/get_coin_plan_service.dart';

class FetchCoinPlanController extends GetxController {
  var coinPlanList = <CoinPlan>[].obs;
  var isLoading = true.obs;

  Future fetchCoinPlan() async {
    try {
      isLoading(true);
      var coinPlanData = await GetCoinPlanService.getCoinPlan();
      coinPlanList.value = coinPlanData.coinPlan!;
      log("Coin Plan :-${jsonEncode(coinPlanData)}");
      if (coinPlanData.status != true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
