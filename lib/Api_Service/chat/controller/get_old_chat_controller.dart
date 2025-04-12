import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/model/get_old_chat_model.dart';
import 'package:hokoo_flutter/Api_Service/chat/service/get_old_chat_service.dart';
import 'package:hokoo_flutter/view/utils/settings/models/chat_model.dart';
import 'package:intl/intl.dart';

class GetOldChatController extends GetxController {
  GetOldChatModel? oldChatData;
  var chatList = <ChatModel>[].obs;
  var isLoading = true.obs;
  String messagestaus = "";
  String messageShowstaus = "ABC";
  List<String> dateYt = [];
  List<int> position = [];
  List<int> reversedPosition = [];
  int tooo = 0;
  Future oldChat(String topicId) async {
    try {
      isLoading(true);
      var data = await GetOldChatService.getOldChat(topicId);
      oldChatData = data;
      log("Old Chat Data: ${jsonEncode(oldChatData!.chat)}");
      if (data.status == true) {
        oldChatData!.chat!.forEach((element) {
          if (element.messageType == 3) {
            ///// ====== MESSAGE TIME ======= \\\\\

            String date = element.date!;
            List<String> dateParts = date.split(", ");
            List<String> time = dateParts[1].toString().split(":");
            List<String> pmdate = time[2].toString().split(" ");
            String finalTime = "${time[0]}:${time[1]} ${pmdate[1]}";

            //// ==== TODAY YESTERDAY ==== \\\\
            var now = DateTime.now();
            final yesterDay = DateTime.now().subtract(const Duration(days: 1));
            String nowDate = DateFormat.yMd().format(now);
            String yesterDate = DateFormat.yMd().format(yesterDay);
            log("=========$yesterDate==========");
            if (nowDate == dateParts[0]) {
              log("+++++++++++++++++++TODAY++++++++++++");
              dateYt.add("Today");
            } else if (yesterDate == dateParts[0]) {
              dateYt.add("Yesterday");
              log("+++++++++++++++++++YesterDay++++++++++++");
            } else {
              List datePartslist = dateParts[0].split("/");
              dateYt.add("${datePartslist[1]}/${datePartslist[0]}/${datePartslist[2]}");
            }
            log("================+++++++++=====$tooo");
            tooo++;
            chatList.add(ChatModel(
                message: element.message!,
                type: element.type!.toInt(),
                time: finalTime,
                isRead: element.isRead!,
                messageType: element.messageType!.toInt(),
                senderId: element.senderId!));
          } else if (element.messageType == 0) {
            String date = element.date!;
            List<String> dateParts = date.split(", ");
            List<String> time = dateParts[1].toString().split(":");
            List<String> pmdate = time[2].toString().split(" ");
            String finalDate = "${time[0]}:${time[1]} ${pmdate[1]}";

            //// ==== TODAY YESTERDAY ==== \\\\
            var now = DateTime.now();
            final yesterDay = DateTime.now().subtract(const Duration(days: 1));
            String nowDate = DateFormat.yMd().format(now);
            String yesterDate = DateFormat.yMd().format(yesterDay);
            log("=========$yesterDate==========");
            log("+++++++++++++++$nowDate++++++++++++${dateParts[0]}");
            if (nowDate == dateParts[0]) {
              log("+++++++++++++++++++TODAY++++++++++++");
              dateYt.add("Today");
            } else if (yesterDate == dateParts[0]) {
              dateYt.add("Yesterday");
              log("+++++++++++++++++++YesterDay++++++++++++");
            } else {
              List datePartslist = dateParts[0].split("/");
              dateYt.add("${datePartslist[1]}/${datePartslist[0]}/${datePartslist[2]}");
            }

            chatList.add(ChatModel(
                message: element.image.toString(),
                type: element.type!.toInt(),
                time: finalDate,
                isRead: element.isRead!,
                messageType: element.messageType!.toInt(),
                senderId: element.senderId!));
          } else if (element.messageType == 2) {
            String date = element.date!;
            List<String> dateParts = date.split(", ");
            List<String> time = dateParts[1].toString().split(":");
            List<String> pmdate = time[2].toString().split(" ");
            String finalDate = "${time[0]}:${time[1]} ${pmdate[1]}";

            //// ==== TODAY YESTERDAY ==== \\\\
            var now = DateTime.now();
            final yesterDay = DateTime.now().subtract(const Duration(days: 1));
            log("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            String nowDate = DateFormat.yMd().format(now);
            String yesterDate = DateFormat.yMd().format(yesterDay);

            log("=========$yesterDate==========");
            log("+++++++++++++++$nowDate++++++++++++$finalDate");
            if (nowDate == dateParts[0]) {
              log("+++++++++++++++++++TODAY++++++++++++");
              dateYt.add("Today");
            } else if (yesterDate == dateParts[0]) {
              dateYt.add("Yesterday");
              log("+++++++++++++++++++YesterDay++++++++++++");
            } else {
              List datePartslist = dateParts[0].split("/");
              dateYt.add("${datePartslist[1]}/${datePartslist[0]}/${datePartslist[2]}");
            }

            chatList.add(ChatModel(
                message: element.audio.toString(),
                type: element.type!.toInt(),
                time: finalDate,
                isRead: element.isRead!,
                messageType: element.messageType!.toInt(),
                senderId: element.senderId!));
          }
        });

        log("++++$chatList");
        log("^^^^^^^^$dateYt");

        for (int i = 0; i < dateYt.length; i++) {
          log("********$messageShowstaus********$messagestaus");
          if (i > 0) {
            messageShowstaus = dateYt[i];
          }
          if (messagestaus != messageShowstaus) {
            messagestaus = dateYt[i];
            log("====== $messagestaus ======");
            reversedPosition.add(1);
          } else {
            reversedPosition.add(0);
          }
          if (i == 0) {
            messageShowstaus = dateYt[i];
          }
        }
        position = reversedPosition.reversed.toList();
        log("@@@@@@@@@@@@@@@@@@$position");
        log("@@@@@@@@@@@@@@@@@@$reversedPosition");

        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      log(e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    log("+++++++++++++++++++++++++++");
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    log("++++++++++++++++++++++++++");
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    log("++++++++++++++++++++++++++++++++++");
    messageShowstaus = "ABC";
    super.onClose();
  }
}
