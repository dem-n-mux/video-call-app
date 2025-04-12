import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_live_host_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/host/Host%20Home%20Screen/Live%20Streaming/streaming_two.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_stream_button.dart';

class StreamingOne extends StatefulWidget {
  const StreamingOne({Key? key}) : super(key: key);

  @override
  State<StreamingOne> createState() => _StreamingOneState();
}

class _StreamingOneState extends State<StreamingOne> {
  FetchLiveHostController fetchLiveHostController = Get.put(FetchLiveHostController());

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          (liveCameraController != null)
              ? SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: CameraPreview(liveCameraController!))
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.pinkColor,
                  ),
                ),
          Container(
            padding:
                const EdgeInsets.only(right: 15, top: 40, bottom: 20),
            height: Get.height,
            width: Get.width,
            color: AppColors.transparentColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15
                              ),
                            ),
                            backgroundColor: AppColors.appBarColor,
                            title: const Text("Are you sure close the Live Streaming?",style: TextStyle(color: Colors.white,),),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      liveCameraController!.pausePreview();
                                      Get.offAll(() => const HostBottomNavigationBarScreen());
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 45,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: AppColors.pinkColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: AppColors.pinkColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 45,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: AppColors.pinkColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )),
                const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                 const SizedBox(
                  height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // CommonStreamButton(
                      //   image: AppIcons.flairIcon,
                      //   onTap: () {},
                      // ),
                      // CommonStreamButton(
                      //   image: AppIcons.flamesIcon,
                      //   onTap: () {},
                      // ),
                      // Container(
                      //   height: 40,
                      //   width: 40,
                      //   decoration: const BoxDecoration(
                      //     gradient: LinearGradient(
                      //         begin: Alignment.topCenter,
                      //         end: Alignment.bottomCenter,
                      //         colors: [
                      //           AppColors.pinkColor,
                      //           AppColors.pinkColor,
                      //           Color(0xff5E6066)
                      //         ]),
                      //     shape: BoxShape.circle,
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(2.5),
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: const Color(0xff5C6064).withOpacity(0.70),
                      //       ),
                      //       child: Image.asset(
                      //         AppIcons.heartWingIcon,
                      //         fit: BoxFit.cover,
                      //         height: 20,
                      //         width: 20,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // CommonStreamButton(
                      //   image: AppIcons.smileyIcon,
                      //   onTap: () {},
                      // ),

                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Fluttertoast.showToast(
                          msg: "Connecting...",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black.withOpacity(0.35),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        await fetchLiveHostController.fetchLiveHost(loginUserId);
                        flairImage.add(AppImages.flairImage);
                        flameImage.add(AppImages.flairImage);
                        heartImage.add(AppImages.flairImage);
                        emojiImage.add(AppImages.flairImage);
                        Get.offAll(
                          () => StreamingTwo(
                            channelName: fetchLiveHostController
                                .liveHostData!.liveHost!.channel
                                .toString(),
                            token: fetchLiveHostController
                                .liveHostData!.liveHost!.token
                                .toString(),
                            liveHostId: fetchLiveHostController
                                .liveHostData!.liveHost!.hostId
                                .toString(),
                            liveRoomId: fetchLiveHostController
                                .liveHostData!.liveHost!.liveStreamingId
                                .toString(),
                          ),
                          arguments: data,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 48,
                        width: Get.width / 1.63,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1, color: Colors.white),
                            color: AppColors.pinkColor,
                            boxShadow: kElevationToShadow[2]),
                        child: Text(
                          "Go Live",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    CommonStreamButton(
                      image: AppIcons.cameraIcon,
                      onTap: () {},
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.pinkColor,
                              AppColors.pinkColor,
                              Color(0xff5E6066)
                            ]),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff5C6064).withOpacity(0.70),
                          ),
                          child: Image.asset(
                            AppIcons.mic,
                            fit: BoxFit.contain,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
