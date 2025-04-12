import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/get_coin_plan_model.dart';
import 'package:http/http.dart' as http;

class GetCoinPlanService {
  static var client = http.Client();

  static Future<GetCoinPlanModel> getCoinPlan() async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.coinPlan);
      final response = await client.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "key": Constant.SECRET_KEY
        },
      );
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("${response.statusCode}");
        log(response.body);
      }

      if (response.statusCode == 200) {
        return GetCoinPlanModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GetCoinPlanModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
