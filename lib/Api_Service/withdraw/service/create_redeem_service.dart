import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/models/create_redeem_model.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:http/http.dart' as http;

class RedeemService{

  static var client = http.Client();

  static Future<CreateRedeemModel> createRedeem(int coin,String paymentGateway,String description) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.createRedeem);

      log("%%%%%%%%%%%%%%%%%%%  $coin");
      log("%%%%%%%%%%%%%%%%%%%  $paymentGateway");
      log("%%%%%%%%%%%%%%%%%%%  $description");
      log("%%%%%%%%%%%%%%%%%%%  $loginUserId");

      var payload = json.encode({
        "hostId":loginUserId,
        "paymentGateway":paymentGateway,
        "description":description,
        "coin":coin,
      });

      final response = await http.post(uri, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.SECRET_KEY
      },body: payload);

      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        return CreateRedeemModel.fromJson(jsonDecode(response.body));
      } else {
        log(response.statusCode.toString());
      }
      return CreateRedeemModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}