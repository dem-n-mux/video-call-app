import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/chat_thumb_controller.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/Api_Service/search/search_user/controller/search_user_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/message_screen/search_message_list.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'user_message_list_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool search = false;
  bool listVisible = false;

  ChatThumbController chatThumbController = Get.put(ChatThumbController());
  SearchUserController searchUserController = Get.put(SearchUserController());
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());

  TextEditingController searchController = TextEditingController();

  Future<void> _refresh() {
    setState(() {
      chatThumbController.getChatThumb(loginUserId, "user");
    });
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    chatThumbController.getChatThumb(loginUserId, "user");
  }

  void searchUser(String searchValue) {
    if (searchController.text.isNotEmpty) {
      setState(() {
        searchUserController.fetchSearchUser(searchValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          // actions: [
          //   (search)
          //       ? IconButton(
          //           splashColor: Colors.transparent,
          //           highlightColor: Colors.transparent,
          //           onPressed: () {
          //             setState(() {
          //               searchController.clear();
          //               search = false;
          //               listVisible = false;
          //             });
          //           },
          //           icon: const Icon(
          //             Icons.clear,
          //             color: AppColors.pinkColor,
          //             size: 20,
          //           ),
          //         )
          //       : IconButton(
          //           splashColor: Colors.transparent,
          //           highlightColor: Colors.transparent,
          //           onPressed: () {
          //             setState(() {
          //               search = true;
          //               listVisible = true;
          //             });
          //           },
          //           icon: const Icon(
          //             Icons.search,
          //             color: AppColors.pinkColor,
          //             size: 20,
          //           ),
          //         ),
          // ],
          backgroundColor: AppColors.appBarColor,
          title: (search)
              ? TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchUser(value);
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      searchUser(value!);
                      searchController.clear();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Search User...",
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                )
              : const Text("Messages",
                  style: TextStyle(color: AppColors.pinkColor, fontSize: 20, fontWeight: FontWeight.bold)),
          leading: Container(),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AppImages.appBackground),
              ),
            ),
            child: RefreshIndicator(
              onRefresh: _refresh,
              backgroundColor: AppColors.scaffoldColor,
              color: AppColors.pinkColor,
              child: (searchController.text.isEmpty)
                  ? Obx(() {
                      if (chatThumbController.isLoading.value) {
                        return buildShimmer;
                      } else if (chatThumbController.chatThumbData!.chatList!.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: chatThumbController.chatThumbData!.chatList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MessageListScreen(
                              index: index,
                              chatThumb: chatThumbController.chatThumbData!.chatList,
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: Column(
                          children: [
                            SizedBox(height: SizeConfig.blockSizeVertical * 20),
                            Lottie.asset(AppLottie.notificationLottieTwo,
                                repeat: true, reverse: false, width: SizeConfig.blockSizeHorizontal * 45),
                            Text(
                              "No Data Found!!",
                              style: TextStyle(
                                  color: const Color(
                                    0xffDF4D97,
                                  ),
                                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ));
                      }
                    })
                  : Obx(() {
                      if (searchUserController.isLoading.value) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: chatThumbController.chatThumbData!.chatList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MessageListScreen(
                              index: index,
                              chatThumb: chatThumbController.chatThumbData!.chatList!,
                            );
                          },
                        );
                      } else if (searchUserController.userSearchModel!.data!.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: searchUserController.userSearchModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SearchMessageList(
                              index: index,
                              data: searchUserController.userSearchModel!.data!,
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: Column(
                          children: [
                            SizedBox(height: SizeConfig.blockSizeVertical * 20),
                            Lottie.asset(AppLottie.notificationLottieTwo,
                                repeat: true, reverse: false, width: SizeConfig.blockSizeHorizontal * 45),
                            Text(
                              "No Data Found!!",
                              style: TextStyle(
                                  color: const Color(
                                    0xffDF4D97,
                                  ),
                                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ));
                      }
                    }),
            ),
          ),
        ),
      ),
    );
  }

  Shimmer get buildShimmer {
    return Shimmer.fromColors(
        period: const Duration(milliseconds: 1100),
        baseColor: Colors.black38,
        highlightColor: Colors.grey.shade700,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 1,
                    right: SizeConfig.blockSizeHorizontal * 2.5,
                    left: SizeConfig.blockSizeHorizontal * 2.5),
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1.5),
                                shape: BoxShape.circle,
                                color: AppColors.blackColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 17, left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 12,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: AppColors.blackColor, borderRadius: BorderRadius.circular(4)),
                                ).paddingOnly(bottom: 4),
                                Container(
                                  height: 10,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      color: AppColors.blackColor, borderRadius: BorderRadius.circular(4)),
                                ).paddingOnly(bottom: 4),
                                Container(
                                  height: 10,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: AppColors.blackColor, borderRadius: BorderRadius.circular(4)),
                                ).paddingOnly(bottom: 4),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration:
                            BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(14)),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
