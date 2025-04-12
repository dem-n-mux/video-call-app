import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Controller/host_inComing_controller.dart';
import 'package:hokoo_flutter/view/Host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:lottie/lottie.dart';
import 'host_call_preview.dart';

class HostInComingCallScreen extends StatefulWidget {
  final dynamic receiveCallData;
  final String name;
  final String image;
  final String callId;

  const HostInComingCallScreen({
    super.key,
    required this.name,
    required this.image,
    required this.callId,
    required this.receiveCallData,
  });

  @override
  State<HostInComingCallScreen> createState() => _HostInComingCallScreenState();
}

class _HostInComingCallScreenState extends State<HostInComingCallScreen> {
  // @override
  // void initState() {
  //
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   player.dispose();
  //   timer?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    HostInComingController controller = Get.put(HostInComingController(widget.callId, widget.receiveCallData));
    log("ReceiveCallData:+++++++++++++++++++++++++++++++++${widget.receiveCallData}");
    return WillPopScope(
      onWillPop: () async {
        hostSelectedIndex = 0;
        Get.offAll(() => const HostBottomNavigationBarScreen());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: Get.height,
          width: Get.width,
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.1,
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.appBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.pinkColor, width: 2),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.image,
                          ),
                        )),
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Incoming",
                    style: TextStyle(
                      color: Color(0xff9F9F9F),
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Map<String, dynamic> isAccept = {"accept": false};
                          Map<String, dynamic> result = {};
                          result.addAll(isAccept);
                          for (final entry in widget.receiveCallData.entries) {
                            result.putIfAbsent(entry.key, () => entry.value);
                          }
                          socket.emit("callAnswer", result);
                          controller.player.dispose();
                          Get.back();
                        },
                        child: Lottie.asset(
                          AppLottie.endCall,
                          width: 130,
                          height: 130,
                          repeat: true,
                          fit: BoxFit.contain,
                        )),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Map<String, dynamic> isAccept = {"accept": true};
                        Map<String, dynamic> result = {};
                        result.addAll(isAccept);
                        for (final entry in widget.receiveCallData.entries) {
                          result.putIfAbsent(entry.key, () => entry.value);
                        }
                        socket.emit("callAnswer", result);
                        log("timerCancelled");
                        controller.timer?.cancel();
                        socket.disconnected;
                        log("timerCancelled222");

                        controller.player.dispose();
                        await Get.off(() => VideoCallScreen(
                              callType: (widget.receiveCallData["live"] == "random") ? "random" : "private",
                              liveStatus: widget.receiveCallData["live"],
                              matchName: 'demo',
                              matchImage:
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrB8e-SV99ORcO1Mg2NdQrDgtlvAFVpI4ooA&usqp=CAU',
                              clientRole: ClientRole.Broadcaster,
                              channelName: widget.receiveCallData["channel"],
                              token: widget.receiveCallData["token"],
                              callId: widget.receiveCallData["callId"],
                              videoCallType: widget.receiveCallData["videoCallType"],
                              hostId: hostId,
                            ));
                      },
                      child: Lottie.asset(
                        AppLottie.receiveCall,
                        width: 130,
                        height: 130,
                        repeat: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
