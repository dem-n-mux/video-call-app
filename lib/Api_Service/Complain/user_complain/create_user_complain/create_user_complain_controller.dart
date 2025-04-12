import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Complain/user_complain/create_user_complain/create_user_complain_model.dart';
import 'package:hokoo_flutter/Api_Service/Complain/user_complain/create_user_complain/create_user_complain_service.dart';

class CreateUserComplainController extends GetxController {
  CreateUserComplainModel? createUserComplainModel;

  Future userComplain(
      {required String message,
      required String contact,
      required String userId}) async {
    createUserComplainModel =
        await CreateUserComplainService.createUserComplain(
            message: message, contact: contact, userId: userId);
    log("create Complain: ${jsonEncode(createUserComplainModel)}");
  }
}
