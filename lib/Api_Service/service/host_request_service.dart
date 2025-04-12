import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/host_request_model.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:http/http.dart' as http;

class HostRequestService {
  static sendHostRequest(String bio, String country) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.hostRequest);
      log("Host Request Url => $uri");
      var request = http.MultipartRequest("POST", uri);
      var addImage = await http.MultipartFile.fromPath('image', hostRequestImage!.path);
      var addVideo = await http.MultipartFile.fromPath('video', hostRequestVideo!.path);

      request.headers.addAll({"key": Constant.SECRET_KEY});

      request.files.add(addImage);
      request.files.add(addVideo);

      Map<String, String> requestBody = <String, String>{
        "userId": loginUserId,
        "bio": bio,
        "country": country,
      };
      log("Host Request Body => $requestBody");

      request.fields.addAll(requestBody);

      var res1 = await request.send();

      var res = await http.Response.fromStream(res1);
      log("HostRequest statuscode :: ${res.statusCode}");
      if (res.statusCode == 200) {
        return HostRequestModel.fromJson(jsonDecode(res.body));
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
