import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'recharge_history_model.dart';
import 'recharge_history_service.dart';

class RechargeHistoryController extends GetxController {
  RechargeHistoryModel? rechargeHistoryModel;
  var isLoading = true.obs;

  Future getRechargeHistory(String userId, String type,
      [String? startDate, String? endDate]) async {
    try {
      isLoading(true);
      rechargeHistoryModel = await RechargeHistoryService.rechargeHistory(
          userId, type, startDate, endDate);
      log("recharge history data :- ${jsonEncode(rechargeHistoryModel)}");
      if (rechargeHistoryModel!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
