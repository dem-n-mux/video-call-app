import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/chat/model/get_old_chat_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

class GetOldChatService {
  static var client = http.Client();

  static Future<GetOldChatModel> getOldChat(String topicId) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "topicId": topicId,
      };

      final uri =
          Uri.http(url, Constant.getOldChat, queryParameters);

      http.Response response =
          await client.get(uri, headers: {"key": Constant.SECRET_KEY});

      log(response.statusCode.toString());
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data["status"] == true) {}
        return GetOldChatModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GetOldChatModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
