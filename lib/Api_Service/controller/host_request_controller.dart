import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/host_request_model.dart';
import 'package:hokoo_flutter/Api_Service/service/host_request_service.dart';

class HostRequestController extends GetxController {
  HostRequestModel? hostRequestData;
  RxBool isLoading = false.obs;

  Future sendHostRequest(String bio, String country) async {
    isLoading(true);
    log("Enter in sendHostRequest");
    hostRequestData = await HostRequestService.sendHostRequest(bio, country);
    log("Host Request Response: ${jsonEncode(hostRequestData)}");
    isLoading(false);
  }
}
