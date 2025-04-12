import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/get_old_chat_controller.dart';
import 'package:hokoo_flutter/Api_Service/chat/model/get_old_chat_model.dart';
import 'package:hokoo_flutter/view/Chat_Screen/fake_chat/dummy_chat_conversation.dart';
import 'package:hokoo_flutter/view/Chat_Screen/fake_chat/fake_demo_call.dart';
import 'package:hokoo_flutter/view/Chat_Screen/fake_chat/fake_recive_dummy_message.dart';
import 'package:hokoo_flutter/view/Chat_Screen/fake_chat/fake_send_dummy_message.dart';
import 'package:hokoo_flutter/view/Chat_Screen/record_button.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:image_picker/image_picker.dart';

class FakeChatScreen extends StatefulWidget {
  final String callType;
  final String hostName;
  final String hostImage;
  final String chatRoomId;
  final String senderId;
  final String receiverId;
  final String screenType;
  final String videoUrl;
  final int type;

  const FakeChatScreen(
      {Key? key,
      required this.hostName,
      required this.chatRoomId,
      required this.senderId,
      required this.hostImage,
      required this.receiverId,
      required this.screenType,
      required this.type,
      required this.callType,
      required this.videoUrl})
      : super(key: key);

  @override
  State<FakeChatScreen> createState() => _FakeChatScreenState();
}

