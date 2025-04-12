import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/get_old_chat_controller.dart';
import 'package:hokoo_flutter/Api_Service/story/controller/story_view_controller.dart';
import 'package:hokoo_flutter/view/Chat_Screen/chat_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/custom_report.dart';
import 'package:story/story_page_view/story_page_view.dart';
import 'package:swipe/swipe.dart';

import '../../../Api_Service/story/model/get_host_story_model.dart';
import '../screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';

class StoryViewPage extends StatefulWidget {
  final List<Story> storyList;
  final int index;

  const StoryViewPage({super.key, required this.storyList, required this.index});

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  StoryViewController storyViewController = Get.put(StoryViewController());
  GetOldChatController getOldChatController = Get.put(GetOldChatController());
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    createChatRoomController.createChatRoom(loginUserId, widget.storyList[widget.index].id.toString());
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(IndicatorAnimationCommand.resume);
    super.initState();
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
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
        body: Swipe(
          onSwipeDown: () {
            selectedIndex = 0;
            Get.offAll(() => const UserBottomNavigationScreen());
          },
          child: StoryPageView(
            onPageChanged: (value) async {
              if (value == 0) {
                log("on Page Changed Value :- $value");
              } else {
                log("on Page Changed Value :- $value");

                storyViewController.storyView(widget.storyList[widget.index].hostStory![value].id.toString(), loginUserId);

                widget.storyList[widget.index].hostStory![value - 1].isView != true;
                // storyList[value - 1].isActive = true;
              }
            },
            itemBuilder: (context, pageIndex, storyIndex) {
              final story = widget.storyList[pageIndex].hostStory![storyIndex];
              return Stack(
                children: [
                  Positioned.fill(
                    child: Container(color: Colors.black),
                  ),
                  Positioned.fill(
                    // child: Image.network(
                    //   story.image,
                    //   fit: BoxFit.cover,
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return Container(
                    //       color: Colors.grey.withOpacity(0.3),
                    //       child: Center(child: Icon(Icons.error)),
                    //     );
                    //   },
                    // ),
                    child: CachedNetworkImage(
                      imageUrl: story.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Padding(
                          padding: const EdgeInsets.all(100.0),
                          child: Image.asset(
                            AppIcons.logoShimmer,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Image.asset(
                            AppIcons.logoShimmer,
                            color: Colors.black12,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            gestureItemBuilder: (context, pageIndex, storyIndex) {
              final user = widget.storyList[pageIndex];

              storyViewController.storyView(widget.storyList[pageIndex].hostStory![storyIndex].id.toString(), loginUserId);

              return Stack(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.to(() => StoryDummyProfile(
                          //       storyModel: user,
                          //     ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50, left: 8),
                          child: Row(
                            children: [
                              Container(
                                height: 43,
                                width: 43,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(user.hostImage!),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                user.hostName!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            selectedIndex = 0;
                            Get.offAll(() => const UserBottomNavigationScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (createChatRoomController.createChatRoomData?.status == true) {
                              Get.to(() => ChatScreen(
                                    hostName: widget.storyList[widget.index].hostName.toString(),
                                    chatRoomId: createChatRoomController.createChatRoomData!.chatTopic!.id.toString(),
                                    senderId: createChatRoomController.createChatRoomData!.chatTopic!.userId.toString(),
                                    hostImage: widget.storyList[widget.index].hostImage.toString(),
                                    receiverId: createChatRoomController.createChatRoomData!.chatTopic!.hostId.toString(),
                                    screenType: 'StoryUserScreen',
                                    type: 1,
                                    callType: 'user',
                                  ));
                            } else {
                              Fluttertoast.showToast(msg: createChatRoomController.createChatRoomData?.message ?? "");
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white38,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  color: Colors.white,
                                  AssetImage(
                                    AppIcons.commentIcon,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Say Hi",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ],
                            ),
                          )).paddingOnly(right: 10),
                      GestureDetector(
                        onTap: () {
                          CustomReportView.show();
                        },
                        child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor.withOpacity(0.30),
                            ),
                            child: const Icon(
                              Icons.report_gmailerrorred,
                            )),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 10, horizontal: 10),
                ),
              ]);
            },
            initialPage: widget.index,
            indicatorAnimationController: indicatorAnimationController,
            initialStoryIndex: (pageIndex) {
              if (pageIndex == 0) {
                log("pageIndex :- $pageIndex");

                return 0;
              }
              return 0;
            },
            pageLength: widget.storyList.length,
            storyLength: (int pageIndex) {
              log("Story length :- $pageIndex");

              return widget.storyList[pageIndex].hostStory!.length;
            },
            indicatorDuration: const Duration(seconds: 10),
            onPageLimitReached: () {
              Get.offAll(() => const UserBottomNavigationScreen());
              // widget.storyList[widget.index].hostStory![1].isView = true;
            },
          ),
        ),
      ),
    );
  }
}
