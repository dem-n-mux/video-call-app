import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Controller/host_streaming_controller.dart';
import 'package:hokoo_flutter/view/Host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/comment_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/emoji_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/flair_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/flame_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/heart_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_stream_button.dart';

// ignore:library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:agora_rtc_engine/rtc_engine.dart';

// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;

// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class StreamingThree extends StatefulWidget {
  final String liveHostId;
  final String liveRoomId;
  final ClientRole clientRole;
  final String channelName;
  final String token;

  const StreamingThree({
    Key? key,
    required this.liveHostId,
    required this.liveRoomId,
    required this.clientRole,
    required this.channelName,
    required this.token,
  }) : super(key: key);

  @override
  State<StreamingThree> createState() => _StreamingThreeState();
}

class _StreamingThreeState extends State<StreamingThree> {
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
  final users = <int>[];
  final infoString = <String>[];
  bool muted = false;
  bool viewPanel = false;

  final ScrollController _scrollController = ScrollController();
  TextEditingController commentController = TextEditingController();

  late IO.Socket liveSocket;

  late RtcEngine _engine;

  void connect() {
    var obj = json.encode({
      "liveHostRoom": widget.liveHostId,
      "liveRoom": widget.liveRoomId,
    }.map((key, value) => MapEntry(key, value.toString())));
    liveSocket = IO.io(Constant.BASE_URL, IO.OptionBuilder().setTransports(['websocket']).setQuery({"obj": obj}).build());
    liveSocket.connect();
    liveSocket.onConnect((data) {
      log(" Socket Connected" as num);
    });
  }

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

  HostStreamingCommentController hostStreamingCommentController = Get.put(HostStreamingCommentController());

