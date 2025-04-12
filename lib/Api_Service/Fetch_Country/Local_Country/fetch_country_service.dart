import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchCountryService {
  static var client = http.Client();

  static Future fetchCountry() async {
    try {
      var uri = Uri.parse(Constant.fetchCountry);

      final response = await client.get(uri);
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("fetchCountry", response.body);
        preferences.getString("fetchCountry")!;
        return jsonDecode(response.body);
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
