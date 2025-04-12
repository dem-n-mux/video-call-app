import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/models/withdraw_model.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/service/get_withdraw_service.dart';

class WithdrawController extends GetxController {
  WithdrawModel? withdrawModel;

  var isLoading = true.obs;

  Future withdrawData(String hostId) async {
    try {
      isLoading(true);
      withdrawModel = await WithdrawService.getWithdraw(hostId);
      log("withdraw data Is :- : ${jsonEncode(withdrawModel)}");

      if (withdrawModel!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
