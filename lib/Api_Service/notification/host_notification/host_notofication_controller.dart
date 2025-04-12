import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/notification/host_notification/host_notification_model.dart';
import 'package:hokoo_flutter/Api_Service/notification/host_notification/host_notification_service.dart';

class HostNotificationController extends GetxController {

  HostNotificationModel? hostNotificationModel;
  var isLoading = true.obs;

  Future getHostNotificationData (String hostId) async {
    try{
      isLoading(true);
      hostNotificationModel = await HostNotificationService.getHostNotification(hostId);
      log("host notification data Is :- : ${jsonEncode(hostNotificationModel)}");

      if(hostNotificationModel!.status==true)
        {
          isLoading(false);
        }

    }finally{
      isLoading(false);

    }
  }
}
