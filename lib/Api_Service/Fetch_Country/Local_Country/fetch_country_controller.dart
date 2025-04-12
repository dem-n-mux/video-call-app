import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Fetch_Country/Local_Country/fetch_country_service.dart';

class FetchCountryController extends GetxController {
  var isLoading = true.obs;
  dynamic fetchCountryData;

  Future fetchCountry() async {
    try {
      isLoading(true);
      fetchCountryData = await FetchCountryService.fetchCountry();
      log("Fetch Country:- ${jsonEncode(fetchCountryData)}");
    } finally {
      isLoading(false);
    }
  }
}
