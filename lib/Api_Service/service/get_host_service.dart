import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/get_host_model.dart';
import 'package:http/http.dart' as http;

class GetHostService {
  static var client = http.Client();

  static Future<GetHostModel> getHost(String hostId) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "hostId": hostId,
      };

      final uri = Uri.http(url, Constant.getHost, queryParameters);
      log("GetHost  uri::::$uri ");
      http.Response response = await client.get(uri, headers: {"key": Constant.SECRET_KEY});

      var data = jsonDecode(response.body);
      log("GetHost  data::::$data ");
      if (response.statusCode == 200) {
        return GetHostModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GetHostModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
