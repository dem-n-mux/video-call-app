import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'debit_history_model.dart';
import 'debit_history_service.dart';

class DebitHistoryController extends GetxController {

  DebitHistoryModel? debitHistoryModel;
  var isLoading = true.obs;

  Future getDebitHistory(
    String userId,
    int start,
    int limit,
      [String? startDate,
    String? endDate,
  ]) async {
    try {
      isLoading(true);
      debitHistoryModel = await DebitHistoryService.debitHistory(
          userId, start.toString(), limit.toString(), startDate, endDate);
      log("Debit History Data Is :- ${jsonEncode(debitHistoryModel)}");

      if (debitHistoryModel!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
