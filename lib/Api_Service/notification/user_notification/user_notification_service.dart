import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/notification/user_notification/user_notification_model.dart';
import 'package:http/http.dart' as http;

class UserNotificationService {

  static var client = http.Client();

  static Future<UserNotificationModel> getUserNotification (String userId) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "userId": userId,
      };

      final uri = Uri.http(url,Constant.userNotification,queryParameters);

      http.Response response = await client.get(uri, headers: {"key": Constant.SECRET_KEY});

      var data = jsonDecode(response.body);

      log(uri.toString());
      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        return UserNotificationModel.fromJson(data);
      } else {
        log(response.body);
      }
      return UserNotificationModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
