// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';

// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;

// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/gift/controller/create_gift_category_controller.dart';
import 'package:hokoo_flutter/Api_Service/gift/controller/generate_gift_controller.dart';
import 'package:hokoo_flutter/Controller/user_live_streaming_comment_profile_controller.dart';
import 'package:hokoo_flutter/view/Chat_Screen/chat_screen.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/comment_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/user_live_streaming_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/custom_report.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Participant extends StatefulWidget {
  final String token;
  final String hostId;
  final String channelName;
  final ClientRole clientRole;
  final String liveStreamingId;
  final String hostname;
  final String hostImage;
  String? age;
  String? country;

  Participant({
    Key? key,
    required this.token,
    required this.channelName,
    required this.clientRole,
    required this.liveStreamingId,
    required this.hostname,
    required this.hostImage,
    this.age,
    this.country,
    required this.hostId,
  }) : super(key: key);

  @override
  State<Participant> createState() => _ParticipantState();
}

class _ParticipantState extends State<Participant> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  CreateGiftCategoryController createGiftCategoryController = Get.put(CreateGiftCategoryController());
  GenerateGiftController generateGiftController = Get.put(GenerateGiftController());
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());
  UserLiveStreamingCommentProfile userLiveStreamingCommentProfile = Get.put(UserLiveStreamingCommentProfile());

  var userCommentList = List.filled(100, userLiveStreamingCommentList);
  bool userLiveStreamingShowSizeBox = false;
  bool userLiveStreamingIsRearCameraSelected = true;
  bool userLiveStreamingIsButtonDisabled = true;
  bool userLiveStreamingWillPop = true;
  int randomNumber = 0;
  Random random = Random();
  final _users = <int>[];
  final infoString = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;

  TextEditingController commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // VideoCallController videoCallController = Get.put(VideoCallController());

  bool showSizeBox = false;

  // bool isRearCameraSelected = true;
  bool isButtonDisabled = true;
  bool willPop = true;
  FocusNode focusNode = FocusNode();
  bool emojiShowing = false;
  bool showColor = true;
  int view = 0;
  String gift = "";
  bool showEffect = false;
  String flameString = "";
  bool showFlame = false;
  String effect = "";
  String sticker = "";
  bool showGif = false;
  bool showSticker = false;
  var dropdownValue1 = 1;
  var dropdownValue = 0;
  bool isAbsorbing = false;

  String countValueIs = "";

  var items = [
    1,
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
  ];

  TextEditingController userLiveStreamingCommentController = TextEditingController();

  final ScrollController userLiveStreamingScrollController = ScrollController(keepScrollOffset: true, initialScrollOffset: 10);

  void validateField(text) {
    if (commentController.text.isEmpty || commentController.text.isBlank == true) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  void addItems() {
    // hostCommentList.shuffle();
    if (!mounted) return;
    setState(() {
      demoStreamList.add(hostCommentList.first);
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  void connect() {
    var obj = json.encode({
      "liveUserRoom": loginUserId,
      "liveRoom": widget.liveStreamingId,
    }.map((key, value) => MapEntry(key, value.toString())));
    liveSocket = IO.io(Constant.BASE_URL, IO.OptionBuilder().setTransports(['websocket']).setQuery({"obj": obj}).build());
    liveSocket.connect();
    liveSocket.onConnect((data1) {
      debugPrint("Socket Connected");
      liveSocket.emit(
          "addView", {"userId": loginUserId, "name": userName, "image": userImage, "liveStreamingId": widget.liveStreamingId});
      liveSocket.emit("comment", {
        "liveStreamingId": widget.liveStreamingId,
        "message": "$userName joined ",
        "user": userName,
        "image": userImage,
        "age": '23',
        "country": "India",
        "id": '00000010',
      });
      liveSocket.on("view", (data) {
        List viewData = data;
        if (mounted) {
          setState(() {
            view = viewData.length;
          });
        }
      });
      liveSocket.on("comment", (data) {
        debugPrint("comment ========== $data");
        if (mounted) {
          setState(() {
            demoStreamList.add(HostComment(
              message: data["message"],
              user: data["user"],
              image: data["image"],
              age: '23',
              country: "India",
              id: '00000010',
            ));
          });
        }
      });
      liveSocket.on("gift", (data) {
        debugPrint("User Send Gift :: $data");
        debugPrint(data[0]["gift"]["image"]);
        debugPrint(data[1]["coin"]);
        debugPrint(data[2]["coin"]);
        setState(() {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setString("userCoin", (data[1]["coin"]).toString());
            preferences.setString("hostCoin", (data[2]["coin"]).toString());
            userCoin.value = preferences.getString("userCoin")!;
            hostCoin.value = preferences.getString("hostCoin")!;
          });
          userCoin.value = "${data[1]["coin"]}";
          gift = "${Constant.BASE_URL}${data[0]["gift"]["image"]}";
          showGif = data[0]["isshowGif"];
          countValueIs = data[0]["countOfGift"];
        });
        Future.delayed(const Duration(seconds: 3)).then((value) {
          setState(() {
            dropdownValue = 1;
            showGif = false;
            countValueIs = "";
          });
        });
      });
      liveSocket.on("sticker", (data) {
        debugPrint("Sticker Socket on :: $data");
        sticker = "${Constant.BASE_URL}${data["sticker"]}";
        setState(() {
          showSticker = data["isshowSticker"];
        });
        debugPrint("sticker :: $sticker");
        debugPrint("showSticker :: $showSticker");
        Future.delayed(const Duration(seconds: 3)).then((value) {
          setState(() {
            showSticker = false;
          });
        });
      });

      liveSocket.on("effect", (data) {
        debugPrint("Effect Socket on +++++++++++++++ $data");
        effect = "${data["sticker"]}";
        setState(() {
          showEffect = data["isshowSticker"];
        });
        debugPrint("effect :- $effect");
        debugPrint("showEffect:- $showEffect");
      });

      liveSocket.on("fire", (data) {
        debugPrint("flame Socket on +++++++++++++++ $data");
        flameString = "${data["sticker"]}";
        setState(() {
          showFlame = data["isshowSticker"];
        });
        debugPrint("flame :- $flameString");
        debugPrint("showFlame:- $showFlame");
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await createGiftCategoryController.createGift();
      generateGiftController.generateGift(createGiftCategoryController.createGiftCategoryModel!.gift![0].id.toString());
      debugPrint("List tabbar leanth  :: ${createGiftCategoryController.createGiftCategoryModel!.gift!.length}");
      _tabController =
          TabController(length: createGiftCategoryController.createGiftCategoryModel!.gift!.length, vsync: this, initialIndex: 0);
    });

    createChatRoomController.createChatRoom(loginUserId, widget.hostId);
    initialize();
    connect();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });

    commentController.addListener(() {
      validateField(commentController.text);
    });
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      randomNumber = random.nextInt(450);
    });

    super.initState();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        infoString.add("appId is missing, Please provide your appId in app_variables.dart");
        infoString.add("Agora engine is not starting");
      });
      return;
    }
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.clientRole);
    addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = const VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(widget.token, widget.channelName, null, 0);
  }

  void addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = "Error :$code";
        infoString.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = "Join Channel:$channel,uid:$uid";
        infoString.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        infoString.add("Leave Channel");
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = "User Joined:$uid";
        infoString.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        _users.clear();
        selectedIndex = 0;
        Get.offAll(() => const UserBottomNavigationScreen());
        final info = "User Offline:$uid";
        infoString.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = "First Remote Video:$uid ${width}x$height";
        infoString.add(info);
      });
    }));
  }

  Widget viewRows() {
    final List<StatefulWidget> list = [];
    if (widget.clientRole == ClientRole.Broadcaster) {
      list.add(const RtcLocalView.SurfaceView());
    }
    for (var uid in _users) {
      list.add(RtcRemoteView.SurfaceView(uid: uid, channelId: widget.channelName));
    }
    final views = list;
    return Column(
      children: List.generate(views.length, (index) => Expanded(child: views[index])),
    );
  }

  animateToMaxMin(double max, double min, double direction, int seconds, ScrollController scrollController) {
    scrollController.animateTo(direction, duration: Duration(seconds: seconds), curve: Curves.linear);
  }

  // DummyHostModel data = Get.arguments;

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          emojiShowing = false;
        });
      },
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: WillPopScope(
          onWillPop: () async {
            if (emojiShowing) {
              setState(() {
                emojiShowing = false;
                showColor = true;
              });
            } else {
              setState(() {
                willPop = false;
              });
              liveSocket.emit("lessView",
                  {"userId": loginUserId, "name": userName, "image": userImage, "liveStreamingId": widget.liveStreamingId});
              demoStreamList.clear();

              selectedIndex = 0;
              Get.offAll(const UserBottomNavigationScreen());
            }
            return false;
          },
          child: Scaffold(
            floatingActionButton: buildTextField(context),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: Stack(
              children: [
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: viewRows(),
                ),
                Stack(
                  children: [
                    (showEffect)
                        ? Opacity(
                            opacity: 0.2,
                            child: SizedBox(
                              width: Get.width,
                              height: Get.height,
                              child: Image(
                                image: AssetImage(effect),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(),
                    (showFlame)
                        ? Opacity(
                            opacity: 0.2,
                            child: SizedBox(
                              width: Get.width,
                              height: Get.height,
                              child: Image(
                                image: AssetImage(flameString),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(),
                    (showGif)
                        ? Container(
                            width: Get.width,
                            height: Get.height,
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 190,
                              width: 190,
                              child: Image(
                                image: NetworkImage(gift),
                              ),
                            ),
                          )
                        : Container(),
                    (showSticker)
                        ? Container(
                            width: Get.width,
                            height: Get.height,
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child: Image(
                                image: NetworkImage(sticker),
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      height: Get.height,
                      width: Get.width,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100, right: 85),
                        child: Text(countValueIs,
                            style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          right: 10,
                          left: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                  shape: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                                  backgroundColor: const Color(0xff161622),
                                  Container(
                                    height: Get.height / 2.1,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () => Get.back(),
                                                child: const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Color(0xffDCDCDC),
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Container(
                                        //   alignment: Alignment.center,
                                        //   padding: const EdgeInsets.all(3),
                                        //   height: SizeConfig.blockSizeVertical * 14,
                                        //   width: SizeConfig.blockSizeHorizontal * 28,
                                        //   decoration: const BoxDecoration(
                                        //       shape: BoxShape.circle,
                                        //       gradient: LinearGradient(
                                        //           begin: Alignment.topLeft,
                                        //           end: Alignment.bottomRight,
                                        //           colors: [
                                        //             Color(0xffE5477A),
                                        //             Color(0xffE5477A),
                                        //             Color(0xffE5477A),
                                        //             Color(0xffE5477A),
                                        //             AppColors.appBarColor,
                                        //             AppColors.appBarColor,
                                        //             AppColors.appBarColor,
                                        //           ])),
                                        //   child: Container(
                                        //     decoration: BoxDecoration(
                                        //         shape: BoxShape.circle,
                                        //         image: DecorationImage(
                                        //             image: NetworkImage(widget.hostImage), fit: BoxFit.cover)),
                                        //   ),
                                        // ),
                                        Container(
                                          padding: const EdgeInsets.all(1),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.pinkColor,
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors.pinkColor,
                                                  AppColors.pinkColor,
                                                  Colors.transparent,
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(shape: BoxShape.circle),
                                            child: CachedNetworkImage(
                                              width: 110,
                                              height: 110,
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          widget.hostname,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: SizeConfig.blockSizeHorizontal * 5.8),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
                                              padding: const EdgeInsets.all(5),
                                              height: SizeConfig.blockSizeVertical * 3.5,
                                              width: SizeConfig.blockSizeHorizontal * 15,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: const Color(0xff6C2D42),
                                                  border: Border.all(width: 1, color: const Color(0xffD97998))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig.blockSizeHorizontal * 4,
                                                    decoration: const BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(AppIcons.genderIcon), fit: BoxFit.fill)),
                                                  ),
                                                  Text(widget.age ?? '',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: SizeConfig.blockSizeHorizontal * 3))
                                                ],
                                              ),
                                            ),
                                            Text(
                                              widget.age ?? '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: SizeConfig.blockSizeVertical * 1.8),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (createChatRoomController.createChatRoomData?.status == true) {
                                                    Get.to(
                                                      () => ChatScreen(
                                                        hostName: widget.hostname,
                                                        hostImage: widget.hostImage,
                                                        chatRoomId:
                                                            createChatRoomController.createChatRoomData!.chatTopic!.id.toString(),
                                                        senderId: loginUserId,
                                                        receiverId: widget.hostId,
                                                        screenType: 'UserScreen',
                                                        type: 1,
                                                        callType: 'user',
                                                      ),
                                                    );
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: createChatRoomController.createChatRoomData?.message.toString() ??
                                                            '');
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
                                                  height: SizeConfig.blockSizeVertical * 6,
                                                  width: SizeConfig.screenWidth * .53,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      border: Border.all(width: 1, color: Colors.grey),
                                                      color: const Color(0xff2A2A2A)),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        AppIcons.commentIcon,
                                                        color: Colors.white,
                                                        width: SizeConfig.blockSizeHorizontal * 6,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        "Say Hi",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                                            fontWeight: FontWeight.w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.pinkColor,
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.pinkColor,
                                            AppColors.pinkColor,
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )),
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(shape: BoxShape.circle),
                                      child: CachedNetworkImage(
                                        width: 45,
                                        height: 45,
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
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.hostname,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                              image: AssetImage(AppImages.multiCoin),
                                            )),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Obx(
                                            () => Text(
                                              hostCoin.value,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.pinkColor,
                              ),
                              child: const Text(
                                "LIVE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffD9D9D9).withOpacity(0.29),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  Text(
                                    "$view",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (notificationVisit == true) {
                                      liveSocket.emit("lessView", {
                                        "userId": loginUserId,
                                        "name": userName,
                                        "image": userImage,
                                        "liveStreamingId": widget.liveStreamingId
                                      });
                                      selectedIndex = 0;
                                      Get.offAll(() => const UserBottomNavigationScreen());
                                    } else {
                                      liveSocket.emit("lessView", {
                                        "userId": loginUserId,
                                        "name": userName,
                                        "image": userImage,
                                        "liveStreamingId": widget.liveStreamingId
                                      });
                                      Get.back();
                                    }
                                  },
                                  child: const CircleAvatar(
                                      radius: 18,
                                      backgroundImage: AssetImage(
                                        AppImages.powerOff,
                                      )),
                                ).paddingOnly(bottom: 10),
                                GestureDetector(
                                  onTap: () {
                                    CustomReportView.show();
                                  },
                                  child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.redColor.withOpacity(0.30),
                                      ),
                                      child: const Icon(
                                        Icons.report_gmailerrorred,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildTextField(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        commentSection(),
        Row(
          children: [
            Focus(
              child: Container(
                height: 45,
                width: Get.width / 1.47,
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.transparent),
                child: TextFormField(
                  focusNode: focusNode,
                  keyboardAppearance: Brightness.light,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  onEditingComplete: () {
                    showColor = true;
                    FocusScope.of(context).unfocus();
                  },
                  controller: commentController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20, bottom: 5),
                      border: InputBorder.none,
                      hintText: "Write Comment...",
                      hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
                      prefixIcon: IconButton(
                        onPressed: () {
                          focusNode.unfocus();
                          focusNode.canRequestFocus = false;
                          setState(() {
                            showColor = !showColor;
                            emojiShowing = !emojiShowing;
                          });
                        },
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.white,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (commentController.text.isEmpty || commentController.text.isBlank == true) {
                          } else {
                            liveSocket.emit("comment", {
                              "liveStreamingId": widget.liveStreamingId,
                              "message": commentController.text,
                              "user": userName,
                              "image": userImage,
                              "age": '23',
                              "country": "India",
                              "id": '00000010',
                            });
                            commentController.clear();
                          }

                          // (isButtonDisabled)
                          //     ? null
                          //     : setState(() {
                          //         demoStreamList.add(HostComment(
                          //           message: commentController.text,
                          //           user: userName,
                          //           image: userImage,
                          //           age: '23',
                          //           country: "India",
                          //           id: '00000010',
                          //         ));
                          //
                          //         commentController.clear();
                          //       });
                        },

                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            alignment: Alignment.center,
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.pinkColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 3),
                              child: ImageIcon(
                                color: Colors.white,
                                size: 25,
                                AssetImage(AppImages.send),
                              ),
                            ),
                          ),
                        ),

                        // child: Container(
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       border: Border.all(
                        //           width: 1, color: Colors.white)),
                        //   child: const CircleAvatar(
                        //     backgroundColor: AppColors.pinkColor,
                        //     child: Icon(
                        //       Icons.send,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      )),
                ),
              ),
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    showSizeBox = true;
                  });
                } else {
                  setState(() {
                    showSizeBox = false;
                  });
                }
              },
            ),
            // const SizedBox(width: ,),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AbsorbPointer(
                  absorbing: isAbsorbing,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAbsorbing = true;
                        Share.share("Hello Babble User");
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isAbsorbing = false;
                            debugPrint("Is Absorbing is :- $isAbsorbing");
                          });
                        });
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 43,
                      width: 43,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.40),
                      ),
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                          AppImages.share,
                        ))),
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              width: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  dropdownValue = 1;
                  showModalBottomSheet(
                    backgroundColor: AppColors.appBarColor,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState1) => Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          height: 330,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 40,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        50,
                                      ),
                                    ),
                                    child: TabBar(
                                      onTap: (val) {
                                        generateGiftController.generateGift(
                                            createGiftCategoryController.createGiftCategoryModel!.gift![val].id.toString());
                                      },
                                      indicatorColor: AppColors.pinkColor,
                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                      labelColor: Colors.white,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      controller: _tabController,
                                      labelStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      tabs: List.generate(createGiftCategoryController.createGiftCategoryModel!.gift!.length,
                                          (index) {
                                        return Tab(
                                          child: Text(
                                            createGiftCategoryController.createGiftCategoryModel!.gift![index].name.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: SizedBox(
                                    height: 190,
                                    child: TabBarView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      clipBehavior: Clip.hardEdge,
                                      controller: _tabController,
                                      children: List.generate(createGiftCategoryController.createGiftCategoryModel!.gift!.length,
                                          (index) {
                                        return Obx(() {
                                          if (generateGiftController.isLoading.value) {
                                            return const Center(
                                                child: CircularProgressIndicator(
                                              color: AppColors.pinkColor,
                                            ));
                                          } else {
                                            return generateGiftController.generateGiftModel?.status == true
                                                ? GridView.builder(
                                                    scrollDirection: Axis.vertical,
                                                    physics: const BouncingScrollPhysics(),
                                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                                    shrinkWrap: true,
                                                    itemCount: generateGiftController.generateGiftModel!.gift!.length,
                                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 100,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                    ),
                                                    itemBuilder: (BuildContext context, i) {
                                                      return Obx(
                                                        () {
                                                          return GestureDetector(
                                                            onTap: () async {
                                                              debugPrint("Gift sand on tap");
                                                              userLiveStreamingCommentProfile.selectedGiftIndex.value = i;
                                                              userLiveStreamingCommentProfile.selectedTab = 1;
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  (userLiveStreamingCommentProfile.selectedGiftIndex.value == i)
                                                                      ? BoxDecoration(
                                                                          color: const Color(0xff1C1C2E),
                                                                          borderRadius:
                                                                              const BorderRadius.all(Radius.circular(12)),
                                                                          border: Border.all(
                                                                            color: AppColors.pinkColor,
                                                                          ),
                                                                        )
                                                                      : const BoxDecoration(color: Colors.transparent),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                        image: NetworkImage(
                                                                            "${Constant.BASE_URL}${generateGiftController.generateGiftModel!.gift![i].image.toString()}"),
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                      shape: BoxShape.circle,
                                                                    ),
                                                                    alignment: Alignment.center,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 13,
                                                                        width: 13,
                                                                        child: Image.asset(AppImages.singleCoin),
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 4,
                                                                      ),
                                                                      Text(
                                                                          generateGiftController.generateGiftModel!.gift![i].coin
                                                                              .toString(),
                                                                          style:
                                                                              const TextStyle(fontSize: 12, color: Colors.white)),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child: Text(generateGiftController.generateGiftModel?.message ?? ''),
                                                  );
                                          }
                                        });
                                      }),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        height: 35,
                                        // width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
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
                                                userCoin.value,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        height: 35,
                                        width: 158,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(color: AppColors.pinkColor, width: 1),
                                                  borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(100), bottomLeft: Radius.circular(100)),
                                                ),
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 4),
                                                  child: DropdownButton(
                                                    value: dropdownValue1,
                                                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                                    elevation: 0,
                                                    underline: Container(),
                                                    dropdownColor: Colors.black,
                                                    items: items.map((var items) {
                                                      return DropdownMenuItem(
                                                          value: items,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 10, bottom: 2),
                                                            child: Text(
                                                              "x$items",
                                                              style: const TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ));
                                                    }).toList(),
                                                    onChanged: (var newValue) {
                                                      setState1(() {
                                                        dropdownValue1 = newValue!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  dropdownValue = dropdownValue1;
                                                  if (userLiveStreamingCommentProfile.selectedTab == 1) {
                                                    if (int.parse(userCoin.value) >=
                                                        (generateGiftController
                                                                .generateGiftModel!
                                                                .gift![userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                                .coin)! *
                                                            dropdownValue) {
                                                      liveSocket.emit("UserGift", {
                                                        "coin": (generateGiftController
                                                                .generateGiftModel!
                                                                .gift![userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                                .coin)! *
                                                            dropdownValue,
                                                        "countOfGift": "x$dropdownValue",
                                                        "senderUserId": loginUserId,
                                                        "receiverHostId": widget.hostId,
                                                        "isshowGif": true,
                                                        "gift": generateGiftController.generateGiftModel!
                                                            .gift![userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                      });
                                                      Get.back();
                                                    } else {
                                                      Fluttertoast.showToast(
                                                        msg: "Insufficient Balance",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.SNACKBAR,
                                                        backgroundColor: Colors.black.withOpacity(0.35),
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      );
                                                      Get.back();
                                                    }
                                                  } else if (userLiveStreamingCommentProfile.selectedTab == 2) {
                                                    if (int.parse(userCoin.value) >=
                                                        (generateGiftController
                                                                .generateGiftModel!
                                                                .gift![userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                                .coin)! *
                                                            dropdownValue) {
                                                      liveSocket.emit("UserGift", {
                                                        "coin": (generateGiftController
                                                                .generateGiftModel!
                                                                .gift![userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                                .coin)! *
                                                            dropdownValue,
                                                        "countOfGift": "x$dropdownValue",
                                                        "senderUserId": loginUserId,
                                                        "receiverHostId": widget.hostId,
                                                        "isshowGif": true,
                                                        "gift": generateGiftController.generateGiftModel!
                                                            .gift![userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                      });
                                                      Get.back();
                                                    } else {
                                                      Fluttertoast.showToast(
                                                        msg: "Insufficient Balance",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.SNACKBAR,
                                                        backgroundColor: Colors.black.withOpacity(0.35),
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      );
                                                      Get.back();
                                                    }
                                                  } else if (userLiveStreamingCommentProfile.selectedTab == 3) {
                                                    if (int.parse(userCoin.value) >=
                                                        (generateGiftController
                                                                .generateGiftModel!
                                                                .gift![userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                                .coin)! *
                                                            dropdownValue) {
                                                      liveSocket.emit("UserGift", {
                                                        "coin": (generateGiftController
                                                                .generateGiftModel!
                                                                .gift![userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                                .coin)! *
                                                            dropdownValue,
                                                        "countOfGift": "x$dropdownValue",
                                                        "senderUserId": loginUserId,
                                                        "receiverHostId": widget.hostId,
                                                        "isshowGif": true,
                                                        "gift": generateGiftController.generateGiftModel!
                                                            .gift![userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                      });
                                                      Get.back();
                                                    } else {
                                                      Fluttertoast.showToast(
                                                        msg: "Insufficient Balance",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.SNACKBAR,
                                                        backgroundColor: Colors.black.withOpacity(0.35),
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      );
                                                      Get.back();
                                                    }
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.pinkColor,
                                                  border: Border.all(color: AppColors.pinkColor, width: 1),
                                                  borderRadius: const BorderRadius.only(
                                                      topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
                                                ),
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "Send",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.5,
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 43,
                  width: 43,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffFFB6EC),
                          AppColors.lightPinkColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  child: Container(
                    height: 35,
                    width: 35,
                    foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      AppImages.starGif,
                    ))),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      AppImages.giftGif,
                    ))),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Offstage(
            offstage: !emojiShowing,
            child: SizedBox(
              height: 270,
              child: EmojiPicker(
                textEditingController: commentController,
                config:  Config(
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
          ),
        ),

        // (showSizeBox)
        //     ? const SizedBox(height: 280)
        //     : const SizedBox(),
      ],
    );
  }

  Stack commentSection() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8),
          height: 220,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                stops: [0.0, 0.1, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstOut,
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              reverse: false,
              itemCount: demoStreamList.length,
              itemBuilder: (BuildContext context, int index) {
                if (demoStreamList.isEmpty) {
                  return null;
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5, right: 80),
                  child: GestureDetector(
                    onTap: () {
                      if (FocusScope.of(context).hasFocus) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black.withOpacity(0.10),
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.pinkColor,
                                          AppColors.pinkColor,
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(image: NetworkImage(demoStreamList[index].image), fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 40,
                                      top: 5,
                                    ),
                                    child: Text(
                                      demoStreamList[index].user,
                                      style:
                                          const TextStyle(color: AppColors.pinkColor, fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: Get.width / 1.5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 50,
                                        bottom: 3,
                                      ),
                                      child: Text(
                                        softWrap: false,
                                        demoStreamList[index].message,
                                        style:
                                            const TextStyle(color: Colors.white, fontSize: 13, overflow: TextOverflow.ellipsis),
                                        maxLines: 100,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // AbsorbPointer(
        //   absorbing: !videoButtonIs,
        //   child: Positioned(
        //     right: 8,
        //     child: GestureDetector(
        //       onTap: (int.parse(userCoin) >= 20)
        //           ? () async {
        //               setState(() {
        //                 videoButtonIs = false;
        //                 debugPrint("button is :- $videoButtonIs");
        //                 Future.delayed(const Duration(seconds: 5), () {
        //                   setState(() {
        //                     videoButtonIs = true;
        //                     debugPrint("button is :- $videoButtonIs");
        //                   });
        //                 });
        //               });
        //
        //               // await makeCallController.makeCall(
        //               //   callerId: loginUserId,
        //               //   receiverId: widget.hostId,
        //               //   videoCallType: "user",
        //               //   userImage: userImage,
        //               //   username: userName,
        //               //   matchName: widget.hostname,
        //               //   matchImage: widget.hostImage,
        //               //   statusType: 'live',
        //               // );
        //               Get.to(() => DemoCall(
        //                   receiverId: widget.hostId,
        //                   hostName: widget.hostname,
        //                   hostImage: widget.hostImage, callType: 'live',));
        //             }
        //           : () {
        //               Fluttertoast.showToast(
        //                 msg: "Insufficient Balance",
        //                 toastLength: Toast.LENGTH_SHORT,
        //                 gravity: ToastGravity.SNACKBAR,
        //                 backgroundColor: Colors.black.withOpacity(0.35),
        //                 textColor: Colors.white,
        //                 fontSize: 16.0,
        //               );
        //             },
        //       child: Container(
        //         alignment: Alignment.center,
        //         width: 50,
        //         height: 50,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: AppColors.blackColor.withOpacity(0.2),
        //         ),
        //         child: Container(
        //           alignment: Alignment.center,
        //           width: 33,
        //           height: 33,
        //           decoration: const BoxDecoration(
        //               shape: BoxShape.circle,
        //               image: DecorationImage(
        //                   image: AssetImage(AppIcons.videoCallIcon))),
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
