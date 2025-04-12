import 'dart:developer';

import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/story/model/create_story_model.dart';
import 'package:hokoo_flutter/Api_Service/story/service/create_story_service.dart';

class CreateStoryController extends GetxController {
  CreateStoryModel? createStoryData;
  // var fetchBannerList = <Banner>[].obs;

  Future createStory() async {
    createStoryData = await CreateStoryService.createStory();
    log('createStoryData::::::$createStoryData');
  }
}
