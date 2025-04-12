import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_host_model.dart';
import 'package:http/http.dart' as http;

class FetchHostService {
  static var client = http.Client();

  static Future<FetchHostModel> fetchHost(
      int loginType, String fcmToken, String identity, String email, String country, String name) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.fetchHost);
      var payload = json.encode({
        "loginType": loginType,
        "fcm_token": fcmToken,
        "identity": identity,
        "name": name,
        "email": email,
        "country": country,
      }.map((key, value) => MapEntry(key, value.toString())));
      log(" Fetch Host payload:::: $payload");
      log(" Fetch Host uri:::: $uri");
      final response = await http.post(uri,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "key": Constant.SECRET_KEY},
          body: payload);

      if (response.statusCode == 200) {
        log(" Fetch Host response.statusCode:::: ${response.body}");

        return FetchHostModel.fromJson(jsonDecode(response.body.toString()));
      } else {
        log(response.statusCode.toString());
      }
      return FetchHostModel.fromJson(jsonDecode(response.body.toString()));
    } catch (e) {
      throw Exception(e);
    }
  }
}
