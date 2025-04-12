import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/video%20call/model/make_call_model.dart';
import 'package:hokoo_flutter/Api_Service/video%20call/service/make_call_service.dart';

class MakeCallController extends GetxController {
  MakeCallModel? makeCallData;
  var isLoading = true.obs;

  Future makeCall({
    required String callerId,
    required String receiverId,
    required String videoCallType,
    required String userImage,
    required String username,
    required String matchName,
    required String matchImage,
    required String statusType,
  }) async {
    try {
      isLoading(true);
      makeCallData = await MakeCallService.makeCall(
          callerId: callerId,
          receiverId: receiverId,
          videoCallType: videoCallType,
          userImage: userImage,
          username: username,
          matchName: matchName,
          matchImage: matchImage,
          statusType: statusType);
      if (makeCallData!.status == true) {
        log("Make Call Message: ${jsonEncode(makeCallData!.message)}");
        log("Make Call Data: ${jsonEncode(makeCallData)}");
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
