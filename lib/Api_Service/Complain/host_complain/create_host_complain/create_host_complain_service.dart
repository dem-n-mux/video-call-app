import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/Complain/host_complain/create_host_complain/create_host_complain_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:http/http.dart' as http;

class CreateHostComplainService {
  final client = http.Client();

  static Future<CreateHostComplainModel> createHostComplain(
      {required String message,
      required String contact,
      required String hostId}) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.createComplain);
      var request = http.MultipartRequest("POST", uri);
      if (on == true) {
        var addImage =
            await http.MultipartFile.fromPath('image', hostComplainImage!.path);
        request.files.add(addImage);
      }

      request.headers.addAll({"key": Constant.SECRET_KEY});

      Map<String, String> requestBody = <String, String>{
        "message": message,
        "contact": contact,
        "hostId": hostId,
      };

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      if (res.statusCode == 200) {
        return CreateHostComplainModel.fromJson(jsonDecode(res.body));
      } else {
        log(res.statusCode.toString());
        return CreateHostComplainModel.fromJson(jsonDecode(res.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
