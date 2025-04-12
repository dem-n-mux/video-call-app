import 'dart:developer';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Home%20Screen/Video%20Call/host_call_preview.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:lottie/lottie.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'Api_Service/video call/controller/make_call_controller.dart';

class DemoCall extends StatefulWidget {
  final String receiverId;
  final String hostName;
  final String hostImage;
  final String callType;
  final String videoCallType;

  const DemoCall({
    Key? key,
    required this.receiverId,
    required this.hostName,
    required this.hostImage,
    required this.callType,
    required this.videoCallType,
  }) : super(key: key);

  @override
  State<DemoCall> createState() => _DemoCallState();
}

class _DemoCallState extends State<DemoCall> {
  MakeCallController makeCallController = Get.put(MakeCallController());
  String text = "Calling...";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await makeCallController.makeCall(
          callerId: loginUserId,
          receiverId: widget.receiverId,
          videoCallType: widget.videoCallType,
          userImage: userImage,
          username: userName,
          matchName: widget.hostName,
          matchImage: widget.hostImage,
          statusType: widget.callType);
      log("on");
      if (makeCallController.makeCallData!.status == false) {
        Fluttertoast.showToast(
          msg: "${makeCallController.makeCallData!.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black.withOpacity(0.35),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Get.back();
      } else {
        videoButtonIs = false;
        socket = IO.io(
          Constant.BASE_URL,
          IO.OptionBuilder().setTransports(['websocket']).setQuery(
              {"callRoom": makeCallController.makeCallData!.data!.callId.toString()}).build(),
        );
        socket.connect();
        socket.onConnect((data) {
          log("Call Room Connected from socket");
          socket.on("callCancel", (data) {
            log("Call Cancel ::  $data");
            Get.back();
          });
          socket.emit("callRequest", makeCallController.makeCallData!.data);
          socket.on("callConfirmed", (data) {
            log("callConfirmed $data");
            if (!mounted) {
              return;
            }
            setState(() {
              text = "Ringing....";
            });
          });
          socket.on("callAnswer", (data) {
            log("Call answer Status (live):: ${data["live"]}");
            log("Call answer Status ::  $data");
            if (data["accept"] == true) {
              Get.off(() => VideoCallScreen(
                    liveStatus: data["live"],
                    callType: (data["live"] == "random") ? "random" : "private",
                    matchName: 'demo',
                    matchImage:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrB8e-SV99ORcO1Mg2NdQrDgtlvAFVpI4ooA&usqp=CAU',
                    clientRole: ClientRole.Broadcaster,
                    channelName: data["channel"],
                    token: data["token"],
                    callId: data["callId"],
                    videoCallType: data["videoCallType"],
                    hostId: widget.receiverId,
                  ));
            } else {
              Get.back();
            }
          });
          socket.on("callCancel", (data) {
            log("Call Cancel :-  $data");
            Get.back();
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        selectedIndex = 0;
        Get.offAll(() => const UserBottomNavigationScreen());
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(
          0xff111217,
        ),
        body: Obx(() {
          if (makeCallController.isLoading.value) {
            return Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.appBackground), fit: BoxFit.cover)),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 35,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          width: 300,
                          height: 300,
                          repeat: true,
                          AppLottie.callAnimation,
                        ),
                      ),
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.pinkColor,
                            width: 2,
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                widget.hostImage,
                              ),
                              fit: BoxFit.cover),
                        ),
                      )
                    ],
                  ),
                  Text(
                    widget.hostName,
                    style: const TextStyle(
                      color: Color(
                        0xffFCFDFE,
                      ),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Color(
                        0xffFCFDFE,
                      ),
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 50,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(
                            0xffE32827,
                          ),
                        ),
                        child: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.appBackground), fit: BoxFit.cover)),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 35,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          width: 300,
                          height: 300,
                          repeat: true,
                          AppLottie.callAnimation,
                        ),
                      ),
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.pinkColor,
                            width: 2,
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                widget.hostImage,
                              ),
                              fit: BoxFit.cover),
                        ),
                      )
                    ],
                  ),
                  Text(
                    widget.hostName,
                    style: const TextStyle(
                      color: Color(
                        0xffFCFDFE,
                      ),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Color(
                        0xffFCFDFE,
                      ),
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 50,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Get.back();
                        socket.emit("callCancel", {
                          "callerId": makeCallController.makeCallData!.data!.callerId,
                          "receiverId": makeCallController.makeCallData!.data!.receiverId,
                          "videoCallType": makeCallController.makeCallData!.data!.videoCallType,
                          "token": makeCallController.makeCallData!.data!.token,
                          "channel": makeCallController.makeCallData!.data!.channel,
                          "callId": makeCallController.makeCallData!.data!.callId,
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(
                            0xffE32827,
                          ),
                        ),
                        child: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
