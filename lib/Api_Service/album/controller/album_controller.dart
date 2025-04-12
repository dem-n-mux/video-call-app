import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/album/model/album_model.dart';
import 'package:hokoo_flutter/Api_Service/album/service/album_service.dart';

class AlbumController extends GetxController {
  AlbumModel? albumModel;
  var isLoading = true.obs;

  Future getAlbumData(String hostId) async {
    try {
      isLoading(true);
      albumModel = await AlbumService.addAlbum(hostId);
      log("Album Image Data :- ${jsonEncode(albumModel)}");
    } finally {
      isLoading(false);
    }
  }
}
