import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/models/withdraw_model.dart';
import 'package:http/http.dart' as http;

class WithdrawService {

  static var client = http.Client();

  static Future<WithdrawModel> getWithdraw (String hostId) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);

      final queryParameters = {
        "hostId": hostId,
      };

      final uri = Uri.http(url,Constant.withdraw,queryParameters);

      http.Response response = await client.get(uri, headers: {"key": Constant.SECRET_KEY});

      var data = jsonDecode(response.body);

      log(uri.toString());
      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        return WithdrawModel.fromJson(data);
      } else {
        log(response.body);
      }
      return WithdrawModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
