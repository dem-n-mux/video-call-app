import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

import '../model/fetch_banner_model.dart';

class FetchBannerService {
  static var client = http.Client();

  Future<FetchBannerModel?> fetchBanner() async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.fetchBanner);

      final response = await client.get(uri,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "key": Constant.SECRET_KEY});

      log("Response body banner :: ${response.body}");
      if (response.statusCode == 200) {
        return FetchBannerModel.fromJson(jsonDecode(response.body));
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
