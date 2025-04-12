import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:hokoo_flutter/Api_Service/Fetch_Country/Global_Country/global_country_model.dart';
import 'global_country_service.dart';

class GlobalCountryController extends GetxController {
  var isLoading = true.obs;
  GlobalCountryModel? globalCountryData;
  TextEditingController searchCountryController = TextEditingController();
  final Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  Future globalCountry(String searchCountryName) async {
    try {
      isLoading(true);
      globalCountryData = await GlobalCountryService.globalCountry(searchCountryName);
      if (globalCountryData!.status == true) {
        Flag globalModel = Flag(
            id: "",
            name: "Global",
            flag: "https://www.svgrepo.com/show/285172/planet-earth-global.svg",
            createdAt: "",
            updatedAt: "");
        globalCountryData!.flag!.insert(0, globalModel);
        update(["idCountry","idSearch"]);
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  Future globalCountryForProfile(String searchCountryName) async {
    isLoading(true);
    debouncer.call(() async {
    try {
      isLoading(true);

      globalCountryData = await GlobalCountryService.globalCountry(searchCountryName);
      log("object${globalCountryData?.flag?.length}");
       update(["idCountry","idSearch"]);
    } finally {
      isLoading(false);
    }});
  }
}
