import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';

import '../models/redeem_request_model.dart';
import '../service/redeem_request_service.dart';

class RedeemRequestHistoryController extends GetxController {

  RedeemRequestModel? redeemRequestModel;
  var isLoading = true.obs;

  Future getHostRedeemRequestHistory(String hostId,[String? startDate,String? endDate]) async {
    try {
      isLoading(true);
      log("@@@@@@@@@@@@@@@@@@@@@@@@@");
      redeemRequestModel = await HostRedeemRequestHistoryService.redeemRequestHistory(hostId,startDate,endDate);
      log("redeem request data :- ${jsonEncode(redeemRequestModel)}");
      if (redeemRequestModel!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
