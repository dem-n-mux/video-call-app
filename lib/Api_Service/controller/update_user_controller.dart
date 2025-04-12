import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_user_model.dart';
import 'package:hokoo_flutter/Api_Service/service/update_user_service.dart';

class UpdateUserController extends GetxController {
  FetchUserModel? updateUserData;

  Future updateUser(
      String? name, String? bio, String? gender, String? dob) async {
    updateUserData =
        await UpdateUserService.updateUserDetails(name, bio, gender, dob);
    log("Update User: ${jsonEncode(updateUserData)}");
  }
}
