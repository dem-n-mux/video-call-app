import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/story/model/story_view_model.dart';
import 'package:http/http.dart' as http;

class StoryViewService {
  static var client = http.Client();

  static Future<StoryViewModel> storyView(String storyId, String userId) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "storyId": storyId,
        "userId": userId,
      };

      log("queryParameters :::$queryParameters");
      final uri =
          Uri.http(url, Constant.storyView, queryParameters);
      log("uri :::$uri");

      log(uri.toString());
      http.Response response = await client.post(uri, headers: {
        "key": Constant.SECRET_KEY,
        'Content-Type': 'application/json; charset=UTF-8',
      });

      // var data = jsonDecode(response.body.toString());

    log(response.statusCode.toString());

      if (response.statusCode == 200) {
        return StoryViewModel.fromJson(jsonDecode(response.body));
      } else {
        log(response.body.toString());
        log(response.reasonPhrase.toString());
      }
      return StoryViewModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}
