import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/Chat_Screen/fake_chat/fake_video_call.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:lottie/lottie.dart';

class FakeDemoCall extends StatefulWidget {
  final String receiverId;
  final String hostName;
  final String hostImage;
  final String callType;
  final String videoUrl;
  const FakeDemoCall({
    super.key,
    required this.receiverId,
    required this.hostName,
    required this.hostImage,
    required this.callType,
    required this.videoUrl,
  });

  @override
  State<FakeDemoCall> createState() => _FakeDemoCallState();
}

class _FakeDemoCallState extends State<FakeDemoCall> {
  String text = "Calling...";
  @override
  void initState() {
    calling();
    super.initState();
  }

  void calling() async {
    log("helloo ringing");
    await Future.delayed(const Duration(seconds: 2), () {}).then((value) {
      setState(() {
        text = "Ringing....";
        next(videoUrl: widget.videoUrl);
      });
    });
  }

  void next({required String videoUrl}) {
    Future.delayed(const Duration(milliseconds: 4000), () {
      Get.off(FakeVideoCall(
        videoUrl: videoUrl,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.pinkColor),
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: CachedNetworkImage(
                          imageUrl: widget.hostImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Center(
                              child: Image.asset(
                                AppIcons.userPlaceholder,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Center(
                              child: Image.asset(
                                AppIcons.userPlaceholder,
                              ),
                            );
                          },
                        )),
                  ),
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
        ));
  }
}
