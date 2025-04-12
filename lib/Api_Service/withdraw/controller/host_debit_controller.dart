import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/models/host_debit_history_model.dart';

import '../service/host_debit_service.dart';

class HostDebitHistoryController extends GetxController {

  HostDebitHistoryModel? hostDebitHistoryModel;
  var isLoading = true.obs;

  Future getHostDebitHistory(
      String hostId,
      [String? startDate,
        String? endDate,
      ]) async {
    try {
      isLoading(true);
      log("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      hostDebitHistoryModel = (await HostDebitHistoryService.hostDebitHistory(
          hostId,startDate, endDate));
      log("Host debit History Data Is :- ${jsonEncode(hostDebitHistoryModel)}");

      if (hostDebitHistoryModel!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
