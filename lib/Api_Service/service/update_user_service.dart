import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_user_model.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:http/http.dart' as http;

class UpdateUserService {
  static var client = http.Client();

  static updateUserDetails(
      String? name, String? bio, String? gender, String? dob) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.updateUser);
      var request = http.MultipartRequest("PATCH", uri);

      if (on == true) {
        var addImage = await http.MultipartFile.fromPath(
            'image', getUserProfileImage!.path);
        request.files.add(addImage);
      }

      request.headers.addAll({"key": Constant.SECRET_KEY});

      Map<String, String> requestBody = <String, String>{
        "userId": loginUserId,
        "name": name ?? userName,
        "gender": gender ?? userGender,
        "dob": dob ?? userDob,
        "bio": bio ?? userBio,
      };

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      if (res.statusCode == 200) {
        return FetchUserModel.fromJson(jsonDecode(res.body));
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
