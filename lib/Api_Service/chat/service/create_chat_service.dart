import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:hokoo_flutter/Api_Service/chat/model/create_chat_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:http/http.dart' as http;

class CreateChatService {
  static var client = http.Client();

  static createChat({
    required String topicId,
    required int messageType,
    required String senderId,
    required int type,
    required File sendFile,
  }) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.createChat);
      var request = http.MultipartRequest("POST", uri);
      if (messageType == 0) {
        var addImage =
            await http.MultipartFile.fromPath('image', sendFile.path);
        request.files.add(addImage);
      } else if (messageType == 2) {
        log("+++++++++++++++++++++++++++${sendFile.path}");
        var addImage =
            await http.MultipartFile.fromPath('audio', sendFile.path);
        request.files.add(addImage);
      }

      request.headers.addAll({"key": Constant.SECRET_KEY});

      Map<String, String> requestBody = {
        "topicId": topicId,
        "messageType": messageType,
        "senderId": senderId,
        "type": "$type",
      }.map((key, value) => MapEntry(key, value.toString()));

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        log("**************${data["chat"]}");
        log("=============${data["chat"]["topicId"]}====${data["chat"]["senderId"]}=======${data["chat"]["messageType"]}========${data["chat"]["type"]}=====${data["chat"]["image"]}");
        if (data["status"] == true) {
          if (data["chat"]["messageType"] == 0) {
            socket.emit("chat", {
              "topicId": data["chat"]["topicId"],
              "senderId": data["chat"]["senderId"],
              "messageType": data["chat"]["messageType"],
              "type": data["chat"]["type"],
              "message": data["chat"]["image"],
              "isRead": data["chat"]["isRead"],
              "date": data["chat"]["date"],
            });
          } else if (data["chat"]["messageType"] == 2) {
            socket.emit("chat", {
              "topicId": data["chat"]["topicId"],
              "senderId": data["chat"]["senderId"],
              "messageType": data["chat"]["messageType"],
              "type": data["chat"]["type"],
              "message": data["chat"]["audio"],
              "isRead": data["chat"]["isRead"],
              "date": data["chat"]["date"],
            });
          }
        }
        return CreateChatModel.fromJson(jsonDecode(res.body));
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
