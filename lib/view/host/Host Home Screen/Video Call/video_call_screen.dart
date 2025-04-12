import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/host_status_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostVideoCallScreen extends StatefulWidget {
  const HostVideoCallScreen({Key? key}) : super(key: key);

  @override
  State<HostVideoCallScreen> createState() => _HostVideoCallScreenState();
}

class _HostVideoCallScreenState extends State<HostVideoCallScreen> {
  bool isClick = false;

  HostStatusController hostStatusController = Get.put(HostStatusController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.appBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: height / 20,
                    width: width / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: AppColors.pinkColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 22,
                          width: 22,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AppImages.multiCoin,
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "1753",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Angel Priya",
                        style: TextStyle(
                          color: AppColors.lightPinkColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "@4fg5df",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff656565),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.pinkColor, width: 1.5),
                        image: const DecorationImage(
                          image: NetworkImage(
                            AppImages.userProfile,
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
              GestureDetector(
                  onTap: () async {
                    await hostStatusController.checkHostStatus(loginUserId);
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.setBool("isOnline", hostStatusController.hostStatusData!.host!.isOnline!);
                    setState(() {
                      isOnline = pref.getBool("isOnline")!;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Lottie.asset(
                        (isOnline) ? AppLottie.videoOnline : AppLottie.videoCall,
                        width: 320,
                        height: 320,
                        repeat: true,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, right: 10),
                        child: Text(
                          (isOnline) ? "Online" : "Offline",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  )),
              GestureDetector(
                onTap: () async {
                  await hostStatusController.checkHostStatus(loginUserId);
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setBool("isOnline", hostStatusController.hostStatusData!.host!.isOnline!);
                  setState(() {
                    isOnline = pref.getBool("isOnline")!;
                  });
                },
                child: Text(
                  (isOnline) ? "Tap to Offline" : "Tap to Online ",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        (isOnline == false)
                            ? const Column(
                                children: [
                                  Text(
                                    "You are not available for",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9F9F9F),
                                    ),
                                  ),
                                  Text(
                                    "video call now",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9F9F9F),
                                    ),
                                  ),
                                ],
                              )
                            : const Text(
                                "Now you are available for Video Call",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Column(
                      children: [
                        Text(
                          "Note :",
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "it is NOT ALLOWED to upload any pornographic text or",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9F9F9F),
                          ),
                        ),
                        Text(
                          "image contents. if violations are verified, the",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9F9F9F),
                          ),
                        ),
                        Text(
                          "corporation will be terminated directly and the",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9F9F9F),
                          ),
                        ),
                        Text(
                          "earnings will be not settled",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9F9F9F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
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
