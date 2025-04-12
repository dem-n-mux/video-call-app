import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/story/service/delete_story_service.dart';


class DeleteStoryController extends GetxController {

  Future deleteStoryIs (String storyId) async {
    await DeleteStoryService.deleteStory(storyId);
  }
}
