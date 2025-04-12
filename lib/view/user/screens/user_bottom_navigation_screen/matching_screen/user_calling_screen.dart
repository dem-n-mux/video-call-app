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

// ignore:library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../../Api_Service/video call/model/make_call_model.dart';

class UserCallingScreen extends StatefulWidget {
  final String matchImage;
  final String matchName;
  final String channel;
  final String token;
  final String receiverId;
  final String callId;
  final Data callData;

  const UserCallingScreen({
    Key? key,
    required this.matchImage,
    required this.matchName,
    required this.channel,
    required this.token,
    required this.receiverId,
    required this.callId,
    required this.callData,
  }) : super(key: key);

  @override
  State<UserCallingScreen> createState() => _UserCallingScreenState();
}

class _UserCallingScreenState extends State<UserCallingScreen> {
  String text = "Calling...";

  void connect() {
    log("on");
    socket = IO.io(
      Constant.BASE_URL,
      IO.OptionBuilder().setTransports(['webcallSocket']).setQuery({"callRoom": widget.callId}).build(),
    );
    socket.connect();
    socket.onConnect((data) {
      log("Connected");
    });
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
      log("CallAnswer Data :- $data");
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
              hostId: hostId,
            ));
      } else {
        Get.back();
      }
    });
    socket.on("callCancel", (data) {
      log("Call Cancel :-  $data");
      Get.back();
    });
  }

  @override
  void dispose() {
    super.dispose();
    log("success");
  }

  @override
  void initState() {
    Fluttertoast.showToast(
      msg: "Connecting...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black.withOpacity(0.35),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    connect();
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
        body: Container(
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
                            widget.matchImage,
                          ),
                          fit: BoxFit.cover),
                    ),
                  )
                ],
              ),
              Text(
                widget.matchName,
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
                    socket.emit("callCancel", {
                      "callerId": widget.callData.callerId,
                      "receiverId": widget.callData.receiverId,
                      "videoCallType": widget.callData.videoCallType,
                      "token": widget.callData.token,
                      "channel": widget.callData.channel,
                      "callId": widget.callData.callId,
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
        ),
      ),
    );
  }
}
