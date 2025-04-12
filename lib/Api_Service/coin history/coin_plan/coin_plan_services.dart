import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;
import 'coin_plan_model.dart';

class CreateHistoryService {
  static var client = http.Client();

  static Future<CoinPlanModel> createCoinHistory(
      String userId, String coinPlanId, String paymentGateway) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.coinHistory);

      var payload = json.encode({
        "userId": userId,
        "coinPlanId": coinPlanId,
        "paymentGateway": paymentGateway,
      }.map((key, value) => MapEntry(key, value.toString())));

      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "key": Constant.SECRET_KEY
          },
          body: payload);

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return CoinPlanModel.fromJson(data);
      } else {
        log(response.statusCode.toString());
      }
      return CoinPlanModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
