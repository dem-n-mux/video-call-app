import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Complain/user_complain/get_user_complain/get_user_complain_service.dart';
import 'get_user_complain_model.dart';

class GetUserComplainController extends GetxController {
  var complainDataList = <Data>[].obs;
  var isLoading = true.obs;

  Future getUserComplain(String userId) async {
    try {
      isLoading(true);
      var getUserComplainData =
          await GetUserComplainService.getUserComplain(userId);
      complainDataList.value = getUserComplainData.data!;
      log("Get Complain: ${jsonEncode(getUserComplainData)}");
    } finally {
      isLoading(false);
    }
  }
}
