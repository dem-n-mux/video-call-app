import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/matching_screen/user_searching_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/profile_screen/Recharge/recharge_coin_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';

class UserMatchingScreen extends StatefulWidget {
  const UserMatchingScreen({Key? key}) : super(key: key);

  @override
  State<UserMatchingScreen> createState() => _UserMatchingScreenState();
}

class _UserMatchingScreenState extends State<UserMatchingScreen> {
  String selectedGender = "both";
  String selectedValue = "both";

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
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        selectedIndex = 0;
        Get.offAll(() => const UserBottomNavigationScreen());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: InkWell(
          onTap: () {
            setState(
              () {
                navMatch = true;
              },
            );

            if (selectedValue == "male" && userCoin.value == "0") {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: AppColors.appBarColor,
                    title: const Center(
                      child: Text(
                        "No Coin Available?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Get.back();
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
                                "Ok",
                                style: TextStyle(
                                  color: AppColors.pinkColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            } else if (selectedValue == "female" && userCoin.value == "0") {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: AppColors.appBarColor,
                    title: const Center(
                      child: Text(
                        "No Coin Available?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Get.back();
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
                                "Ok",
                                style: TextStyle(
                                  color: AppColors.pinkColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            } else {
              Get.to(
                () => UserSearchingScreen(
                  selectedValue: selectedValue,
                ),
              );
            }
          },
          child: Container(
            color: const Color(0xff180020),
            child: Stack(
              children: [
                (liveCameraController != null)
                    ? SizedBox(height: Get.height, width: Get.width, child: CameraPreview(liveCameraController!))
                    : const Center(
                        child: SizedBox(),
                      ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: StatefulBuilder(
                                builder: (context, setState1) => Container(
                                  height: 361,
                                  decoration: BoxDecoration(
                                      color: AppColors.appBarColor, borderRadius: BorderRadius.circular(18)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                        alignment: Alignment.center,
                                        width: Get.width,
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(18), topLeft: Radius.circular(18))),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          const Spacer(),
                                          const Text(
                                            "Select Match Gender",
                                            style: TextStyle(
                                                color: AppColors.pinkColor, fontWeight: FontWeight.bold, fontSize: 17),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 3),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                                        height: 304,
                                        width: Get.width,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(18), bottomLeft: Radius.circular(18))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(AppIcons.bothGender, fit: BoxFit.contain),
                                                    ),
                                                    const SizedBox(width: 20),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text("Both",
                                                            style: TextStyle(
                                                                color: AppColors.pinkColor,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16)),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 12,
                                                              width: 12,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                        AppImages.singleCoin,
                                                                      ),
                                                                      fit: BoxFit.cover)),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(chargeForRandomCall.toString(),
                                                                style: const TextStyle(
                                                                    color: Color(0xff686868),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14)),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Transform.scale(
                                                  scale: 1.2,
                                                  child: Radio(
                                                      activeColor: AppColors.pinkColor,
                                                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                                                      value: "both",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          setState1(() {
                                                            selectedValue = value!;
                                                            selectedGender = selectedValue;
                                                          });
                                                        });
                                                      }),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(AppIcons.femaleGender, fit: BoxFit.contain),
                                                    ),
                                                    const SizedBox(width: 20),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text("Female",
                                                            style: TextStyle(
                                                                color: AppColors.pinkColor,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16)),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 12,
                                                              width: 12,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                        AppImages.singleCoin,
                                                                      ),
                                                                      fit: BoxFit.cover)),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(chargeForRandomCall.toString(),
                                                                style: const TextStyle(
                                                                    color: Color(0xff686868),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14)),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Transform.scale(
                                                  scale: 1.2,
                                                  child: Radio(
                                                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                                                      activeColor: AppColors.pinkColor,
                                                      value: "female",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          setState1(() {
                                                            selectedValue = value!;
                                                            selectedGender = selectedValue;
                                                          });
                                                        });
                                                      }),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Image.asset(AppIcons.maleGender, fit: BoxFit.contain),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text("Male",
                                                              style: TextStyle(
                                                                  color: AppColors.pinkColor,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 16)),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                height: 12,
                                                                width: 12,
                                                                decoration: const BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                          AppImages.singleCoin,
                                                                        ),
                                                                        fit: BoxFit.cover)),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(chargeForRandomCall.toString(),
                                                                  style: const TextStyle(
                                                                      color: Color(0xff686868),
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 14)),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Transform.scale(
                                                  scale: 1.2,
                                                  child: Radio(
                                                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                                                      activeColor: AppColors.pinkColor,
                                                      value: "male",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          setState1(() {
                                                            selectedValue = value!;
                                                            selectedGender = selectedValue;
                                                          });
                                                        });
                                                      }),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 30),
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Balance",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.lightPinkColor,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                AppImages.multiCoin,
                                                              ),
                                                              fit: BoxFit.cover)),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Obx(
                                                      () => Text(userCoin.value,
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 17)),
                                                    )
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(() => const RechargeCoinScreen());
                                                    // setState(() {
                                                    //   selectedGender =
                                                    //       selectedValue;
                                                    //   Get.back();
                                                    // });
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                    height: 36,
                                                    width: 97,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: AppColors.pinkColor),
                                                    child: const Text(
                                                      "Buy Now",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        height: 42,
                        width: (selectedGender == "Female") ? 135 : 125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(colors: [
                            const Color(0xff573777).withOpacity(0.8),
                            AppColors.pinkColor.withOpacity(0.80),
                          ]),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 22,
                              width: 22,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                  (selectedGender == "both")
                                      ? AppIcons.bothGender
                                      : (selectedGender == "male")
                                          ? AppIcons.maleGender
                                          : AppIcons.femaleGender,
                                  fit: BoxFit.contain),
                            ),
                            Row(
                              children: [
                                Text(
                                  selectedGender,
                                  style:
                                      const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 3),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 330,
                        width: 400,
                        child: Lottie.asset(AppLottie.tapLottie,
                            repeat: true, reverse: false, fit: BoxFit.cover, alignment: Alignment.bottomCenter),
                      ),
                      const Text(
                        "Click to match",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
