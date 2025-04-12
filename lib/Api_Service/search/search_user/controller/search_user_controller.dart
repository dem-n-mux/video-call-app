import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/search/search_user/modal/user_search_model.dart';
import 'package:hokoo_flutter/Api_Service/search/search_user/service/search_user_service.dart';

/// Search User Getx Controller ///

class SearchUserController extends GetxController {
  UserSearchModel? userSearchModel;
  var isLoading = true.obs;

  void fetchSearchUser(String search) async {
    try {
      isLoading(true);
      userSearchModel = await SearchUserProvider.searchUser(search);
      log(userSearchModel!.status.toString());
      log("Search Data: ${jsonEncode(userSearchModel)}");
      if (userSearchModel!.status != true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
