import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/host_status_model.dart';
import 'package:hokoo_flutter/Api_Service/service/host_status_service.dart';

class HostStatusController extends GetxController {
  HostStatusModel? hostStatusData;
  RxBool status = true.obs;

  Future checkHostStatus(String hostId) async {
    hostStatusData = await HostStatusService.checkStatus(hostId);
    status.value = hostStatusData!.host!.isOnline!;
    log("Host Status Data: ${jsonEncode(hostStatusData)}");
  }
}
