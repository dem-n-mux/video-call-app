import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/models/create_redeem_model.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/service/create_redeem_service.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';

class CreateRedeemController extends GetxController {
  CreateRedeemModel? createRedeemModel;

  Future createRedeem(
      int coin,String paymentGateway,String description) async {
    log("&&&&&&&& $coin");
    log("&&&&&&&& $paymentGateway");
    log("&&&&&&&& $description");
    log("&&&&&&&& $loginUserId");
    createRedeemModel =
        await RedeemService.createRedeem(coin, paymentGateway, description);
    if(createRedeemModel!.status == true){
      int hostCoinIs = int.parse(hostCoin.value);
      hostCoinIs = hostCoinIs - coin;
      hostCoin.value = "$hostCoinIs";
    }
    log("Create Redeem: ${jsonEncode(createRedeemModel)}");
  }
}
