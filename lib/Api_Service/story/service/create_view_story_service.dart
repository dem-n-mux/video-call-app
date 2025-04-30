import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/story/model/create_view_story_model.dart';
import 'package:http/http.dart' as http;

class CreateViewStoryService {
  static var client = http.Client();

  static Future<CreateViewStoryModel> createViewStory (String storyId, String userId) async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);

    try {
      final queryParameters = {
        "storyId": storyId,
        "userId": userId,
      };

      final uri = Uri.http(url, Constant.createViewStory, queryParameters);

      http.Response response = await client.patch(uri, headers: {"key": Constant.SECRET_KEY});

      var data = jsonDecode(response.body);

      log("Create View Story Response :- ${response.statusCode}");
      log("Create View Story Data :- ${response.body}");

      if (response.statusCode == 200) {
        return CreateViewStoryModel.fromJson(data);
      } else {
        log(response.body);
      }
      return CreateViewStoryModel.fromJson(data);

    } catch (e) {
      throw Exception(e);
    }
  }
}
