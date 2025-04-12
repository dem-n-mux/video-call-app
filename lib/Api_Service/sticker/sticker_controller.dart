import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/sticker/sticker_model.dart';
import 'package:hokoo_flutter/Api_Service/sticker/sticker_service.dart';

class StickerController extends GetxController {
  StickerModel? stickerModel;

  List<Sticker> love = [];
  List<Sticker> emoji = [];

  Future createSticker() async {
    stickerModel = await StickerService.sticker();
    log("hello");

    for (int i = 0; i < stickerModel!.sticker!.length; i++) {
      if (stickerModel!.sticker![i].type == "love") {
        love.add(stickerModel!.sticker![i]);
      }
    }

    for (int i = 0; i < stickerModel!.sticker!.length; i++) {
      if (stickerModel!.sticker![i].type == "emoji") {
        emoji.add(stickerModel!.sticker![i]);
      }
    }

    log("Sticker Data:- ${jsonEncode(stickerModel)}");
    log("Love Stiker Is :- $love");
    log("Emoji Stiker Is :- $emoji");
  }
}
