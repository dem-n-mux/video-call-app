import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/model/create_chat_model.dart';
import 'package:hokoo_flutter/Api_Service/chat/service/create_chat_service.dart';

class CreateChatController extends GetxController {
  CreateChatModel? createChatData;

  Future createChat(String topicId, int messageType, String senderId, int type,
      File sendImage) async {
    createChatData = await CreateChatService.createChat(
        topicId: topicId,
        messageType: messageType,
        senderId: senderId,
        type: type,
        sendFile: sendImage);
    log("Create Chat Data: ${jsonEncode(createChatData)}");
  }
}
