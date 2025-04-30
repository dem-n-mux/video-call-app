import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

import '../models/host_credit_history_model.dart';



class HostCreditHistoryService {

  static var client = http.Client();

  static Future<HostCreditHistoryModel> hostCreditHistory (String hostId,[String? startDate,String? endDate]) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final Map<String, String?> queryParameters;

      if(startDate != null) {
        queryParameters = {
          "hostId": hostId,
          "startDate": startDate,
          "endDate": endDate,
        };
      }
      else {
        queryParameters = {
          "hostId": hostId,
        };
      }


      final uri = Uri.http(url,Constant.debitHistory,queryParameters);

      log("credit uri :-  $uri");

      http.Response response = await client.get(uri, headers: {"key": Constant.SECRET_KEY});

      log("host credit status code :- ${response.statusCode}");
      log("host credit response :- ${response.body}");

      var data = jsonDecode(response.body);

      log("host Credit data status code :- ${response.statusCode}");
      log("host Credit data is :- ${response.body}");

      if (response.statusCode == 200) {
        return HostCreditHistoryModel.fromJson(data);
      } else {
        log(response.body);
      }
      return HostCreditHistoryModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
