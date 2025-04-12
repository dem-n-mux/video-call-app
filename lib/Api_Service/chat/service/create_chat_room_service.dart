import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/chat/model/create_chat_room_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

class CreateChatRoomService {
  static var client = http.Client();

  static Future<CreateChatRoomModel> createChatRoom(String userId, String hostId) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.createChatRoom);
      var payload = json.encode({
        "userId": userId,
        "hostId": hostId,
      }.map((key, value) => MapEntry(key, value.toString())));
      log("CreateChatRoom url $uri");
      log("CreateChatRoom payload $payload");

      final response = await http.post(uri,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "key": Constant.SECRET_KEY},
          body: payload);

      log(response.body);

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return CreateChatRoomModel.fromJson(data);
      } else {
        log(response.statusCode.toString());
      }
      return CreateChatRoomModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
