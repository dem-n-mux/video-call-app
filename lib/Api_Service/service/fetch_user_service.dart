import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_user_model.dart';
import 'package:http/http.dart' as http;

class FetchUserService {
  static var client = http.Client();

  static Future<FetchUserModel> fetchUser(int loginType, String fcmToken, String identity, String email,
      String country, String image, String name, String age, String gender) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.fetchUser);
      log("fetch User::::::: uri ::$uri");
      var payload = json.encode({
        "loginType": loginType,
        "fcm_token": fcmToken,
        "identity": identity,
        "email": email,
        "country": country,
        "name": name,
        "image": image,
        "age": age,
        "gender": gender,
      }.map((key, value) => MapEntry(key, value.toString())));
      log("fetch User::::::: payload   $payload");
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "key": Constant.SECRET_KEY
          },
          body: payload);

      if (response.statusCode == 200) {
        return FetchUserModel.fromJson(jsonDecode(response.body));
      } else {
        log(response.statusCode.toString());
      }
      return FetchUserModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}
