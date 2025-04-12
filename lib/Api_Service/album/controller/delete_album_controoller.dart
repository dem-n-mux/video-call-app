import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/album/model/delete_album_model.dart';
import 'package:hokoo_flutter/Api_Service/album/service/delete_album_service.dart';

class DeleteAlbumController extends GetxController {
  DeleteAlbumModel? deleteAlbumModel;
  var isLoading = true.obs;

  Future getDeleteAlbumData(String hostId, String position) async {
    try {
      isLoading(true);
      deleteAlbumModel = await DeleteAlbumService.deleteAlbum(hostId, position);
      log("delete Album data :- ${jsonEncode(deleteAlbumModel)}");
    } finally {
      isLoading(false);
    }
  }
}
