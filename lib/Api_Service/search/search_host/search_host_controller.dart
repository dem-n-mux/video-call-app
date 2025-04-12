import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/search/search_host/search_host_service.dart';
import 'host_search_model.dart';

/// Search User Getx Controller ///

class SearchHostDataController extends GetxController {
  HostSearchModel? hostSearchModel;
  var isLoading = true.obs;

  void searchHostData(String search) async {
    try {
      isLoading(true);
      hostSearchModel = await HostSearchService.searchHost(search);
      log(hostSearchModel!.status.toString());
      log("Search Data: ${jsonEncode(hostSearchModel)}");
      if (hostSearchModel!.status!= true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
