import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/get_user_model.dart';
import 'package:hokoo_flutter/Api_Service/service/get_user_service.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserController extends GetxController {
  GetUserModel? getUserData;

  Future getUser(String userId,String type) async {
    getUserData = await GetUserService.getUser(userId,type);
    if (getUserData!.status == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("userCoin", getUserData!.findUser!.coin.toString());
      userCoin.value = preferences.getString("userCoin")!;
    }
    log("Get User: ${jsonEncode(getUserData)}");
  }
}
