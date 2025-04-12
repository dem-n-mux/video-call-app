import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/setting_model.dart';
import 'package:hokoo_flutter/Api_Service/service/setting_service.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';

class SettingController extends GetxController {
  SettingModel? getSetting;
  var isLoading = true.obs;

  Future setting() async {
    try {
      isLoading(true);
      getSetting = await SettingService.getSetting();
      log("Setting Data:- ${jsonEncode(getSetting)}");

      chargeForPrivateCall = getSetting?.setting?.chargeForPrivateCall ?? 0;
      chargeForRandomCall = getSetting?.setting?.chargeForRandomCall ?? 0;

      log("Charge For PrivateCall :: $chargeForPrivateCall");
      log("Charge For RandomCall :: $chargeForRandomCall");

      if (getSetting!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
