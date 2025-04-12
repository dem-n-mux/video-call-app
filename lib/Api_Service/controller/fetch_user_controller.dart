import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_user_model.dart';
import 'package:hokoo_flutter/Api_Service/service/fetch_user_service.dart';

class FetchUserController extends GetxController {
  FetchUserModel? userData;
  RxBool isLoading = false.obs;

  Future fetchUser(int loginType, String fcmToken, String identity, String email, String country, String image,
      String name, String age, String gender) async {
    userData =
    await FetchUserService.fetchUser(loginType, fcmToken, identity, email, country, image, name, age, gender);
    log("Fetch User: ${jsonEncode(userData)}");
  }
}
