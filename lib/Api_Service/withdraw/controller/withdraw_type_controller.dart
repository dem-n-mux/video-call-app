import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/models/get_withdraw_type_model.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/service/withdraw_type_service.dart';

class WithdrawTypeController extends GetxController {
  GetWithdrawTypeModel? getWithdrawTypeModel;
  var isLoading = true.obs;
  final TextEditingController withdrawController = TextEditingController();

  String? selectedWithdrawMethod;
  String selectedWithdrawValue = "";

  int withdrawSelectedIndex = 0;

  void onTapSelectedWithdrawMethod(int index) {
    withdrawSelectedIndex = index;

    selectedWithdrawMethod = getWithdrawTypeModel!.withdraw![index].name.toString();
    update();
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    withdrawType();
    super.onInit();
  }

  Future withdrawType() async {
    try {
      isLoading(true);
      getWithdrawTypeModel = await WithdrawTypeService.getWithdrawTypeService();
      update();
      log("Withdraw Type Data:- ${jsonEncode(getWithdrawTypeModel)}");
      if (getWithdrawTypeModel!.status == true) {
        log("getWithdrawTypeModel Type Data:- ${getWithdrawTypeModel?.toJson()}");
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
