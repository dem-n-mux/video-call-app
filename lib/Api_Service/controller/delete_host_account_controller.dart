import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/view/user/screens/user_login_screen.dart';
import 'package:http/http.dart' as http;

class DeleteHostAccountController extends GetxController {
  var isLoading = true.obs;
  Future<void> deleteAccount(String hostId) async {
    try {
      String uri = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {"hostId": hostId};
      var url = Uri.https(uri, Constant.deleteHostAccount, queryParameters);
      log("Delete host Account url ::$url");
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
