import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/setting_model.dart';
import 'package:http/http.dart' as http;

class SettingService {
  static var client = http.Client();

  static Future<SettingModel> getSetting() async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.getSetting);

      final response = await client.get(uri,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "key": Constant.SECRET_KEY});
      log("Get Setting uri:- $uri");
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return SettingModel.fromJson(data);
      } else {
        log(response.statusCode.toString());
      }
      return SettingModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
