import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_host_model.dart';
import 'package:hokoo_flutter/Api_Service/service/update_host_service.dart';

class UpdateHostController extends GetxController {
  FetchHostModel? updateHostData;

  Future updateHost(
      String? name, String? bio, String? gender, String? dob) async {
    updateHostData =
        await UpdateHostService.updateHostDetails(name, bio, gender, dob);
    log("Update Host: ${jsonEncode(updateHostData)}");
  }
}
