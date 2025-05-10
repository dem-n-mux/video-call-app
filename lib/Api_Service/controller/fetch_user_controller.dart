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

  Future signUpUser(int loginType, String fcmToken, String identity, String email, String country, String image,
      String name, String age, String gender, String password, String? referredBy) async {
    userData =
    await FetchUserService.signUpUser(loginType, fcmToken, identity, email, country, image, name, age, gender, password, referredBy);
    log("Signup User: ${jsonEncode(userData)}");
  }

  Future logInUser(String email, String password) async {
    userData = await FetchUserService.logInUser(email, password);
    log("Login User: ${jsonEncode(userData)}");
  }
}
