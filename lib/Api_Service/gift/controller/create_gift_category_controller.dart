import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/gift/model/create_gift_category_model.dart';
import 'package:hokoo_flutter/Api_Service/gift/service/create_gift_category_service.dart';

class CreateGiftCategoryController extends GetxController {
  CreateGiftCategoryModel? createGiftCategoryModel;

  Future createGift() async {
    createGiftCategoryModel = await CreateGiftService.getCreateGift();
    log("Create Gift Category Data:- ${jsonEncode(createGiftCategoryModel)}");
  }
}
