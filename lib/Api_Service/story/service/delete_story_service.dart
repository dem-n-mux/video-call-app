import 'dart:developer';

import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DeleteStoryService {

  static var client = http.Client();

  static Future deleteStory (String storyId ) async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    final queryParameters =
    {
      "storyId": storyId,
    };

    final uri = Uri.https( url , Constant.deleteStory , queryParameters);
    http.Response res = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.SECRET_KEY,
      },
    );

    var data = jsonDecode(res.body);

    log("Story Delete Response:- ${res.statusCode}");
    log("Story Delete Data:- $data");

    if (res.statusCode == 200) {
      return res;
    }


  }

}
