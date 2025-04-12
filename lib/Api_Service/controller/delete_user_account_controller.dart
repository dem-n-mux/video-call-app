import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hokoo_flutter/view/user/screens/user_login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';

class DeleteUserAccountController extends GetxController {
  var isLoading = true.obs;
  Future<void> deleteAccount(String userId) async {
    try {
      String uri = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {"userId": userId};
      var url = Uri.https(uri, Constant.deleteUserAccount, queryParameters);
      log("Delete Account url ::$url");
      final header = {"Key": Constant.SECRET_KEY};
      var response = await http.delete(url, headers: header);
      log("delete Account Response :: ${response.body}");
      if (response.statusCode == 200) {
        await Fluttertoast.showToast(
          msg: "Account Delete SuccessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black.withOpacity(0.35),
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Get.back();
        Get.offAll(const UserLoginScreen());
      }
    } catch (e) {
      log("Api Response Error :: $e");
    }
  }
}
