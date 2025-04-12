import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/story/model/create_user_view_story_model.dart';
import 'package:hokoo_flutter/Api_Service/story/service/create_user_view_story_service.dart';


class CreateUserViewStoryController extends GetxController {

  CreateUserViewStoryModel? createUserViewStoryData;

  Future createUserViewStoryIs (String userId, String storyId) async {
    createUserViewStoryData = await CreateUserViewStoryService.createUserViewStory(userId, storyId);
  }
}
