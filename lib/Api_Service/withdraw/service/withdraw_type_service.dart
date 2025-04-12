import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/models/get_withdraw_type_model.dart';
import 'package:http/http.dart' as http;

class WithdrawTypeService {

  static var client = http.Client();

  static Future<GetWithdrawTypeModel> getWithdrawTypeService() async {
    try {
      var uri = Uri.parse(Constant.BASE_URL+Constant.getWithdrawType);

      final response = await client.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.SECRET_KEY
      });

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetWithdrawTypeModel.fromJson(data);
      } else {
        log(response.statusCode.toString());
      }
      return GetWithdrawTypeModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }

  }

}
