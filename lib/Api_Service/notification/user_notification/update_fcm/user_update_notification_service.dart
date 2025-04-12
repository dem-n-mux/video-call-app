import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

import 'user_update_notification_model.dart';

class  UserUpdateNotificationService {

  static var client = http.Client();

  static Future<UserUpdateNotificationModel> userUpdateNotification (String userId,String fcmToken,String type) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "userId": userId,
        "fcm_token": fcmToken,
        "type": type,
      };

      final uri = Uri.https(url,Constant.userUpdateNotification,queryParameters);

      final response = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "key": Constant.SECRET_KEY
        },);

      var body = json.decode(response.body);

      log("Update User Notification Response :- ${response.statusCode}");
      log("Update User Notification data is :- ${response.body}");


      if (response.statusCode == 200) {
        return UserUpdateNotificationModel.fromJson(body);
      } else {
        log(response.body);
      }
      return UserUpdateNotificationModel.fromJson(body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
