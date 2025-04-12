import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'credit_history_model.dart';
import 'credit_history_service.dart';

class CreditHistoryController extends GetxController {
  CreditHistoryModel? creditHistoryModel;
  var isLoading = true.obs;

  Future getCreditHistory(String userId, String type,
      [String? startDate, String? endDate]) async {
    try {
      isLoading(true);
      creditHistoryModel = await CreditHistoryService.creditHistory(
          userId, type, startDate, endDate);
      log("credit history data :- ${jsonEncode(creditHistoryModel)}");
      if (creditHistoryModel!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
