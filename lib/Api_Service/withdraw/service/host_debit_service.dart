import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;
import '../models/host_debit_history_model.dart';


class HostDebitHistoryService {

  static var client = http.Client();

  static Future<HostDebitHistoryModel> hostDebitHistory (String hostId,[String? startDate,String? endDate]) async {
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


      final uri = Uri.http(url,Constant.hostDebitHistory,queryParameters);

      log("debit uri :-  $uri");

      http.Response response = await client.get(uri, headers: {"key": Constant.SECRET_KEY});


      log("host debit status code :- ${response.statusCode}");
      log("host debit response :- ${response.body}");


      var data = jsonDecode(response.body);

      log("host Debit data status code :- ${response.statusCode}");
      log("host Debit data is :- ${response.body}");

      if (response.statusCode == 200) {
        return HostDebitHistoryModel.fromJson(data);
    } else {
    log(response.body);
    }
    return HostDebitHistoryModel.fromJson(data);
    } catch (e) {
    throw Exception(e);
    }
  }
}
