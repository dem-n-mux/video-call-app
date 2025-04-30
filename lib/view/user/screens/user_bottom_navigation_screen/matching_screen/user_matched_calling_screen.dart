import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/get_old_chat_controller.dart';
import 'package:hokoo_flutter/demo_page.dart';
import 'package:hokoo_flutter/view/Chat_Screen/chat_screen.dart';
import 'package:hokoo_flutter/view/Chat_Screen/fake_chat/fake_chat_screen.dart';
import 'package:hokoo_flutter/view/Chat_Screen/fake_chat/fake_demo_call.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/matching_screen/user_searching_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';

class UserMatchedCallingScreen extends StatefulWidget {
  final String matchName;
  final String matchImage;
  final String receiverId;
  final String? genderIs;

  const UserMatchedCallingScreen(
      {Key? key, required this.matchName, required this.matchImage, this.genderIs, required this.receiverId})
      : super(key: key);

  @override
  State<UserMatchedCallingScreen> createState() => _UserMatchedCallingScreenState();
}

class _UserMatchedCallingScreenState extends State<UserMatchedCallingScreen> {
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());
  GetOldChatController getOldChatController = Get.put(GetOldChatController());

  @override
  void initState() {
    createChatRoomController.createChatRoom(loginUserId, widget.receiverId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      log("button is active:- $videoButtonIs");
    }
    return WillPopScope(
      onWillPop: () async {
        selectedIndex = 0;
        Get.offAll(() => const UserBottomNavigationScreen());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              height: 220,
              width: Get.width,
              decoration: const BoxDecoration(),
              child: CachedNetworkImage(
                imageUrl: widget.matchImage,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Center(
                    child: Image.asset(
                      AppIcons.logoPlaceholder,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Center(
                    child: Image.asset(
                      AppIcons.logoPlaceholder,
                    ),
                  );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: Get.width,
                  height: Get.height / 1.3,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            AppImages.appBackground,
                          ))),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "HURRAY!! YOU",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 1),
                      const Text(
                        "FOUND SOMEONE!!",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 27,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        "You both can video chat with each other!",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.pinkColor,
                        ),
                      ),
                      const SizedBox(height: 45),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 80,
                                ),
                                // child: CircleAvatar(
                                //   radius: 45,
                                //   backgroundColor: Colors.white,
                                //   child: CircleAvatar(
                                //     backgroundColor: Colors.transparent,
                                //     backgroundImage: NetworkImage(widget.matchImage),
                                //     radius: 43,
                                //   ),
                                // ),
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  padding: const EdgeInsets.all(1.5),
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.pinkColor),
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.matchImage,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 60,
                                ),
                                // child: CircleAvatar(
                                //   radius: 45,
                                //   backgroundColor: Colors.white,
                                //   child: CircleAvatar(
                                //     backgroundColor: Colors.transparent,
                                //     backgroundImage: NetworkImage(userImage),
                                //     radius: 43,
                                //   ),
                                // ),
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  padding: const EdgeInsets.all(1.5),
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.lightPinkColor),
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
                        ],
                      ),
                      const Spacer(),
                      AbsorbPointer(
                        absorbing: !videoButtonIs,
                        child: GestureDetector(
                          onTap: (int.parse(userCoin.value) >= 20)
                              ? () {
                                  setState(() {
                                    videoButtonIs = false;
                                    if (kDebugMode) {
                                      log("button is not active :- $videoButtonIs");
                                    }
                                    Future.delayed(const Duration(seconds: 5), () {
                                      setState(() {
                                        videoButtonIs = true;
                                        if (kDebugMode) {
                                          log("button is active :- $videoButtonIs");
                                        }
                                      });
                                    });
                                  });

                                  if (createChatRoomController.createChatRoomData?.chatTopic?.hostId?.isFake == true) {
                                    log("fake user");
                                    Get.to(FakeDemoCall(
                                        receiverId: widget.receiverId,
                                        hostName: widget.matchName,
                                        hostImage: widget.matchImage,
                                        callType: 'random',
                                        videoUrl:
                                            createChatRoomController.createChatRoomData!.chatTopic!.hostId!.video.toString()));
                                  } else {
                                    Get.to(() => DemoCall(
                                          receiverId: widget.receiverId,
                                          hostName: widget.matchName,
                                          hostImage: widget.matchImage,
                                          callType: 'random',
                                          videoCallType: 'user',
                                        ));
                                  }
                                }
                              : () {
                                  Fluttertoast.showToast(
                                    msg: "Insufficient Balance",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.SNACKBAR,
                                    backgroundColor: Colors.black.withOpacity(0.35),
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: AppColors.pinkColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.videoCamera),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Call Her",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          log("host is Fake :: ${createChatRoomController.createChatRoomData?.chatTopic?.hostId?.isFake}");
                          setState(() {
                            isMatchCall = false;
                            isVideo = false;
                          });

                          if (createChatRoomController.createChatRoomData?.status == true) {
                            if (createChatRoomController.createChatRoomData?.chatTopic?.hostId?.isFake == true) {
                              Get.to(FakeChatScreen(
                                  hostName: widget.matchName,
                                  chatRoomId: chatRoomId,
                                  senderId: createChatRoomController.createChatRoomData!.chatTopic!.userId.toString(),
                                  hostImage: widget.matchImage,
                                  receiverId: createChatRoomController.createChatRoomData!.chatTopic!.hostId.toString(),
                                  screenType: 'UserScreen',
                                  type: 1,
                                  callType: 'user',
                                  videoUrl: createChatRoomController.createChatRoomData!.chatTopic!.hostId!.video.toString()));
                            } else {
                              Get.to(() => ChatScreen(
                                    hostName: widget.matchName,
                                    chatRoomId: createChatRoomController.createChatRoomData!.chatTopic!.id.toString(),
                                    senderId: createChatRoomController.createChatRoomData!.chatTopic!.userId.toString(),
                                    hostImage: widget.matchImage,
                                    receiverId: createChatRoomController.createChatRoomData!.chatTopic!.hostId.toString(),
                                    screenType: 'UserScreen',
                                    type: 1,
                                    callType: 'user',
                                  ));
                            }
                          } else {
                            Fluttertoast.showToast(msg: createChatRoomController.createChatRoomData?.message.toString() ?? "");
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white54,
                              ),
                              borderRadius: BorderRadius.circular(35),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage(AppIcons.commentIcon)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Say Hi",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMatch = false;
                          });
                          Get.offAll(() => const UserSearchingScreen(
                                selectedValue: 'both',
                              ));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue matching",
                              style: TextStyle(
                                color: Colors.white38,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
