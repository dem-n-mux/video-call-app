import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../models/host_credit_history_model.dart';
import '../service/host_credit_service.dart';

class HostCreditHistoryController extends GetxController {

  HostCreditHistoryModel? hostCreditHistoryModel;
  var isLoading = true.obs;

  Future getHostCreditHistory(
      String hostId,
      [String? startDate,
        String? endDate,
      ]) async {
    try {
      isLoading(true);
      log("##################");
      hostCreditHistoryModel = (await HostCreditHistoryService.hostCreditHistory(
          hostId,startDate, endDate));
      log("Host Credit History Data Is :- ${jsonEncode(hostCreditHistoryModel)}");

      if (hostCreditHistoryModel!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
