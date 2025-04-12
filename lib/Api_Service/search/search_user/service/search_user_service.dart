import 'dart:convert';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/search/search_user/modal/user_search_model.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:http/http.dart' as http;

/// Search User
class SearchUserProvider {
  static Future<UserSearchModel> searchUser(String search) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.searchUser);
      var payload = json.encode({
        "userId": loginUserId,
        "name": search,
      }.map((key, value) => MapEntry(key, value.toString())));

      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "key": Constant.SECRET_KEY
          },
          body: payload);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return UserSearchModel.fromJson(data);
      }
      return UserSearchModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