class _FakeChatScreenState extends State<FakeChatScreen> {
  @override
  void initState() {
    super.initState();
    // getOldChatController.oldChat(widget.chatRoomId);
    dummyChat = dummyChat1.reversed.toList();

    // connect();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Voice Message ///

  @override
  Widget build(BuildContext context) {
    log("button is :- $videoButtonIs");
    log("isHost :- $isHost");

    SizeConfig().init(context);
    return GetBuilder<FakeChatController>(
      init: FakeChatController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            setState(() {
              controller.emojiShowing = false;
            });
          },
          child: WillPopScope(
            onWillPop: () async {
              if (widget.screenType == 'HostScreen') {
                selectedIndex = 1;
                Get.offAll(const HostBottomNavigationBarScreen());
                Get.delete<GetOldChatController>();
                // hostSelectedIndex = 1;
                // Get.off(const HostBottomNavigationBarScreen());
              } else if (widget.screenType == "UserScreen") {
                selectedIndex = 1;
                Get.offAll(const UserBottomNavigationScreen());
                Get.delete<GetOldChatController>();
              } else if (widget.screenType == "StoryUserScreen" || widget.screenType == "UserProfileScreen") {
                Get.back();
                Get.delete<GetOldChatController>();
              } else {}
              return false;
            },
            child: Scaffold(
              backgroundColor: AppColors.chatBackgroundColor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: AppBar(
                    backgroundColor: AppColors.chatBackgroundColor,
                    leadingWidth: SizeConfig.blockSizeHorizontal * 9,
                    leading: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2.5),
                      child: IconButton(
                        highlightColor: AppColors.transparentColor,
                        splashColor: AppColors.transparentColor,
                        onPressed: () {
                          if (widget.screenType == 'HostScreen') {
                            selectedIndex = 1;
                            Get.offAll(const HostBottomNavigationBarScreen());
                            Get.delete<GetOldChatController>();
                            // hostSelectedIndex = 1;
                            // Get.off(const HostBottomNavigationBarScreen());
                          } else if (widget.screenType == "UserScreen") {
                            selectedIndex = 1;
                            Get.offAll(const UserBottomNavigationScreen());
                            Get.delete<GetOldChatController>();
                          } else if (widget.screenType == "StoryUserScreen" || widget.screenType == "UserProfileScreen") {
                            Get.back();
                            Get.delete<GetOldChatController>();
                          } else {}
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.pinkColor,
                          size: 25,
                        ),
                      ),
                    ),
                    elevation: 0,
                    title: GestureDetector(
                      onTap: () {
                        setState(() {
                          isStory = false;
                        });
                        // (isProfile)
                        //     ? Get.back()
                        //     : Get.offAll(() => const UserHomeProfileScreen(),
                        //         arguments: data);
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(1.5),
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.pinkColor),
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
                              ),
                            ),
                          ),
                          Text(
                            widget.hostName,
                            style: TextStyle(
                                color: AppColors.pinkColor,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeHorizontal * 5),
                          )
                        ],
                      ),
                    ),
                    actions: [
                      AbsorbPointer(
                        absorbing: !videoButtonIs,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => FakeDemoCall(
                                  receiverId: widget.receiverId,
                                  hostName: widget.hostName,
                                  hostImage: widget.hostImage,
                                  callType: 'normal',
                                  videoUrl: widget.videoUrl,
                                ));
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.pinkColor),
                                    shape: BoxShape.circle,
                                    color: AppColors.transparentColor,
                                  ),
                                  child: const ImageIcon(
                                    color: AppColors.pinkColor,
                                    AssetImage(AppImages.videoCall),
                                  ))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  decoration:
                      const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.appBackground), fit: BoxFit.cover)),
                  child: WillPopScope(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: controller.scrollController,
                            shrinkWrap: true,
                            reverse: true,
                            // itemCount: getOldChatController
                            //     .oldChatData!.chat!.length,
                            itemCount: dummyChat.length,
                            itemBuilder: (context, index) {
                              if (dummyChat[index].senderId == widget.senderId) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    FakeSendDummyMessage(
                                      message: dummyChat[index].message.toString(),
                                      time: "5:30",
                                      type: int.parse(
                                        dummyChat[index].messageType.toString(),
                                      ),
                                      assetFile: dummyChat[index].image,
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    // Container(
                                    //   height: 30,
                                    //   width: 85,
                                    //   decoration: BoxDecoration(
                                    //       color: const Color(0xff676767),
                                    //       borderRadius:
                                    //       BorderRadius.circular(10)),
                                    //   alignment: Alignment.center,
                                    //   child: Text(
                                    //    " getOldChatController.dateYt[index]",
                                    //     style: const TextStyle(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w500,
                                    //       color: Color(0xff9F9F9F),
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    FakeReceiveDummyMessage(
                                      message: dummyChat[index].message.toString(),
                                      profileImage: (dummyChat[index].senderId.toString() == widget.senderId)
                                          ? userImage
                                          : widget.hostImage,
                                      time: "05:00",
                                      messageType: dummyChat[index].messageType!.toInt(),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  itemCount: controller.dummyMessageWithDialog.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.onTabSend(message: controller.dummyMessageWithDialog[index], messageType: 1);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: const Color(0xff767676), width: 1),
                                          color: const Color(0xff2D2B2C),
                                        ),
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                        ),
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Center(
                                          child: Text(controller.dummyMessageWithDialog[index],
                                              style: const TextStyle(
                                                  color: Color(0xff767676), fontSize: 16, fontWeight: FontWeight.w400)),
                                        ),
                                      ),
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                color: AppColors.transparentColor,
                                padding: const EdgeInsets.only(top: 9),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width - 60,
                                      child: Card(
                                        color: AppColors.optionMessageBorderColor,
                                        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                        child: TextFormField(
                                          keyboardAppearance: Brightness.dark,
                                          focusNode: controller.focusNode,
                                          minLines: 1,
                                          maxLines: 5,
                                          keyboardType: TextInputType.multiline,
                                          textAlignVertical: TextAlignVertical.center,
                                          controller: controller.textEditingController,
                                          autofocus: false,
                                          autocorrect: false,
                                          cursorColor: AppColors.messageOptionColor,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeConfig.blockSizeHorizontal * 4,
                                            color: AppColors.messageOptionColor,
                                          ),
                                          decoration: InputDecoration(
                                            prefixIcon: IconButton(
                                              onPressed: () {
                                                controller.focusNode.unfocus();
                                                controller.focusNode.canRequestFocus = false;
                                                setState(() {
                                                  controller.emojiShowing = !controller.emojiShowing;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.emoji_emotions,
                                                color: AppColors.messageOptionColor,
                                              ),
                                            ),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(top: 2, right: 2),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.bottomSheet(Container(
                                                    height: 200,
                                                    decoration: const BoxDecoration(
                                                        color: AppColors.cameraBottomSheetColor,
                                                        borderRadius: BorderRadius.only(
                                                            topRight: Radius.circular(22), topLeft: Radius.circular(22))),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(12.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            "Select Image From",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w700,
                                                                color: AppColors.pinkColor,
                                                                fontSize: 18),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          const Divider(
                                                            height: 1,
                                                            color: AppColors.cameraBottomSheetColor,
                                                            thickness: 0.8,
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          InkWell(
                                                            onTap: () => controller.cameraImage(),
                                                            child: Container(
                                                              height: 50,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(6),
                                                                color: AppColors.cameraBottomSheetColor,
                                                              ),
                                                              child: const Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 24,
                                                                    width: 22,
                                                                    child: ImageIcon(AssetImage(AppImages.messageCamera),
                                                                        color: Colors.white),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Text(
                                                                    "Take a photo",
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.white,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          InkWell(
                                                            onTap: () => controller.pickImage(),
                                                            child: Container(
                                                              height: 50,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(6),
                                                                color: AppColors.cameraBottomSheetColor,
                                                              ),
                                                              child: const Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 24,
                                                                    width: 22,
                                                                    child: ImageIcon(
                                                                      AssetImage(AppImages.messageGellary),
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Text(
                                                                    "Choose From Gallery",
                                                                    style: TextStyle(
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.white),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                                },
                                                child: const Icon(
                                                  Icons.camera_alt,
                                                  color: AppColors.messageOptionColor,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding: const EdgeInsets.all(5),
                                            hintText: "Message",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                                              color: AppColors.messageOptionColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    (controller.isButtonDisabled)
                                        ? Padding(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: RecordButton(
                                              controller: controller.animationController,
                                              chatRoomId: widget.chatRoomId,
                                              senderId: widget.senderId,
                                              type: widget.type,
                                              isFake: true,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(bottom: 8, right: 5),
                                            child: CircleAvatar(
                                              backgroundColor: (AppColors.chatBackgroundColor),
                                              radius: 25,
                                              child: IconButton(
                                                onPressed: () {
                                                  if (controller.textEditingController.text.isNotEmpty) {
                                                    controller.scrollController
                                                        .jumpTo(controller.scrollController.position.minScrollExtent);
                                                    setState(() {
                                                      controller.isVisible = true;
                                                      controller.onTabSend(
                                                          message: controller.textEditingController.text.trim(), messageType: 1);
                                                    });
                                                    controller.textEditingController.clear();
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.send,
                                                  color: AppColors.pinkColor,
                                                ),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              Offstage(
                                offstage: !controller.emojiShowing,
                                child: SizedBox(
                                  height: 270,
                                  child: EmojiPicker(
                                    textEditingController: controller.textEditingController,
                                    config: Config(
                                      height: 256,
                                      checkPlatformCompatibility: true,
                                      emojiViewConfig: EmojiViewConfig(
                                        emojiSizeMax: 28 * (Platform.isIOS ? 1.20 : 1.0),
                                      ),
                                      // swapCategoryAndBottomBar: false,
                                      skinToneConfig: const SkinToneConfig(indicatorColor: AppColors.pinkColor),
                                      categoryViewConfig: const CategoryViewConfig(
                                        indicatorColor: AppColors.pinkColor,
                                        iconColor: AppColors.grey,
                                        iconColorSelected: AppColors.pinkColor,
                                      ),
                                      bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    onWillPop: () {
                      if (controller.emojiShowing) {
                        setState(() {
                          controller.emojiShowing = false;
                        });
                      } else {
                        Get.back();
                      }
                      return Future.value(false);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class FakeChatController extends GetxController with GetSingleTickerProviderStateMixin {
  List<GetOldChat> messages = [];
  bool isButtonDisabled = true;
  String a = "";
  bool isVisible = false;
  bool emojiShowing = false;
  FocusNode focusNode = FocusNode();
  // CreateChatController createChatController = Get.put(CreateChatController());
  // GetOldChatController getOldChatController = Get.put(GetOldChatController());
  late AnimationController animationController;

  // bool enabled = true;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    // TODO: implement onInit
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        emojiShowing = false;
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
        update();
      }
    });
    textEditingController.addListener(() {
      validateField(textEditingController.text);
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    super.onInit();
  }

  List dummyMessageWithDialog = [
    "Hii",
    "Hello",
    "How are You?",
    "Let's Hangout",
    "I am Fine",
  ];

  // late IO.Socket socket;

/*  void connect() {
    log("on");
    log(widget.chatRoomId);
    socket = IO.io(
      Constant.baseUrl1,
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {"chatRoom": widget.chatRoomId}).build(),
    );
    socket.connect();

    socket.onConnect((data) {
      log("Connected");
      socket.on("chat", (msg) {
        log("**********************${msg.toString()}");
        String date = msg["date"];
        List<String> dateParts = date.split(", ");
        List<String> time = dateParts[1].toString().split(":");
        List<String> pmdate = time[2].toString().split(" ");
        String finalDate = "${time[0]}:${time[1]} ${pmdate[1]}";
        //// ==== TODAY YESTERDAY ==== \\\\
        var now = DateTime.now();
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        String nowDate = DateFormat.yMd().format(now);
        String previousDate = DateFormat.yMd().format(yesterday);
        log("=========$previousDate==========");
        if (nowDate == dateParts[0]) {
          log("+++++++++++++++++++TODAY++++++++++++");
          getOldChatController.dateYt.add("Today");
        } else if (previousDate == dateParts[0]) {
          getOldChatController.dateYt.add("Yesterday");
          log("+++++++++++++++++++Yesterday++++++++++++");
        } else {
          List datePartslist = dateParts[0].split("/");
          getOldChatController.dateYt.add(
              "${datePartslist[1]}/${datePartslist[0]}/${datePartslist[2]}");
        }
        log("!!!!!!!!!!@@@@@@@@@@${getOldChatController.position}@@@@@@@@@@@@@@@@");
        if (getOldChatController.position.isEmpty) {
          getOldChatController.position.add(1);
        } else if (getOldChatController.dateYt.last ==
            getOldChatController
                .dateYt[getOldChatController.dateYt.length - 2]) {
          getOldChatController.position.add(0);
        } else {
          log("!!!!!!!!!!!!!!!!!!!!");
          getOldChatController.position.add(1);
          log("!!!!!!!!!!!!!!!!!!!!");
        }
        log("#############################${getOldChatController.position}");
        setMessage(
            senderId: msg["senderId"],
            message: msg["message"],
            type: msg["type"],
            time: finalDate,
            isRead: msg["isRead"],
            messageType: msg["messageType"]);
        setState(() {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      });
    });
  }*/
  void onTabSend({required int messageType, required String message, File? assetFile}) {
    if (messageType == 1 || messageType == 3) {
      setMessage(
        messageType,
        message,
      );
      log("_____++++111");
      textEditingController.clear();
      update();
    } else if (messageType == 2 || messageType == 4) {
      setMessage(
        messageType,
        message,
        assetFile: assetFile,
      );
    }
  }

  void setMessage(int type, String message, {File? assetFile}) {
    GetOldChat dummyChatModel;
    if (type == 1 || type == 3) {
      dummyChatModel = GetOldChat(
        id: '35',
        message: message,
        senderId: loginUserId,
        messageType: type,
        type: 0,
        date: DateTime.now().toString(),
        createdAt: '2024-02-26T08:34:00Z',
        updatedAt: '2024-02-26T08:34:00Z',
      );
      dummyChat.insert(0, dummyChatModel);
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      update();
    } else if (type == 2 || type == 4) {
      dummyChatModel = dummyChatModel = GetOldChat(
          id: '35',
          message: message,
          senderId: loginUserId,
          messageType: type,
          type: 0,
          date: DateTime.now().toString(),
          createdAt: '2024-02-26T08:34:00Z',
          updatedAt: '2024-02-26T08:34:00Z',
          image: assetFile);
      dummyChat.insert(0, dummyChatModel);
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      update();
    }
  }

  /// OnTab Message send

  void validateField(text) {
    if (textEditingController.text.isEmpty || textEditingController.text.isBlank == true) {
      isButtonDisabled = true;
      update();
    } else {
      isButtonDisabled = false;
      update();
    }
  }

  File? proImage;

  Future pickImage() async {
    try {
      final imagePick = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePick == null) return;

      final imagePickIs = File(imagePick.path);
      createChatImage = imagePickIs;

      proImage = imagePickIs;
      onTabSend(messageType: 2, message: "", assetFile: proImage);
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      Get.back();
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  Future cameraImage() async {
    try {
      final imageCamera = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imageCamera == null) return;

      final imageCameraIs = File(imageCamera.path);
      createChatImage = imageCameraIs;

      proImage = imageCameraIs;
      onTabSend(messageType: 2, message: "", assetFile: proImage);
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      Get.back();
      update();
    } catch (e) {
      log(e.toString());
    }
  }
}
