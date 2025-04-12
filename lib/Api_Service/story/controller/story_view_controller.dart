import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/story/model/story_view_model.dart';
import 'package:hokoo_flutter/Api_Service/story/service/story_view_service.dart';

class StoryViewController extends GetxController {
  StoryViewModel? storyViewData;

  Future storyView(String storyId, String userId) async {
    storyViewData = await StoryViewService.storyView(storyId, userId);
    log("Story View Response: ${jsonEncode(storyViewData)}");
  }
}
