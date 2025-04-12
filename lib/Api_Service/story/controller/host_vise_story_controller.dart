import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/story/service/host_wice_story_service.dart';
import '../model/host_vise_story_model.dart';

class HostViceStoryController extends GetxController {
  var hostViceStory = <Story>[].obs;
  var isLoading = true.obs;

  Future fetchHostViceStory(String hostId) async {
    try {
      isLoading(true);
      HostViseStoryModel? hostViceStoryData = await HostViceStoryService.hostViceStory(hostId);
      if (hostViceStoryData.story?.isNotEmpty == true) {
        hostViceStory.value = hostViceStoryData.story!;
      }

      log("Host Vice Story List:- ${jsonEncode(hostViceStoryData)}");
    } finally {
      isLoading(false);
    }
  }
}
