import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/album/model/album_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  static addAlbum(String hostId) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "hostId": hostId,
      };

      final uri = Uri.http(url, Constant.album, queryParameters);
      var request = http.MultipartRequest("POST", uri);
      var addImage = await http.MultipartFile.fromPath('album', hostAlbumImage!.path);

      request.headers.addAll({"key": Constant.SECRET_KEY});

      request.files.add(addImage);

      var res1 = await request.send();

      var res = await http.Response.fromStream(res1);
      log(res.statusCode.toString());
      if (res.statusCode == 200) {
        hostAlbumImage = null;
        return AlbumModel.fromJson(jsonDecode(res.body));
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
