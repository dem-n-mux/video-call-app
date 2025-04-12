import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/model/chat_thumb_model.dart';
import 'package:hokoo_flutter/Api_Service/chat/service/chat_thumb_service.dart';
import 'create_chat_room_controller.dart';

class ChatThumbController extends GetxController {
  ChatThumbModel? chatThumbData;
  var isLoading = true.obs;
  CreateChatRoomController createChatRoomController =
      Get.put(CreateChatRoomController());

  Future getChatThumb(String id, String type) async {
    try {
      isLoading(true);
      chatThumbData = await ChatThumbService.getChatThumb(id, type);
      log("chat thumb list: ${jsonEncode(chatThumbData)}");
      if (chatThumbData!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
