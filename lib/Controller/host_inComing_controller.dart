import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:just_audio/just_audio.dart';

class HostInComingController extends GetxController {
  int elapsedSeconds = 0;
  Timer? timer;
  final player = AudioPlayer();
  final String callId;
  final dynamic receiveCallData;
  HostInComingController(this.callId, this.receiveCallData);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log("Host Incoming onInit");
    connect();
    startTimer();
    player.setAsset("assets/audio/call.mp3").then(
      (value) {
        player.play();
      },
    );
    player.setLoopMode(LoopMode.all);
  }

  connect() {
    log("CallId :: $callId");
    socket = IO.io(
      Constant.BASE_URL,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({"callRoom": callId}).build(),
    );
    socket.connect();
    socket.onConnect((data) {
      log("callRoom Connected");
      socket.emit("callConfirmed", receiveCallData);
      socket.on("callConfirmed", (data) {
        log("callConfirmed :-  $data");
      });
      socket.on("callCancel", (data) {
        log("Call Cancel ::  $data");
        timer?.cancel();
        player.stop();
        Get.back();
      });
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (tim) {
      elapsedSeconds++;
      log("Second Is ##### :- $elapsedSeconds");
      if (elapsedSeconds >= 45) {
        Map<String, dynamic> isAccept = {"accept": false};
        Map<String, dynamic> result = {};
        result.addAll(isAccept);
        for (final entry in receiveCallData.entries) {
          result.putIfAbsent(entry.key, () => entry.value);
        }
        socket.emit("callAnswer", result);
        Get.back();
        timer?.cancel();
        player.stop();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
    timer?.cancel();
  }
}
