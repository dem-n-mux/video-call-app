import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/check_user_model.dart';
import 'package:http/http.dart' as http;

class CheckUserService {
  static var client = http.Client();

  static Future<CheckUserModel> checkUser(String email) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "email": email,
      };

      final uri = Uri.http(url, Constant.checkUser, queryParameters);
      log("Check user profile uri :: $uri");
      http.Response response = await client.get(uri, headers: {"key": Constant.SECRET_KEY});

      var data = jsonDecode(response.body);

      log("Check user profile data :: $data");
      log("Check user profile statusCode :: ${response.statusCode}");

      log("Check user profile statusCode :: ${response.statusCode}");
      if (response.statusCode == 200) {
        log("Check user profile statusCode :: $data");

        return CheckUserModel.fromJson(data);
      } else {
        log(response.body);
      }
      return CheckUserModel.fromJson(data);
    } catch (e) {
      log("Get User :::${e.toString()}");
      throw Exception(e);
    }
  }
}
