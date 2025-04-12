import 'dart:async';
import 'dart:developer';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/view/Live_Stream/broadcast.dart';
import 'package:hokoo_flutter/view/Host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import '../../../utils/settings/app_variables.dart';

class StreamingTwo extends StatefulWidget {
  final String channelName;
  final String token;
  final String liveHostId;
  final String liveRoomId;

  const StreamingTwo({
    Key? key,
    required this.channelName,
    required this.token,
    required this.liveHostId,
    required this.liveRoomId,
  }) : super(key: key);

  @override
  State<StreamingTwo> createState() => _StreamingTwoState();
}

class _StreamingTwoState extends State<StreamingTwo> {
  var data = Get.arguments;
  static const maxSeconds = 3;
  int second = maxSeconds;
  Timer? timer;

  CameraController? liveCameraController;

  void startCamera(CameraDescription cameraDescription) async {
    cameras = await availableCameras();
    liveCameraController = CameraController(
      cameraDescription,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await liveCameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {});
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (second > 0) {
        setState(() => second--);
      } else {
        stopTimer();
        Get.to(() => Broadcast(
              channelName: widget.channelName,
              token: widget.token,
              liveHostId: widget.liveHostId,
              liveRoomId: widget.liveRoomId,
          clientRole: ClientRole.Broadcaster,
            ));
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  void initState() {
    // connect();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        cameras = await availableCameras();
        startCamera(cameras[1]);
        startTimer();
      } on CameraException catch (e) {
        log('Error in fetching the cameras: $e');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          liveCameraController!.pausePreview();
          Get.off(() => const HostBottomNavigationBarScreen());
          return false;
        },
        child: Stack(
          children: [
            (liveCameraController != null)
                ? SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: CameraPreview(liveCameraController!))
                : const SizedBox(),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 35, bottom: 30),
              height: Get.height,
              width: Get.width,
              color: AppColors.transparentColor,
              child: Text(
                "$second",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 250),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
