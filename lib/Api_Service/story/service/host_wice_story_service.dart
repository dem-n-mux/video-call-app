import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/story/model/host_vise_story_model.dart';
import 'package:http/http.dart' as http;

class HostViceStoryService {

  static var client = http.Client();

  static Future<HostViseStoryModel> hostViceStory(String hostId) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "hostId": hostId,
      };

      final uri =
      Uri.http(url, Constant.hostViceAllStory, queryParameters);

      http.Response response =
      await client.get(uri, headers: {"key": Constant.SECRET_KEY});
      log(response.statusCode.toString());
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return HostViseStoryModel.fromJson(data);
      } else {
        log(response.body);
      }
      return HostViseStoryModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
