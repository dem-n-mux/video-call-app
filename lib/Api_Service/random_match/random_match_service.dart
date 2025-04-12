import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/random_match/random_call_model.dart';
import 'package:http/http.dart' as http;

class RandomMatchService {

  static var client = http.Client();

  static Future<RandomCallModel> randomMatch (String type,String userId) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "type": type,
        "userId": userId,
      };

      final uri = Uri.http(url, Constant.randomCall, queryParameters);
      log(uri.toString());
      http.Response response = await client.get(uri, headers: {"key": Constant.SECRET_KEY,});

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return RandomCallModel.fromJson(jsonDecode(response.body));
      } else {
        log(response.body);
      }
      return RandomCallModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}
