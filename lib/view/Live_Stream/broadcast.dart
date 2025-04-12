import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/sticker/sticker_controller.dart';
import 'package:hokoo_flutter/Controller/video_timer_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/host/Host%20Home%20Screen/Video%20Call/host_call_preview.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:lottie/lottie.dart';

// ignore:library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;

// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:hokoo_flutter/view/utils/settings/models/flair_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/flame_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_stream_button.dart';
import '../../Controller/host_streaming_controller.dart';
import '../utils/settings/models/comment_model.dart';

class Broadcast extends StatefulWidget {
  final String channelName;
  final String token;
  final String liveHostId;
  final String liveRoomId;
  final ClientRole clientRole;

  const Broadcast(
      {Key? key,
      required this.channelName,
      required this.token,
      required this.liveHostId,
      required this.liveRoomId,
      required this.clientRole})
      : super(key: key);

  @override
  State<Broadcast> createState() => _BroadcastState();
}

class _BroadcastState extends State<Broadcast> {
  bool showSizeBox = false;
  bool isRearCameraSelected = true;
  bool isButtonDisabled = true;
  bool willPop = true;
  FocusNode focusNode = FocusNode();
  bool emojiShowing = false;
  bool showColor = true;
  bool isMicClick = true;
  int randomNumber = 0;
  Random random = Random();
  int view = 0;
  String gift = "";
  String sticker = "";
  String emoji = "";
  String effect = "";
  String flameString = "";
  bool showGif = false;
  bool showEffect = false;
  bool showFlame = false;
  bool showSticker = false;
  final _users = <int>[];
  final infoString = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;
  String countValueIs = "";

  final ScrollController _scrollController = ScrollController();
  TextEditingController commentController = TextEditingController();
  StickerController stickerController = Get.put(StickerController());

