import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/random_match/random_match_controller.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/matching_screen/user_matched_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:lottie/lottie.dart';

class UserSearchingScreen extends StatefulWidget {
  final String selectedValue;

  const UserSearchingScreen({super.key, required this.selectedValue});

  @override
  State<UserSearchingScreen> createState() => _UserSearchingScreenState();
}

class _UserSearchingScreenState extends State<UserSearchingScreen> with TickerProviderStateMixin {
  int randomNumber = 0;

  late AnimationController controller;

  late Animation animation;

  RandomMatchController randomMatchController = Get.put(RandomMatchController());

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      debugPrint(widget.selectedValue);
    }

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          randomNumber = Random().nextInt(500);
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await randomMatchController.randomCallData(widget.selectedValue, loginUserId);
      if (randomMatchController.randomCallModel!.message == "No one is online!!") {
        setState(() {
          isNum = true;
        });
        if (!mounted) return;
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: AppColors.appBarColor,
              alignment: Alignment.center,
              title: const Center(
                child: Text(
                  "No One is Online !!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                GestureDetector(
                  onTap: () {
                    selectedIndex = 0;
                    Get.offAll(const UserBottomNavigationScreen());
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
            );
          },
        );
      } else {
        if (randomMatchController.randomCallModel?.status == true) {
          Get.offAll(() => UserMatchedScreen(
                randomMatchImage: randomMatchController.randomCallModel!.data!.image.toString(),
                randomMatchName: randomMatchController.randomCallModel!.data!.name.toString(),
                selectedGenderIs: widget.selectedValue,
                receiverId: randomMatchController.randomCallModel!.data!.id.toString(),
              ));
        } else {
          Fluttertoast.showToast(msg: randomMatchController.randomCallModel?.message.toString() ?? "");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      debugPrint("User Searching Screen Gender :- ${widget.selectedValue}");
    }

    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height / 5),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Lottie.asset(
                      "assets/lottie/matchingLottie.json",
                      repeat: true,
                      reverse: false,
                      width: 300,
                    ),
                    Positioned(
                      top: 90,
                      child: Container(
                        alignment: Alignment.center,
                        height: 105,
                        width: 105,
                        padding: const EdgeInsets.all(0.5),
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.pinkColor),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: CachedNetworkImage(
                            imageUrl: userImage,
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    // Countup(
                    //   begin: 0,
                    //   end: (isNum) ? 0 : randomNumber,
                    //   duration: const Duration(seconds: 3),
                    //   separator: '',
                    //   style: const TextStyle(
                    //     color: AppColors.pinkColor,
                    //     fontSize: 25,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    Text("$randomNumber",
                        style: const TextStyle(
                          color: AppColors.pinkColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Finding people who are video chatting in",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Text(
                          "real-time with you....",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 25),
                    GestureDetector(
                      onTap: () {
                        selectedIndex = 0;
                        (isMatch)
                            ? Get.back()
                            : Get.offAll(
                                () => const UserBottomNavigationScreen(),
                              );
                      },
                      child: Container(
                        height: 45,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.pinkColor,
                        ),
                        child: const Icon(Icons.call_end, color: Colors.white, size: 30),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
