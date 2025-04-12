import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/gift/model/create_gift_category_model.dart';
import 'package:http/http.dart' as http;

class CreateGiftService {

  static var client = http.Client();

  static Future<CreateGiftCategoryModel> getCreateGift () async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.createGiftCategory);

      final response = await client.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.SECRET_KEY
      });

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return CreateGiftCategoryModel.fromJson(data);
      } else {
        log(response.statusCode.toString());
      }
      return CreateGiftCategoryModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }

  }

}
