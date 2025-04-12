import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/get_user_model.dart';
import 'package:http/http.dart' as http;

class GetUserService {
  static var client = http.Client();

  static Future<GetUserModel> getUser(String userId,String type) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "id": userId,
        "type": type,
      };

      final uri = Uri.http(url, Constant.getUser, queryParameters);
      log('get user url::::$uri');
      http.Response response = await client.get(uri, headers: {"key": Constant.SECRET_KEY});

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetUserModel.fromJson(data);
      } else {
        log("get user response::::${response.body}");
      }
      return GetUserModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
