import 'dart:developer';

import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_banner_model.dart';
import 'package:hokoo_flutter/Api_Service/service/fetch_banner_service.dart';

class FetchBannerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBanner();
  }

  List bannersImages = [];
  var isLoading = true.obs;
  FetchBannerModel? fetchBannerModel;

  Future fetchBanner() async {
    try {
      isLoading(true);
      fetchBannerModel = await FetchBannerService().fetchBanner();
      bannersImages = (fetchBannerModel!.banner?.map((item) => item.image).toList())!;
      log("bannersImages:- $bannersImages");
    } finally {
      isLoading(false);
    }
  }
}
