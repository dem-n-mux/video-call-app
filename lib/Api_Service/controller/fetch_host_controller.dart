import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_host_model.dart';
import 'package:hokoo_flutter/Api_Service/service/fetch_host_service.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchHostController extends GetxController {
  FetchHostModel? hostData;

  Future fetchHost(int loginType, String fcmToken, String identity, String email, String country, String name) async {
    hostData = await FetchHostService.fetchHost(loginType, fcmToken, identity, email, country,name);
    if (hostData!.status == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("hostCoin", hostData!.host!.coin.toString());
      hostCoin.value = preferences.getString("hostCoin")!;
    }

    log("Fetch Host: ${jsonEncode(hostData)}");
  }
}
