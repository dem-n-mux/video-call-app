// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Controller/video_timer_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:video_player/video_player.dart';

class FakeVideoCall extends StatefulWidget {
  String videoUrl;
  FakeVideoCall({super.key, required this.videoUrl});

  @override
  State<FakeVideoCall> createState() => _FakeVideoCallState();
}

class _FakeVideoCallState extends State<FakeVideoCall> {
  TimerDataController timerDataController = Get.put(TimerDataController());

  bool muted = false;
  late VideoPlayerController _controller;
  CameraController? cameraController;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;
  void startCamera(CameraDescription cameraDescription) async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await cameraController?.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        cameras = await availableCameras();
        startCamera(cameras[1]);
      } on CameraException catch (e) {
        log('Error in fetching the cameras: $e');
      }
    });

    log('widget.videoUrl:::::${widget.videoUrl}');
    // TODO: implement initState
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

    _controller.addListener(() {
      if (_controller.value.isInitialized && _controller.value.position == _controller.value.duration) {
        // Video has ended, seek back to the beginning for replay
        _controller.seekTo(Duration.zero);
        _controller.play(); // Start playing again
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    timerDataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: SizedBox(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: Stack(
                children: [
                  viewRows(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, top: 20),
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.transparentColor,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time_filled,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Obx(
                              () => Text(
                                '${timerDataController.hours.toString().padLeft(2, '0')}:${timerDataController.minutes.toString().padLeft(2, '0')}:${timerDataController.seconds.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Container(
                          height: 75,
                          width: Get.width / 1.2,
                          decoration: BoxDecoration(
                            color: AppColors.appBarColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Get.back();
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.redColor,
                                  ),
                                  child: const Icon(Icons.call_end_outlined, color: Colors.white, size: 25),
                                ),
                              ),
                              GestureDetector(
                                  onTap: onSwitchCamera,
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.flipCameraColor,
                                      ),
                                      child: const ImageIcon(
                                        AssetImage(AppImages.flipCamera),
                                        color: Colors.white,
                                        size: 30,
                                      ))),
                              GestureDetector(
                                onTap: soundToggle,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.flipCameraColor,
                                  ),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: (muted)
                                              ? const AssetImage(
                                                  AppIcons.micOff,
                                                )
                                              : const AssetImage(
                                                  AppIcons.micOn,
                                                )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).paddingOnly(bottom: 50),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void onSwitchCamera() async {
    cameraLensDirection = cameraLensDirection == CameraLensDirection.back ? CameraLensDirection.front : CameraLensDirection.back;
    final cameras = await availableCameras();
    final camera = cameras.firstWhere((camera) => camera.lensDirection == cameraLensDirection);
    cameraController = CameraController(camera, ResolutionPreset.high);
    await cameraController?.initialize();
    setState(() {});
  }

  soundToggle() {
    setState(() {
      muted == false ? _controller.setVolume(0.0) : _controller.setVolume(1.0);
      muted = !muted;
    });
  }

  Widget viewRows() {
    return Stack(
      children: [
        SizedBox(
          height: Get.height,
          width: Get.width,
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: Get.width / Get.height,
                  child: VideoPlayer(_controller),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 140,
                  height: 170,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: cameraController != null
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: cameraController!.value.previewSize!.width / 3,
                            height: cameraController!.value.previewSize!.height,
                            child: CameraPreview(cameraController!),
                          ),
                        )
                      // AspectRatio(aspectRatio: cameraController!.value.aspectRatio, child: CameraPreview(cameraController!))
                      : const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