  TimerDataController timerDataController = Get.put(TimerDataController());

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
    hostCommentList.shuffle();
    setState(() {
      demoStreamList.add(hostCommentList.first);
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  void initState() {
    stickerController.createSticker();
    connect();
    initialize();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
          showColor = true;
        });
      }
    });

    commentController.addListener(() {
      validateField(commentController.text);
    });
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      addItems();
    });
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      randomNumber = random.nextInt(450);
    });
    super.initState();
  }

  void connect() {
    var obj = json.encode({
      "liveHostRoom": widget.liveHostId,
      "liveRoom": widget.liveRoomId,
    }.map((key, value) => MapEntry(key, value.toString())));
    liveSocket = IO.io(Constant.BASE_URL, IO.OptionBuilder().setTransports(['websocket']).setQuery({"obj": obj}).build());
    liveSocket.connect();

    liveSocket.onConnect((data1) {
      debugPrint(" Socket Connected");
      liveSocket.on("view", (data) {
        List viewData = data;
        setState(() {
          view = viewData.length;
        });
      });
      liveSocket.on("comment", (data) {
        debugPrint("comment ========== $data");
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
      });
      liveSocket.on("gift", (data) {
        debugPrint("Host recive the GIFT :: $data");
        debugPrint(data[0]["gift"]["image"]);
        setState(() {
          userCoin.value = "${data[2]["coin"]}";
          gift = "${Constant.BASE_URL}${data[0]["gift"]["image"]}";
          showGif = data[0]["isshowGif"];
          countValueIs = data[0]["countOfGift"];
        });
        Future.delayed(const Duration(seconds: 3)).then((value) {
          setState(() {
            showGif = false;
            countValueIs = "";
          });
        });
      });

      liveSocket.on("sticker", (data) {
        debugPrint("Sticker Socket on +++++++++++++++ $data");
        sticker = "${Constant.BASE_URL}${data["sticker"]}";
        showSticker = data["isshowSticker"];
        debugPrint("sticker:$sticker");
        debugPrint("showSticker:$showSticker");
        Future.delayed(const Duration(seconds: 3)).then((value) {
          setState(() {
            showSticker = false;
          });
        });
      });

      liveSocket.on("effect", (data) {
        debugPrint("Effect Socket on +++++++++++++++ $data");
        effect = "${data["sticker"]}";
        showEffect = data["isshowSticker"];
        debugPrint("effect :- $effect");
        debugPrint("showEffect:- $showEffect");
      });

      liveSocket.on("fire", (data) {
        debugPrint("flame Socket on +++++++++++++++ $data");
        flameString = "${data["sticker"]}";
        showFlame = data["isshowSticker"];
        debugPrint("effect :- $flameString");
        debugPrint("showEffect:- $showFlame");
      });

      liveSocket.on("callRequest", (callReq) {
        debugPrint("callRequest Data for Live Streaming  ++++++++++++++++ $callReq");
        socket = IO.io(
          Constant.BASE_URL,
          IO.OptionBuilder().setTransports(['websocket']).setQuery({"callRoom": callReq["callId"]}).build(),
        );
        socket.connect();
        socket.onConnect((data) {
          debugPrint("Live Stream Call Room Create:......########");
          socket.emit("callConfirmed", callReq);
          socket.on("callConfirmed", (data) {
            debugPrint("callConfirmed :-  $data");
          });
          socket.on("callCancel", (data) {
            debugPrint("callCancel :-  $data");
            Get.back();
          });
        });
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: AppColors.appBarColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(3),
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                            Color(0xffE5477A),
                            Color(0xffE5477A),
                            Color(0xffE5477A),
                            Color(0xffE5477A),
                            AppColors.appBarColor,
                            AppColors.appBarColor,
                            AppColors.appBarColor,
                          ])),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage("${callReq["callerImage"]}"), fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("${callReq["callerName"]}", style: const TextStyle(color: AppColors.lightPinkColor, fontSize: 18)),
                    const SizedBox(height: 10),
                    const Text("Incoming Call...", style: TextStyle(color: AppColors.lightPinkColor, fontSize: 18)),
                    const SizedBox(height: 35),
                    Row(
                      children: [
                        GestureDetector(
                          child: Lottie.asset(
                            AppLottie.receiveCall,
                            width: 130,
                            height: 130,
                            repeat: true,
                            fit: BoxFit.fill,
                          ),
                          onTap: () async {
                            Map<String, dynamic> isAccept = {"accept": true};

                            Map<String, dynamic> result = {};
                            result.addAll(isAccept);
                            debugPrint("data:+++++++++++++++++++++++++++++++++++++++++++++++$callReq");
                            for (final entry in callReq.entries) {
                              result.putIfAbsent(entry.key, () => entry.value);
                            }

                            socket.emit("callAnswer", result);
                            liveSocket.disconnected;
                            liveSocket.dispose();
                            _engine.destroy();
                            _engine.leaveChannel();
                            await Get.off(() => VideoCallScreen(
                                  callType: callReq["live"],
                                  liveStatus: (callReq["live"] == "random") ? "random" : "private",
                                  matchName: 'demo',
                                  matchImage:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrB8e-SV99ORcO1Mg2NdQrDgtlvAFVpI4ooA&usqp=CAU',
                                  clientRole: ClientRole.Broadcaster,
                                  channelName: callReq["channel"],
                                  token: callReq["token"],
                                  callId: callReq["callId"],
                                  videoCallType: callReq["videoCallType"],
                                  hostId: hostId,
                                ));
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Lottie.asset(
                            AppLottie.endCall,
                            width: 130,
                            height: 130,
                            repeat: true,
                            fit: BoxFit.contain,
                          ),
                          onTap: () {
                            Map<String, dynamic> isAccept = {"accept": false};
                            Map<String, dynamic> result = {};
                            result.addAll(isAccept);
                            debugPrint(callReq);
                            for (final entry in callReq.entries) {
                              result.putIfAbsent(entry.key, () => entry.value);
                            }
                            socket.emit("callAnswer", result);
                            Get.back();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      });
    });
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    timerDataController.dispose();
    super.dispose();
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

  HostStreamingCommentController hostStreamingCommentController = Get.put(HostStreamingCommentController());

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.token);
    debugPrint(widget.channelName);
    var data = Get.arguments;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          showColor = true;
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
              liveSocket.disconnect();
              liveSocket.onDisconnect((data) {
                debugPrint("Socket Disconnected");
              });
              demoStreamList.clear();
              hostSelectedIndex = 0;
              Get.offAll(const HostBottomNavigationBarScreen());
            }
            return false;
          },
          child: Scaffold(
            floatingActionButton: buildTextField(context, data),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            // resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Stack(
                children: [
                  SizedBox(height: Get.height, width: Get.width, child: viewRows()),
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
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: Get.height,
                    width: Get.width,
                    child: Container(
                      color: (showColor) ? Colors.transparent : Colors.black,
                      height: 30,
                      width: Get.width,
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        opacity: 0.2,
                        image: AssetImage(flairImage.last),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        opacity: 0.2,
                        image: AssetImage(flameImage.last),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: Get.height / 2.5),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(heartImage.last),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: Get.height / 2.5),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(emojiImage.last),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 45),
                    height: Get.height,
                    width: Get.width,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          backgroundColor: AppColors.appBarColor,
                                          title: const Text(
                                            "Are you sure close the Live Streaming?",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    liveSocket.disconnect();
                                                    liveSocket.dispose();
                                                    demoStreamList.clear();
                                                    Get.offAll(() => const HostBottomNavigationBarScreen());
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
                                                      "Yes",
                                                      style: TextStyle(
                                                        color: AppColors.pinkColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 45,
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.pinkColor,
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    // flairImage.clear();
                                    // flameImage.clear();
                                    // heartImage.clear();
                                    // emojiImage.clear();
                                    // Get.off(() =>
                                    //     const HostBottomNavigationBarScreen());
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.pinkColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Image(
                                          image: AssetImage(
                                            AppIcons.coinsIcon,
                                          ),
                                          height: 20,
                                          width: 10,
                                          fit: BoxFit.cover),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Obx(() => Text(userCoin.value,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.transparentColor,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.access_time_filled,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Obx(
                                    () => Text(
                                      '${timerDataController.hours.toString().padLeft(2, '0')}:${timerDataController.minutes.toString().padLeft(2, '0')}:${timerDataController.seconds.toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: AppColors.pinkColor,
                                  ),
                                  child: Text(
                                    "Live",
                                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffD9D9D9).withOpacity(0.3), borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "$view",
                                        style:
                                            GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 320,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CommonStreamButton(
                                image: AppIcons.flairIcon,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setModelState) {
                                            return Container(
                                                height: 200,
                                                color: const Color(0xff383838),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 13, top: 10),
                                                          child: InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              child: const Icon(
                                                                Icons.close,
                                                                color: Colors.white,
                                                                size: 25,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    NotificationListener<OverscrollIndicatorNotification>(
                                                      onNotification: (overscroll) {
                                                        overscroll.disallowIndicator();
                                                        return false;
                                                      },
                                                      child: SingleChildScrollView(
                                                        child: SizedBox(
                                                          height: 150,
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: flair.length,
                                                            itemBuilder: (context, index) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: InkWell(
                                                                  onTap: () async {
                                                                    setState(() {
                                                                      liveSocket.emit(
                                                                        "effect",
                                                                        {
                                                                          "sticker": flair[index].image,
                                                                          "isshowSticker": true,
                                                                        },
                                                                      );
                                                                    });
                                                                    await Future.delayed(const Duration(seconds: 1))
                                                                        .then((value) {
                                                                      setState(() {
                                                                        Get.back();
                                                                      });
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    height: 80,
                                                                    width: 100,
                                                                    foregroundDecoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      image: DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image: AssetImage(flair[index].image),
                                                                      ),
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      image: const DecorationImage(
                                                                        fit: BoxFit.contain,
                                                                        image: NetworkImage(
                                                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0HqopGIt-hpWELyPbCfdlG1SN_XzhcuFbxg&usqp=CAU"),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                          },
                                        );
                                      });
                                },
                              ),
                              CommonStreamButton(
                                image: AppIcons.flamesIcon,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setModelState) {
                                            return Container(
                                                height: 200,
                                                color: const Color(0xff383838),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 13, top: 10),
                                                          child: InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              child: const Icon(
                                                                Icons.close,
                                                                color: Colors.white,
                                                                size: 25,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    NotificationListener<OverscrollIndicatorNotification>(
                                                      onNotification: (overscroll) {
                                                        overscroll.disallowIndicator();
                                                        return false;
                                                      },
                                                      child: SingleChildScrollView(
                                                        child: SizedBox(
                                                          height: 150,
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: flame.length,
                                                            itemBuilder: (context, index) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: InkWell(
                                                                  onTap: () async {
                                                                    setState(() {
                                                                      liveSocket.emit(
                                                                        "fire",
                                                                        {
                                                                          "sticker": flame[index].image,
                                                                          "isshowSticker": true,
                                                                        },
                                                                      );
                                                                    });
                                                                    await Future.delayed(const Duration(seconds: 1))
                                                                        .then((value) {
                                                                      setState(() {
                                                                        Get.back();
                                                                      });
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    height: 80,
                                                                    width: 100,
                                                                    foregroundDecoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      image: DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image: AssetImage(flame[index].image),
                                                                      ),
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      image: const DecorationImage(
                                                                        fit: BoxFit.contain,
                                                                        image: NetworkImage(
                                                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0HqopGIt-hpWELyPbCfdlG1SN_XzhcuFbxg&usqp=CAU"),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                          },
                                        );
                                      });
                                },
                              ),
                              CommonStreamButton(
                                image: AppIcons.heartWingIcon,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setModelState) {
                                            return Container(
                                                height: 200,
                                                color: const Color(0xff383838),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 13, top: 10),
                                                          child: InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              child: const Icon(
                                                                Icons.close,
                                                                color: Colors.white,
                                                                size: 25,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    NotificationListener<OverscrollIndicatorNotification>(
                                                      onNotification: (overscroll) {
                                                        overscroll.disallowIndicator();
                                                        return false;
                                                      },
                                                      child: SingleChildScrollView(
                                                        child: SizedBox(
                                                          height: 150,
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: stickerController.love.length,
                                                            itemBuilder: (context, index) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: InkWell(
                                                                  onTap: () async {
                                                                    setState(() {
                                                                      liveSocket.emit(
                                                                        "sticker",
                                                                        {
                                                                          "sticker": stickerController.love[index].sticker,
                                                                          "isshowSticker": true,
                                                                        },
                                                                      );
                                                                    });
                                                                    await Future.delayed(const Duration(seconds: 1))
                                                                        .then((value) {
                                                                      setState(() {
                                                                        Get.back();
                                                                      });
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    height: 80,
                                                                    width: 100,
                                                                    foregroundDecoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      image: DecorationImage(
                                                                        fit: BoxFit.contain,
                                                                        image: NetworkImage(
                                                                            "${Constant.BASE_URL}${stickerController.love[index].sticker.toString()}"),
                                                                      ),
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(15),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                          },
                                        );
                                      });
                                },
                              ),
                              CommonStreamButton(
                                image: AppIcons.smileyIcon,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setModelState) {
                                            return Container(
                                                height: 200,
                                                color: const Color(0xff383838),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 13, top: 10),
                                                          child: InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              child: const Icon(
                                                                Icons.close,
                                                                color: Colors.white,
                                                                size: 25,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    NotificationListener<OverscrollIndicatorNotification>(
                                                      onNotification: (overscroll) {
                                                        overscroll.disallowIndicator();
                                                        return false;
                                                      },
                                                      child: SingleChildScrollView(
                                                        child: SizedBox(
                                                          height: 150,
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: stickerController.emoji.length,
                                                            itemBuilder: (context, index) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: InkWell(
                                                                  onTap: () async {
                                                                    setState(() {
                                                                      liveSocket.emit(
                                                                        "sticker",
                                                                        {
                                                                          "sticker": stickerController.emoji[index].sticker,
                                                                          "isshowSticker": true,
                                                                        },
                                                                      );
                                                                    });
                                                                    await Future.delayed(const Duration(seconds: 1))
                                                                        .then((value) {
                                                                      setState(() {
                                                                        Get.back();
                                                                      });
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    height: 80,
                                                                    width: 100,
                                                                    foregroundDecoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      image: DecorationImage(
                                                                        fit: BoxFit.contain,
                                                                        image: NetworkImage(
                                                                            "${Constant.BASE_URL}${stickerController.emoji[index].sticker.toString()}"),
                                                                      ),
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(15),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                          },
                                        );
                                      });
                                },
                              ),
                              CommonStreamButton(
                                image: AppIcons.cameraIcon,
                                onTap: () {
                                  _engine.switchCamera();
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    muted = !muted;
                                  });
                                  _engine.muteLocalAudioStream(muted);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [AppColors.pinkColor, AppColors.pinkColor, Color(0xff5E6066)]),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xff5C6064).withOpacity(0.70),
                                        image: DecorationImage(
                                            image: (muted)
                                                ? const AssetImage(
                                                    AppIcons.micOffIs,
                                                  )
                                                : const AssetImage(
                                                    AppIcons.mic,
                                                  )),
                                      ),
                                    ),
                                  ),
                                ),
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
      ),
    );
  }

  Column buildTextField(BuildContext context, data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        commentSection(),
        Focus(
          child: Container(
            height: 45,
            width: Get.width,
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
                          "liveStreamingId": widget.liveRoomId,
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
                      //
                      //         demoStreamList.add(HostComment(
                      //           message: commentController.text,
                      //           user: "Mario",
                      //           image: AppImages.homeProfileModel1,
                      //           age: '23',
                      //           country: 'Russia',
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
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Offstage(
            offstage: !emojiShowing,
            child: SizedBox(
              height: 270,
              child: EmojiPicker(
                textEditingController: commentController,
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
          ),
        )
        // (showSizeBox)
        //     ? const SizedBox(height: 280)
        //     : const SizedBox(),
      ],
    );
  }

  Container commentSection() {
    return Container(
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
                                  style: const TextStyle(color: AppColors.pinkColor, fontSize: 11, fontWeight: FontWeight.bold),
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
                                    style: const TextStyle(color: Colors.white, fontSize: 13, overflow: TextOverflow.ellipsis),
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
    );
  }
}
