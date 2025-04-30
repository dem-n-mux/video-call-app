import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/get_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/host_status_controller.dart';
import 'package:hokoo_flutter/Api_Service/story/controller/create_story_controller.dart';
import 'package:hokoo_flutter/Api_Service/story/controller/host_vise_story_controller.dart';
import 'package:hokoo_flutter/Api_Service/story/controller/story_delete_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'Live Streaming/streaming_one.dart';
import 'Story/host_story_screen.dart';
import 'host_notification_screen.dart';

class HostHomeScreen extends StatefulWidget {
  const HostHomeScreen({Key? key}) : super(key: key);

  @override
  State<HostHomeScreen> createState() => _HostHomeScreenState();
}

class _HostHomeScreenState extends State<HostHomeScreen> {
  FetchHostController fetchHostController = Get.put(FetchHostController());
  CreateStoryController createStoryController = Get.put(CreateStoryController());
  DeleteStoryController deleteStoryController = Get.put(DeleteStoryController());
  HostViceStoryController hostViceStoryController = Get.put(HostViceStoryController());
  GetHostController getHostController = Get.put(GetHostController());

  HostStatusController hostStatusController = Get.put(HostStatusController());

  CarouselSliderController controller = CarouselSliderController();
  int initialIndex = 0;
  bool isVisible = true;
  ImagePicker picker = ImagePicker();

