import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/notification/user_notification/update_fcm/user_update_notification_service.dart';

import 'user_update_notification_model.dart';

class UserUpdateNotificationController extends GetxController {

  UserUpdateNotificationModel? userUpdateNotification;

  Future userUpdateNotificationIs (String userId,String fcmToken,String type) async {
    userUpdateNotification = await UserUpdateNotificationService.userUpdateNotification(userId,fcmToken,type);
  }
}
