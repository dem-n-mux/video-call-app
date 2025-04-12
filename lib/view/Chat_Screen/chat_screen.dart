import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_controller.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/get_old_chat_controller.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/demo_page.dart';
import 'package:hokoo_flutter/view/Chat_Screen/record_button.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/chat_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/dummy_host_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/recive_dummy_message.dart';
import 'package:hokoo_flutter/view/utils/widgets/send_dummy_message.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// ignore:library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../host/Host Bottom Navigation Bar/host_bottom_navigation_screen.dart';
import '../user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';

class ChatScreen extends StatefulWidget {
  final String callType;
  final String hostName;
  final String hostImage;
  final String chatRoomId;
  final String senderId;
  final String receiverId;
  final String screenType;
  final int type;

  const ChatScreen({
    Key? key,
    required this.hostName,
    required this.chatRoomId,
    required this.senderId,
    required this.hostImage,
    required this.receiverId,
    required this.screenType,
    required this.type,
    required this.callType,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  List<DummyChatModel> messages = [];
  bool isButtonDisabled = true;
  String a = "";
  bool isVisible = false;
  bool emojiShowing = false;
  FocusNode focusNode = FocusNode();
  CreateChatController createChatController = Get.put(CreateChatController());
  GetOldChatController getOldChatController = Get.put(GetOldChatController());

  // bool enabled = true;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List dummyMessageWithDialog = [
    "Hii",
    "Hello",
    "How are You?",
    "Let's Hangout",
    "I am Fine",
  ];

  late IO.Socket socket;

  void connect() {
    log("on");
    log(widget.chatRoomId);
    socket = IO.io(
      Constant.BASE_URL,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({"chatRoom": widget.chatRoomId}).build(),
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
        log("message:::::$now");
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
          getOldChatController.dateYt.add("${datePartslist[1]}/${datePartslist[0]}/${datePartslist[2]}");
        }
        log("!!!!!!!!!!@@@@@@@@@@${getOldChatController.position}@@@@@@@@@@@@@@@@");
        if (getOldChatController.reversedPosition.isEmpty) {
          getOldChatController.reversedPosition.add(1);
        } else if (getOldChatController.dateYt.last == getOldChatController.dateYt[getOldChatController.dateYt.length - 2]) {
          getOldChatController.reversedPosition.add(0);
        } else {
          log("!!!!!!!!!!!!!!!!!!!!");
          getOldChatController.reversedPosition.add(1);
          log("!!!!!!!!!!!!!!!!!!!!");
        }
        getOldChatController.position = getOldChatController.reversedPosition.reversed.toList();

        log("####################getOldChatController.position#########${getOldChatController.position}");
        log("####################getOldChatController.reversedPosition#########${getOldChatController.reversedPosition}");
        setMessage(
            senderId: msg["senderId"],
            message: msg["message"],
            type: msg["type"],
            time: finalDate,
            isRead: msg["isRead"],
            messageType: msg["messageType"]);
        setState(() {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        });
      });
    });
  }

  void sendMessage(String message) async {
    socket.emit("chat", {
      "topicId": widget.chatRoomId,
      "senderId": widget.senderId,
      "messageType": 3,
      "type": widget.type,
      "message": message,
    });
  }

  void setMessage({
    required String senderId,
    required String message,
    required int type,
    required String time,
    required bool isRead,
    required int messageType,
  }) {
    ChatModel messageModel =
        ChatModel(senderId: senderId, message: message, type: type, time: time, isRead: isRead, messageType: messageType);
    if (mounted) {
      setState(() {
        getOldChatController.chatList.insert(0, messageModel);
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      });
    }
  }

  void validateField(text) {
    if (_controller.text.isEmpty || _controller.text.isBlank == true) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getOldChatController.oldChat(widget.chatRoomId);
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        });
      }
    });
    _controller.addListener(() {
      validateField(_controller.text);
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  File? proImage;

  Future pickImage() async {
    try {
      final imagePick = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePick == null) return;

      final imagePickIs = File(imagePick.path);
      createChatImage = imagePickIs;
      CreateChatController().createChat(widget.chatRoomId, 0, widget.senderId, widget.type, imagePickIs);

      setState(() {
        proImage = imagePickIs;
        Get.back();
      });
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
      CreateChatController().createChat(widget.chatRoomId, 0, widget.senderId, widget.type, imageCameraIs);
      setState(() {
        proImage = imageCameraIs;
        Get.back();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  ///Voice Message ///
  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    log("button is :- $videoButtonIs");

    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          emojiShowing = false;
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
                      // Container(
                      //   margin: EdgeInsets.only(
                      //       right: SizeConfig.blockSizeHorizontal * 3),
                      //   height: 50,
                      //   width: 50,
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       image: DecorationImage(
                      //           image: NetworkImage(widget.hostImage),
                      //           fit: BoxFit.cover),
                      //       border: Border.all(
                      //           width: 1.5, color: AppColors.pinkColor)),
                      // ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            // image: DecorationImage(image: NetworkImage(widget.profileImage), fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: AppColors.pinkColor),
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
                      ).paddingOnly(right: 8),
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
                      onTap: isHost
                          ? (int.parse(hostCoin.value) >= 20)
                              ? () async {
                                  setState(() {
                                    videoButtonIs = false;
                                    Future.delayed(const Duration(seconds: 5), () {
                                      videoButtonIs = true;
                                    });
                                  });
                                  Get.to(() => DemoCall(
                                        receiverId: widget.receiverId,
                                        hostName: widget.hostName,
                                        hostImage: widget.hostImage,
                                        callType: 'normal',
                                        videoCallType: (widget.type == 1) ? "user" : "host",
                                      ));
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
                                }
                          : (int.parse(userCoin.value) >= 20)
                              ? () async {
                                  setState(() {
                                    videoButtonIs = false;
                                    Future.delayed(const Duration(seconds: 5), () {
                                      videoButtonIs = true;
                                    });
                                  });
                                  Get.to(() => DemoCall(
                                        receiverId: widget.receiverId,
                                        hostName: widget.hostName,
                                        hostImage: widget.hostImage,
                                        callType: 'normal',
                                        videoCallType: (widget.type == 1) ? "user" : "host",
                                      ));
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
                      // onTap: (int.parse(userCoin.value) >= 20)
                      //     ? () async {
                      //         log(widget.senderId);
                      //         log(widget.receiverId);
                      //         log(widget.hostImage);
                      //         log(widget.hostName);
                      //         log(widget.callType);
                      //         setState(() {
                      //           videoButtonIs = false;
                      //           log("button is :- $videoButtonIs");
                      //           Future.delayed(const Duration(seconds: 5), () {
                      //             setState(() {
                      //               videoButtonIs = true;
                      //               log("==============button is :- $videoButtonIs");
                      //             });
                      //           });
                      //         });
                      //         Get.to(() => DemoCall(
                      //               receiverId: widget.receiverId,
                      //               hostName: widget.hostName,
                      //               hostImage: widget.hostImage,
                      //               callType: 'normal',
                      //               videoCallType:
                      //                   (widget.type == 1) ? "user" : "host",
                      //             ));
                      //       }
                      //     : () {
                      //         Fluttertoast.showToast(
                      //           msg: "Insufficient Balance",
                      //           toastLength: Toast.LENGTH_SHORT,
                      //           gravity: ToastGravity.SNACKBAR,
                      //           backgroundColor: Colors.black.withOpacity(0.35),
                      //           textColor: Colors.white,
                      //           fontSize: 16.0,
                      //         );
                      //       },
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
                    Obx(() {
                      if (getOldChatController.isLoading.value) {
                        return const Expanded(
                            child: Center(
                                child: CircularProgressIndicator(
                          color: AppColors.pinkColor,
                        )));
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            reverse: true,
                            // itemCount: getOldChatController
                            //     .oldChatData!.chat!.length,
                            itemCount: getOldChatController.chatList.length,
                            itemBuilder: (context, index) {
                              log("first   msg :::${getOldChatController.chatList.first.message}");
                              log("last msg::::::${getOldChatController.chatList.last.message}");
                              if (getOldChatController.chatList[index].senderId == widget.senderId) {
                                if (getOldChatController.position[index] == 1) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 85,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff676767), borderRadius: BorderRadius.circular(10)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          getOldChatController.dateYt[index],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff9F9F9F),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SendDummyMessage(
                                        message: getOldChatController.chatList[index].message.toString(),
                                        time: getOldChatController.chatList[index].time.toString(),
                                        messageType: getOldChatController.chatList[index].messageType,
                                        index: index,
                                      ),
                                    ],
                                  );
                                } else {
                                  return SendDummyMessage(
                                    message: getOldChatController.chatList[index].message.toString(),
                                    time: getOldChatController.chatList[index].time.toString(),
                                    messageType: getOldChatController.chatList[index].messageType,
                                    index: index,
                                  );
                                }
                              } else {
                                if (getOldChatController.position[index] == 1) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 85,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff676767), borderRadius: BorderRadius.circular(10)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          getOldChatController.dateYt[index],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff9F9F9F),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ReceiveDummyMessage(
                                        message: getOldChatController.chatList[index].message.toString(),
                                        profileImage:
                                            (getOldChatController.chatList[index].senderId.toString() == widget.senderId)
                                                ? userImage
                                                : widget.hostImage,
                                        time: getOldChatController.chatList[index].time.toString(),
                                        messageType: getOldChatController.chatList[index].messageType,
                                      ),
                                    ],
                                  );
                                } else {
                                  return ReceiveDummyMessage(
                                    message: getOldChatController.chatList[index].message.toString(),
                                    profileImage: (getOldChatController.chatList[index].senderId.toString() == widget.senderId)
                                        ? userImage
                                        : widget.hostImage,
                                    time: getOldChatController.chatList[index].time.toString(),
                                    messageType: getOldChatController.chatList[index].messageType,
                                  );
                                }
                              }
                            },
                          ),
                        );
                      }
                    }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              itemCount: dummyMessageWithDialog.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sendMessage(
                                        dummyMessageWithDialog[index],
                                      );
                                    });
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
                                      child: Text(dummyMessageWithDialog[index],
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
                                      focusNode: focusNode,
                                      minLines: 1,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      textAlignVertical: TextAlignVertical.center,
                                      controller: _controller,
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
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            setState(() {
                                              emojiShowing = !emojiShowing;
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
                                                        onTap: () => cameraImage(),
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
                                                        onTap: () => pickImage(),
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
                                (isButtonDisabled)
                                    ? Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: RecordButton(
                                          controller: animationController,
                                          chatRoomId: widget.chatRoomId,
                                          senderId: widget.senderId,
                                          type: widget.type,
                                          isFake: false,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(bottom: 8, right: 5),
                                        child: CircleAvatar(
                                          backgroundColor: (AppColors.chatBackgroundColor),
                                          radius: 25,
                                          child: IconButton(
                                            onPressed: () {
                                              if (_controller.text.isNotEmpty) {
                                                sendMessage(
                                                  _controller.text.trim(),
                                                );
                                                _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                                                setState(() {
                                                  isVisible = true;
                                                });
                                                _controller.clear();
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
                            offstage: !emojiShowing,
                            child: SizedBox(
                              height: 270,
                              child: EmojiPicker(
                                textEditingController: _controller,
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
                  if (emojiShowing) {
                    setState(() {
                      emojiShowing = false;
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
  }
}
