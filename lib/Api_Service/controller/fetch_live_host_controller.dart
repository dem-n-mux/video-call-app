import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_live_host_model.dart';
import 'package:hokoo_flutter/Api_Service/service/fetch_live_host_service.dart';

class FetchLiveHostController extends GetxController {
  FetchLiveHostModel? liveHostData;

  Future fetchLiveHost(String hostId) async {
    liveHostData = await FetchLiveHostService.fetchLiveHost(hostId);
    log("Live Host Data: ${jsonEncode(liveHostData)}");
  }
}
