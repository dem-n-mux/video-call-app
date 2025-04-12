import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/gift/model/generate_gift_model.dart';
import 'package:hokoo_flutter/Api_Service/gift/service/generate_gift_service.dart';

class GenerateGiftController extends GetxController {
  GenerateGiftModel? generateGiftModel;
  var isLoading = true.obs;

  Future generateGift(String categoryId) async {
    try {
      isLoading(true);
      generateGiftModel = await GenerateGiftService.generateGift(categoryId);
      log("Generate Gift Data:- ${jsonEncode(generateGiftModel)}");
      if (generateGiftModel!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