  CroppedFile? croppedFileIs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await hostViceStoryController.fetchHostViceStory(loginUserId);
      if (hostViceStoryController.hostViceStory.isNotEmpty) {
        setState(() {
          isVisible = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
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
              padding: EdgeInsets.only(
                top: height / 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Row(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Obx(
                                      () => Text(
                                        hostCoin.value,
                                        style: const TextStyle(
                                          color: AppColors.pinkColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.to(() => const HostNotificationScreen());
                              //   },
                              //   child: Image.asset(
                              //     AppImages.noNotification,
                              //     width: SizeConfig.blockSizeHorizontal * 10,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.transparentColor,
                                foregroundImage: const AssetImage(
                                  AppIcons.ring,
                                ),
                                radius: height / 15,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.transparentColor,
                                  foregroundImage: NetworkImage(
                                    userImage,
                                  ),
                                  radius: height / 17.5,
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: AppColors.pinkColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Obx(
                                    () {
                                      return FlutterSwitch(
                                        activeColor: const Color(0xff3AB968),
                                        activeText: "",
                                        inactiveText: "",
                                        value: hostStatusController.status.value,
                                        width: 65,
                                        height: 30,
                                        showOnOff: true,
                                        onToggle: (val) {
                                          Get.defaultDialog(
                                              backgroundColor: AppColors.appBarColor,
                                              title: "",
                                              content: Container(
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: AppColors.appBarColor,
                                                ),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        (hostStatusController.status.value == true)
                                                            ? "You want to offline"
                                                            : "You want to online",
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setState(() {
                                                              hostStatusController.status.value = val;
                                                            });
                                                            hostStatusController.checkHostStatus(loginUserId);
                                                            // if (hostStatusController.status.value == true) {
                                                            //   Fluttertoast.showToast(
                                                            //     msg: "You Are Online",
                                                            //     toastLength: Toast.LENGTH_SHORT,
                                                            //     gravity: ToastGravity.BOTTOM,
                                                            //     backgroundColor: Colors.black
                                                            //         .withOpacity(0.35),
                                                            //     textColor: Colors.white,
                                                            //     fontSize: 16.0,
                                                            //   );
                                                            // } else {
                                                            //   Fluttertoast.showToast(
                                                            //     msg: "You Are Offline",
                                                            //     toastLength: Toast.LENGTH_SHORT,
                                                            //     gravity: ToastGravity.BOTTOM,
                                                            //     backgroundColor: Colors.black
                                                            //         .withOpacity(0.35),
                                                            //     textColor: Colors.white,
                                                            //     fontSize: 16.0,
                                                            //   );
                                                            // }
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            height: 45,
                                                            width: 100,
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
                                                        GestureDetector(
                                                          onTap: () async {
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            height: 45,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                              color: AppColors.pinkColor.withOpacity(0.1),
                                                              borderRadius: BorderRadius.circular(15),
                                                            ),
                                                            child: const Text(
                                                              "cancel",
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
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (isVisible) ? const SizedBox(height: 40) : const SizedBox(height: 10),
                        Visibility(
                          visible: isVisible,
                          replacement: Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "My Story",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffABABAB),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    height: 190,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(padding: EdgeInsets.only(top: 15)),
                                        SizedBox(
                                          height: 170,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await _getStoryGallery();
                                                  Fluttertoast.showToast(
                                                    msg: "Please Wait",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black.withOpacity(0.35),
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  );
                                                  if (storyImage != null) {
                                                    await createStoryController.createStory();
                                                    await hostViceStoryController.fetchHostViceStory(loginUserId);
                                                    setState(() {
                                                      isVisible = false;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 150,
                                                  width: 106,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    border: Border.all(
                                                      color: const Color(0xff474747),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 30,
                                                      color: AppColors.pinkColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 150,
                                                    child: ListView.separated(
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: hostViceStoryController.hostViceStory.length,
                                                      separatorBuilder: (context, index) {
                                                        return const SizedBox(
                                                          width: 10,
                                                        );
                                                      },
                                                      itemBuilder: (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            Get.to(() => HostStoryScreen(
                                                                  index: index,
                                                                  hostWiseStory: hostViceStoryController.hostViceStory,
                                                                ));
                                                          },
                                                          child: Container(
                                                            height: 137,
                                                            width: 106,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: const Color(0xff474747),
                                                                width: 2,
                                                              ),
                                                              borderRadius: BorderRadius.circular(15),
                                                              image: DecorationImage(
                                                                  fit: BoxFit.cover,
                                                                  image: NetworkImage(hostViceStoryController
                                                                      .hostViceStory[index].image
                                                                      .toString())),
                                                            ),
                                                            child: GestureDetector(
                                                              onTap: () async {
                                                                Fluttertoast.showToast(
                                                                  msg: "Please Wait",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.CENTER,
                                                                  timeInSecForIosWeb: 1,
                                                                  backgroundColor: Colors.black.withOpacity(0.35),
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0,
                                                                );
                                                                await deleteStoryController.deleteStoryIs(
                                                                    hostViceStoryController.hostViceStory[index].id
                                                                        .toString());
                                                                await hostViceStoryController
                                                                    .fetchHostViceStory(loginUserId);
                                                                setState(() {
                                                                  isVisible = false;
                                                                  if (hostViceStoryController.hostViceStory.isEmpty) {
                                                                    setState(() {
                                                                      isVisible = true;
                                                                    });
                                                                  }
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top: 5, right: 3),
                                                                child: Align(
                                                                  alignment: Alignment.topRight,
                                                                  child: Container(
                                                                    alignment: Alignment.center,
                                                                    height: 30,
                                                                    width: 30,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        color: AppColors.blackColor.withOpacity(0.4)),
                                                                    child: Container(
                                                                      height: 15,
                                                                      width: 15,
                                                                      decoration: const BoxDecoration(
                                                                        image: DecorationImage(
                                                                          image: AssetImage(
                                                                            AppImages.delete,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // child: _uploadCard(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                await _getStoryGallery();
                                Fluttertoast.showToast(
                                  msg: "Please Wait",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black.withOpacity(0.35),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                if (storyImage != null) {
                                  await createStoryController.createStory();
                                  await hostViceStoryController.fetchHostViceStory(loginUserId);
                                  setState(() {
                                    isVisible = false;
                                  });
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: height / 13,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.pinkColor,
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: AppColors.pinkColor,
                                        size: 25,
                                      ),
                                    ),
                                    title: const Text(
                                      "Add Story",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: AppColors.lightPinkColor,
                                      ),
                                    ),
                                  )),
                              // child: Container(
                              //   height: height / 14,
                              //   width: width,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     color: AppColors.pinkColor,
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(left: 15),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         Container(
                              //           height: height / 13,
                              //           width: width / 13,
                              //           decoration: const BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: Colors.white,
                              //           ),
                              //           child: const Icon(
                              //             Icons.add,
                              //             color: AppColors.pinkColor,
                              //             size: 25,
                              //           ),
                              //         ),
                              //         const SizedBox(
                              //           width: 10,
                              //         ),
                              //         const Text(
                              //           "Add Story",
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 20,
                              //             fontWeight: FontWeight.w700,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              if (hostStatusController.status.value == false) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor: AppColors.appBarColor,
                                      title: const Text(
                                        "Are you Offline Please Go to Online",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      actionsAlignment: MainAxisAlignment.center,
                                      actions: [
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
                                    );
                                  },
                                );
                              } else {
                                Get.to(() => const StreamingOne());
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: height / 13,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff343434).withOpacity(0.8),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          AppIcons.streaming,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: const Text(
                                    "Start Streaming",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: AppColors.lightPinkColor,
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff4D4D4D),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                )),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       setState(() {
                        //         hostVideo = true;
                        //       });
                        //       Get.to(() => const HostVideoCallScreen());
                        //     },
                        //     child: Container(
                        //         alignment: Alignment.center,
                        //         height: height / 13,
                        //         width: Get.width,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(10),
                        //           color: const Color(0xff343434),
                        //         ),
                        //         child: ListTile(
                        //           leading: Container(
                        //             width: 30,
                        //             height: 30,
                        //             decoration: const BoxDecoration(
                        //               image: DecorationImage(
                        //                 image: AssetImage(
                        //                   AppIcons.videoCall,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           title: const Text(
                        //             "Video Call",
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.w400,
                        //               fontSize: 18,
                        //               color: Color(0xffFFE2EC),
                        //             ),
                        //           ),
                        //           trailing: Container(
                        //             width: 38,
                        //             height: 38,
                        //             decoration: const BoxDecoration(
                        //               color: Color(0xff4D4D4D),
                        //               shape: BoxShape.circle,
                        //             ),
                        //             child: const Icon(
                        //               Icons.arrow_forward,
                        //               color: Colors.white,
                        //               size: 22,
                        //             ),
                        //           ),
                        //         )),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Note :",
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "it is NOT ALLOWED to upload any pornographic text or image contents. if violations are verified, the corporation will be terminated directly and the earnings will be not settled",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9F9F9F),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Container get carousalSlider {
  //   return Container(
  //     margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
  //     alignment: Alignment.center,
  //     width: Get.width,
  //     child: Stack(
  //       children: [
  //         CarouselSlider.builder(
  //           carouselController: controller,
  //           itemCount: hostCarouselImages.length,
  //           itemBuilder: (BuildContext context, int index, int realIndex) {
  //             return Container(
  //               margin: const EdgeInsets.symmetric(horizontal: 20),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(15),
  //                 image: DecorationImage(
  //                   image: AssetImage(
  //                     hostCarouselImages[index].image,
  //                   ),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             );
  //           },
  //           options: CarouselOptions(
  //               viewportFraction: 1,
  //               onPageChanged: (index, reason) {
  //                 setState(() {
  //                   initialIndex = index;
  //                 });
  //               },
  //               autoPlayCurve: Curves.easeIn,
  //               autoPlayInterval: const Duration(seconds: 5),
  //               height: SizeConfig.blockSizeVertical * 18,
  //               initialPage: 0,
  //               autoPlay: false,
  //               scrollDirection: Axis.horizontal,
  //               scrollPhysics: const PageScrollPhysics()),
  //         ),
  //         Positioned(
  //           left: SizeConfig.blockSizeHorizontal * 40,
  //           top: SizeConfig.blockSizeVertical * 15.5,
  //           child: AnimatedSmoothIndicator(
  //             onDotClicked: animateToSlide,
  //             activeIndex: initialIndex,
  //             count: 5,
  //             axisDirection: Axis.horizontal,
  //             curve: Curves.easeInCubic,
  //             effect: const ScrollingDotsEffect(
  //                 dotHeight: 6.5,
  //                 dotWidth: 6.5,
  //                 activeDotColor: Color(0xffB5B5B5),
  //                 dotColor: Color(0xff393939)),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  void animateToSlide(int index) => controller.animateToPage(index);

  _getStoryGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(
        () {
          storyImage = File(image.path);
          if (storyImage == null) {
          } else {
            setState(() {
              on = true;
            });
          }
          if (kDebugMode) {
            log("Story Image Is  :- $storyImage");
          }
        },
      );
      // _cropImage();
    }
  }

//
// Future<void> _cropImage() async {
//   if (storyImage != null) {
//     final croppedFile = await ImageCropper().cropImage(
//       sourcePath: storyImage!.path,
//       compressFormat: ImageCompressFormat.jpg,
//       compressQuality: 100,
//       uiSettings: [
//         AndroidUiSettings(
//             toolbarTitle: 'Cropper',
//             toolbarColor: Colors.deepOrange,
//             toolbarWidgetColor: Colors.white,
//             initAspectRatio: CropAspectRatioPreset.original,
//             lockAspectRatio: false),
//         IOSUiSettings(
//           title: 'Cropper',
//         ),
//         WebUiSettings(
//           context: context,
//           presentStyle: CropperPresentStyle.dialog,
//           boundary: const CroppieBoundary(
//             width: 520,
//             height: 520,
//           ),
//           viewPort:
//           const CroppieViewPort(width: 480, height: 480, type: 'circle'),
//           enableExif: true,
//           enableZoom: true,
//           showZoomer: true,
//         ),
//       ],
//     );
//     if (croppedFile != null) {
//       setState(() {
//         croppedFileIs = croppedFile;
//       });
//     }
//   }
// }
//
// Widget _uploadCard()
// {
//   return Padding(
//     padding: const EdgeInsets.only(
//       right: 20,
//       left: 20,
//     ),
//     child: GestureDetector(
//       onTap: () async {
//
//         SharedPreferences preferences = await SharedPreferences.getInstance();
//
//         await _getStoryGallery();
//         if (!mounted) return;
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Please Wait...", style: TextStyle(color: Colors.white, fontSize: 15)),
//           backgroundColor: Colors.black,
//         ));
//         selectedImage.add(storyImage!);
//
//         if (storyImage != null) {
//           await createStoryController.createStory();
//           await hostViceStoryController.fetchHostViceStory(loginUserId);
//           preferences.setString("storyId", createStoryController.createStoryData!.story!.sId.toString());
//           storyId = preferences.getString("storyId")!;
//           if (kDebugMode) {
//             log(storyId);
//           }
//           setState(() {
//             isVisible = false;
//           });
//         }
//       },
//       child: Container(
//           alignment: Alignment.center,
//           height: 60,
//           width: Get.width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: AppColors.pinkColor,
//           ),
//           child: ListTile(
//             leading: Container(
//               width: 32,
//               height: 32,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//               ),
//               child: const Icon(
//                 Icons.add,
//                 color: AppColors.pinkColor,
//                 size: 25,
//               ),
//             ),
//             title: const Text(
//               "Add Story",
//               style: TextStyle(
//                 fontWeight: FontWeight.w800,
//                 fontSize: 18,
//                 color: AppColors.lightPinkColor,
//               ),
//             ),
//           ),
//       ),
//       // child: Container(
//       //   height: height / 14,
//       //   width: width,
//       //   decoration: BoxDecoration(
//       //     borderRadius: BorderRadius.circular(10),
//       //     color: AppColors.pinkColor,
//       //   ),
//       //   child: Padding(
//       //     padding: const EdgeInsets.only(left: 15),
//       //     child: Row(
//       //       mainAxisAlignment: MainAxisAlignment.start,
//       //       children: [
//       //         Container(
//       //           height: height / 13,
//       //           width: width / 13,
//       //           decoration: const BoxDecoration(
//       //             shape: BoxShape.circle,
//       //             color: Colors.white,
//       //           ),
//       //           child: const Icon(
//       //             Icons.add,
//       //             color: AppColors.pinkColor,
//       //             size: 25,
//       //           ),
//       //         ),
//       //         const SizedBox(
//       //           width: 10,
//       //         ),
//       //         const Text(
//       //           "Add Story",
//       //           style: TextStyle(
//       //             color: Colors.white,
//       //             fontSize: 20,
//       //             fontWeight: FontWeight.w700,
//       //           ),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     ),
//   );
// }
}
