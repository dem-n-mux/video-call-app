import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/story/service/get_host_story_service.dart';
import '../model/get_host_story_model.dart';

class GetHostStoryController extends GetxController {
  var hostStoryList = <Story>[].obs;
  var isLoading = true.obs;

  Future getHostStory(
    String userId,
  ) async {
    try {
      isLoading(true);
      var hostStoryData = await GetHostStoryService.getHostStory(
        userId,
      );
      hostStoryList.value = hostStoryData.story!.cast<Story>();
    } finally {
      isLoading(false);
    }
  }
}
