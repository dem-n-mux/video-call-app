import 'dart:convert';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/video%20call/model/make_call_model.dart';
import 'package:http/http.dart' as http;

class MakeCallService {
  static var client = http.Client();

  static Future<MakeCallModel> makeCall({
    required String callerId,
    required String receiverId,
    required String videoCallType,
    required String userImage,
    required String username,
    required String matchName,
    required String matchImage,
    required String statusType,
  }) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.makeCall);
      var payload = json.encode({
        "callerId": callerId,
        "receiverId": receiverId,
        "videoCallType": videoCallType,
        "callerImage": userImage,
        "callerName": username,
        "statusType": statusType
      }.map((key, value) => MapEntry(key, value.toString())));

      final response = await http.post(uri,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "key": Constant.SECRET_KEY},
          body: payload);
      var data = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        return MakeCallModel.fromJson(data);
      }
      return MakeCallModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
