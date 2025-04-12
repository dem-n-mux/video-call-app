import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/notification/user_notification/user_notification_model.dart';
import 'package:hokoo_flutter/Api_Service/notification/user_notification/user_notification_service.dart';

class UserNotificationController extends GetxController {

  UserNotificationModel? userNotificationModel;
  var isLoading = true.obs;

  Future getUserNotificationData (String userId) async {
    try{
      isLoading(true);
      userNotificationModel = await UserNotificationService.getUserNotification(userId);
      log("User Notification data Is :- : ${jsonEncode(userNotificationModel)}");

      if(userNotificationModel!.status==true)
      {
        isLoading(false);
      }

    }finally{
      isLoading(false);

    }
  }
}
