import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Complain/host_complain/get_host_complain/get_host_complain_service.dart';
import 'get_host_complain_model.dart';

class GetHostComplainController extends GetxController {
  var complainDataList = <Data>[].obs;
  var isLoading = true.obs;

  Future getHostComplain(String hostId) async {
    try {
      isLoading(true);
      var getHostComplainData =
          await GetHostComplainService.getHostComplain(hostId);
      complainDataList.value = getHostComplainData.data!;
      log("Get Complain: ${jsonEncode(getHostComplainData)}");
    } finally {
      isLoading(false);
    }
  }
}
