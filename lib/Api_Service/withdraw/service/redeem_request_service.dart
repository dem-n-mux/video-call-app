import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

import '../models/redeem_request_model.dart';

class HostRedeemRequestHistoryService {

  static var client = http.Client();

  static Future<RedeemRequestModel> redeemRequestHistory (String hostId,[String? startDate,String? endDate]) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final Map<String, String?> queryParameters;
      if(startDate != null){
        queryParameters = {
          "hostId": hostId,
          "startDate":startDate,
          "endDate":endDate,
        };
      }else{
        queryParameters = {
          "hostId": hostId,
        };
      }

      final uri = Uri.http(url,Constant.getRedeemStatus,queryParameters);

      log("redeem uri :-  $uri");


      http.Response response = await client.get(uri, headers: {"key": Constant.SECRET_KEY});

      log("redeem request status code :- ${response.statusCode}");
      log("redeem request response :- ${response.body}");

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return RedeemRequestModel.fromJson(data);
      } else {
        log(response.body);
      }
      return RedeemRequestModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
