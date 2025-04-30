import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/album/model/delete_album_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

class DeleteAlbumService {
  static var client = http.Client();

  static Future<DeleteAlbumModel> deleteAlbum(
      String hostId, String position) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "hostId": hostId,
        "position": position,
      };

      final uri =
          Uri.http(url, Constant.deleteAlbum, queryParameters);

      log(uri.toString());

      http.Response response =
          await client.delete(uri, headers: {"key": Constant.SECRET_KEY});

      var data = jsonDecode(response.body);

      log("delete album status code :- ${response.statusCode}");

      log("Show album data :- ${response.body}");

      if (response.statusCode == 200) {
        return DeleteAlbumModel.fromJson(data);
      } else {
        log(response.body);
      }
      return DeleteAlbumModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
