import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Complain/host_complain/create_host_complain/create_host_complain_model.dart';
import 'package:hokoo_flutter/Api_Service/Complain/host_complain/create_host_complain/create_host_complain_service.dart';

class CreateHostComplainController extends GetxController {
  CreateHostComplainModel? createHostComplainModel;

  Future hostComplain(
      {required String message,
      required String contact,
      required String hostId}) async {
    createHostComplainModel =
        await CreateHostComplainService.createHostComplain(
            message: message, contact: contact, hostId: hostId);
    log("create Complain: ${jsonEncode(createHostComplainModel)}");
  }
}