  @override
  void initState() {
    initialize();
    connect();
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
    if (mounted) {
      Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        addItems();
      });
      Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        randomNumber = random.nextInt(450);
      });
    }
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

  Widget viewRows() {
    final List<StatefulWidget> list = [];
    if (widget.clientRole == ClientRole.Broadcaster) {
      list.add(const RtcLocalView.SurfaceView());
    }
    for (var uid in users) {
      list.add(RtcRemoteView.SurfaceView(uid: uid, channelId: widget.channelName));
    }
    final views = list;
    return Column(
      children: List.generate(views.length, (index) => Expanded(child: views[index])),
    );
  }

  void addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = "Error:$code";
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
        users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = "User Joined:$uid";
        infoString.add(info);
        users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        _engine.leaveChannel();
        // Get.offAll(()=>const BottomNavigationScreen(),);
        selectedIndex = 0;
        final info = "User Offlined:$uid";
        infoString.add(info);
        users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = "First Remote Video:$uid ${width}x$height";
        infoString.add(info);
      });
    }));
  }

  Widget toolBar() {
    if (widget.clientRole == ClientRole.Audience) return const SizedBox();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              setState(() {
                muted = !muted;
              });
              _engine.muteLocalAudioStream(muted);
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12),
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.destroy();
              Get.back();
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15),
            child: const Icon(
              Icons.call_end,
              size: 35,
              color: Colors.white,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.switch_camera,
              size: 20,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    users.clear();
    _engine.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(int.parse(widget.liveRoomId));
    log(int.parse(widget.liveHostId));
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
              Get.offAll(() => const HostBottomNavigationBarScreen());
            }
            return false;
          },
          child: Scaffold(
            floatingActionButton: Column(
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
                      color: AppColors.transparentColor,
                    ),
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
                              (isButtonDisabled)
                                  ? null
                                  : setState(() {
                                      demoStreamList.add(HostComment(
                                          message: commentController.text,
                                          user: data[0],
                                          image: data[1],
                                          age: '23',
                                          country: 'Russia',
                                          id: '00000010'));
                                      commentController.clear();
                                    });
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
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            // resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                SizedBox(height: Get.height, width: Get.width, child: viewRows()),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: Get.height,
                  width: Get.width,
                  child: Container(
                    color: (showColor) ? AppColors.transparentColor : Colors.black,
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
                  color: AppColors.transparentColor,
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
                                  liveSocket.disconnect();
                                  liveSocket.onDisconnect((data) {
                                    log("socket disconnect" as num);
                                  });
                                  flairImage.clear();
                                  flameImage.clear();
                                  heartImage.clear();
                                  emojiImage.clear();
                                  Get.off(() => const HostBottomNavigationBarScreen());
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.black12,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.pink,
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
                                    Text("1753",
                                        style:
                                            GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15))
                                  ],
                                ),
                              ),
                            ],
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
                                      "$randomNumber",
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
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
                                                                onTap: () {
                                                                  setState(() {
                                                                    flairImage.add(flair[index].image);
                                                                    flairImage.removeRange(0, flairImage.length - 1);
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
                                                                onTap: () {
                                                                  setState(() {
                                                                    flameImage.add(flame[index].image);
                                                                    flameImage.removeRange(0, flameImage.length - 1);
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
                                                          itemCount: heart.length,
                                                          itemBuilder: (context, index) {
                                                            return Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: InkWell(
                                                                onTap: () async {
                                                                  setState(() {
                                                                    heartImage.add(heart[index].image);
                                                                    heartImage.removeRange(0, heartImage.length - 1);
                                                                  });
                                                                  await Future.delayed(const Duration(seconds: 1)).then((value) {
                                                                    setState(() {
                                                                      heartImage.add(AppImages.flairImage);
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
                                                                      image: AssetImage(heart[index].image),
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
                                                          itemCount: emoji.length,
                                                          itemBuilder: (context, index) {
                                                            return Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: InkWell(
                                                                onTap: () async {
                                                                  setState(() {
                                                                    emojiImage.add(emoji[index].image);
                                                                    emojiImage.removeRange(0, emojiImage.length - 1);
                                                                  });
                                                                  await Future.delayed(const Duration(seconds: 1)).then((value) {
                                                                    setState(() {
                                                                      emojiImage.add(AppImages.flairImage);
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
                                                                      image: AssetImage(emoji[index].image),
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
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isMicClick = !isMicClick;
                                });
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
                                    ),
                                    child: (isMicClick == true)
                                        ? Image.asset(
                                            AppIcons.mic,
                                            fit: BoxFit.contain,
                                            height: 20,
                                            width: 20,
                                          )
                                        : Image.asset(
                                            AppIcons.micOffIs,
                                            fit: BoxFit.contain,
                                            width: 20,
                                            height: 20,
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
              color: AppColors.transparentColor,
            ),
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
                      (isButtonDisabled)
                          ? null
                          : setState(() {
                              demoStreamList.add(HostComment(
                                  message: commentController.text,
                                  user: data[0],
                                  image: data[1],
                                  age: '23',
                                  country: 'Russia',
                                  id: '00000010'));
                              commentController.clear();
                            });
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
            padding: const EdgeInsets.only(bottom: 5, right: 65),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black.withOpacity(0.1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
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
                              AppColors.transparentColor,
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
                          top: 5,
                        ),
                        child: Text(
                          demoStreamList[index].user,
                          style: const TextStyle(color: AppColors.pinkColor, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          bottom: 3,
                        ),
                        child: SizedBox(
                          width: 230,
                          child: Text(
                            demoStreamList[index].message,
                            style: const TextStyle(color: Colors.white, fontSize: 13, overflow: TextOverflow.ellipsis),
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget _broadcastView() {
  //   final views = _getRenderViews();
  //   switch (views.length) {
  //     case 1:
  //       return Column(
  //         children: <Widget>[
  //           _expandedVideoView([views[0]]),
  //           // _expandedVideoView([views[1]])
  //         ],
  //       );
  //
  //     case 2:
  //       return Column(
  //         children: <Widget>[
  //           _expandedVideoView([views[0]]),
  //           _expandedVideoView([views[1]])
  //         ],
  //       );
  //
  //     case 3:
  //       return Column(
  //         children: <Widget>[
  //           _expandedVideoView(views.sublist(0, 2)),
  //           _expandedVideoView(views.sublist(0, 2)),
  //         ],
  //       );
  //     case 4:
  //       return Column(
  //         children: <Widget>[
  //           _expandedVideoView(views.sublist(0, 2)),
  //           _expandedVideoView(views.sublist(0, 2)),
  //         ],
  //       );
  //     default:
  //       return const SizedBox();
  //   }
  // }

  // List<Widget> _getRenderViews() {
  //   final List<StatefulWidget> list = [];
  //   return list;
  // }

  // Widget _expandedVideoView(List<Widget> views) {
  //   final wrappedViews = views
  //       .map<Widget>((view) => Expanded(
  //               child: Container(
  //             child: view,
  //           )))
  //       .toList();
  //   return Expanded(
  //       child: Row(
  //     children: wrappedViews,
  //   ));
  // }
}
