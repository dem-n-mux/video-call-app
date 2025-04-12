import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/check_user_model.dart';
import 'package:hokoo_flutter/Api_Service/service/check_user_service.dart';

class CheckUserController extends GetxController {
  CheckUserModel? checkUserModel;

  Future checkUser(String email) async {
    checkUserModel = await CheckUserService.checkUser(email);

    log("Get User: ${jsonEncode(checkUserModel)}");
  }
}
