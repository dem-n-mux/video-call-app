import 'dart:async';
import 'dart:developer';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/controller/get_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/setting_controller.dart';

import 'package:hokoo_flutter/Controller/video_timer_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';

// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;

// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:shared_preferences/shared_preferences.dart';

// ignore:library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../Api_Service/chat/controller/create_chat_room_controller.dart';
import '../../../../Controller/user_live_streaming_comment_profile_controller.dart';

class VideoCallScreen extends StatefulWidget {
  final String matchName;
  final String matchImage;
  final ClientRole clientRole;
  final String token;
  final String channelName;
  final String callId;
  final String videoCallType;
  final String? callType;
  final String? liveStatus;
  final String hostId;

  const VideoCallScreen({
    super.key,
    required this.matchName,
    required this.matchImage,
    required this.clientRole,
    required this.token,
    required this.channelName,
    required this.callId,
    this.callType,
    this.liveStatus,
    required this.videoCallType,
    required this.hostId,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> with SingleTickerProviderStateMixin {
  bool isVolume = true;
  final _users = <int>[];
  final infoString = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;
  int user = 0;
  int host = 1;
  var dropdownValue = 1;
  int dropdownValue1 = 1;

  // String dropdownValue = '';
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

  TimerDataController timerDataController = Get.put(TimerDataController());
  SettingController settingController = Get.put(SettingController());

  UserLiveStreamingCommentProfile userLiveStreamingCommentProfile = Get.put(UserLiveStreamingCommentProfile());
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());

  String gift = "";
  String countValueIs = "";
  bool showGif = false;
  double callRating = 4.0;
  Timer? timer;

  // Flag to prevent repeated checks and disconnections
  bool isCallDisconnected = false;

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    timerDataController.dispose();
    timer?.cancel(); // Cancel the timer to prevent further checks
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
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {},
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = "Join Channel:$channel,uid:$uid";
          infoString.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          log("::::::::::::::: Leave Channel3");
          infoString.add("Leave Channel");
          socket.emit("callDisconnect", {
            'callId': widget.callId,
          });
          isCallDisconnected = true;
          if (isHost) {
            log(":::::::::::::::Host Leave Channel");
            Get.put<GetHostController>(GetHostController()).getHost(loginUserId);
          }
          _engine.destroy();
          _users.clear();
          selectedIndex = 0;
          Get.back();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = "User Joined:$uid";
          infoString.add(info);
          _users.add(uid);
        });
      },
      userOffline: (uid, elapsed) {
        log("::::::::::::::: Leave Channel1:::::::::$isHost");
        setState(() {
          final info = "User Offline:$uid";
          infoString.add(info);
          infoString.add("Leave Channel user offline");
          socket.emit("callDisconnect", {
            'callId': widget.callId,
          });
          isCallDisconnected = true;
          if (isHost) {
            Get.put(GetHostController()).getHost(loginUserId);
          }
          _engine.destroy();
          _users.remove(uid);
          selectedIndex = 0;
          Get.back();
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = "First Remote Video:$uid ${width}x$height";
          infoString.add(info);
        });
      },
    ));
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
    log("VIEW'S LENGTH === ${views.length}");
    return Stack(
      children: [
        (views.length == 2) ? SizedBox(height: Get.height, width: Get.width, child: views[host]) : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (views.length == 2)
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        host = host == 0 ? 1 : 0;
                        user = user == 1 ? 0 : 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 180,
                        width: 140,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: views[user],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        host = host == 0 ? 1 : 0;
                        user = user == 1 ? 0 : 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 180,
                        width: 140,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            opacity: 0.4,
                            fit: BoxFit.cover,
                            image: NetworkImage(userImage),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  Future<void> checkUserCoinBalance() async {
    if (isCallDisconnected) return;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userCoins = int.parse(preferences.getString("userCoin") ?? '0');
    log('message:::checkUserCoinBalance:');
    log('message:::checkUserCoinBalance userCoins:$userCoins');
    int chargeForVideoCall = (widget.callType == "random") ? chargeForRandomCall : chargeForPrivateCall;
    if (userCoins < chargeForVideoCall) {
      // Insufficient coins, show toast and end the call
      Fluttertoast.showToast(
        msg: "User has insufficient coins to continue the call.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      // End the call
      setState(() {
        _engine.leaveChannel();
        _engine.destroy();
        _users.clear();
        timer?.cancel();
        socket.emit("callDisconnect", {
          'callId': widget.callId,
        });
        isCallDisconnected = true;
        Get.back();
      });
    }
  }

  /* void connect() {
    log(widget.callId);

    log("Video call Connect function called");

    socket = IO.io(
      Constant.BASE_URL,
      // "http://192.168.29.183:5000/",
      IO.OptionBuilder().setTransports(['websocket']).setQuery({"videoCallRoom": widget.callId}).build(),
    );
    socket.connect();
    socket.onConnect((data) async {
      log("Socket Connect:552::::::::::::$data");
      SharedPreferences preferences = await SharedPreferences.getInstance();

      if (widget.videoCallType == "user" && !(preferences.getBool("isHost") ?? false)) {
        log("widget.callType widget.callType :: ${widget.callType}");

        if (widget.callType == "random") {
          setState(() {
            if (socket.connected) {
              log("Socket is connected, emitting callReceive event first time");

              socket.emit("callReceive", {
                'callId': widget.callId,
                'callType': widget.callType,
                'coin': chargeForRandomCall,
                'live': (widget.liveStatus == "live") ? true : false,
              });

              log("Socket is connected, DFS");

              socket.on("callReceive", (data) async {
                log("Call Receive event listen successfully at random call first time :- $data");

                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.setString("userCoin", (data[0]["coin"]).toString());
                preferences.setString("hostCoin", (data[1]["coin"]).toString());
                userCoin.value = preferences.getString("userCoin")!;
                hostCoin.value = preferences.getString("hostcoin")!;
              });
            } else {
              log("Socket is not connected, emitting callRequest event");
            }
          });

          timer = Timer.periodic(const Duration(minutes: 1), (timer) {
            if (mounted && !isCallDisconnected) {
              checkUserCoinBalance(); // Check coin balance periodically
              setState(() {
                log("Socket is connected, emitting callReceive event Second time");
                socket.emit("callReceive", {
                  'callId': widget.callId,
                  'callType': widget.callType,
                  'coin': chargeForRandomCall,
                  'live': (widget.liveStatus == "live") ? true : false,
                });

                log("Call Receive event emit successfully after one minute");

                socket.on("callReceive", (data) async {
                  log("Call Receive event listen successfully after one minute Second time :- $data");

                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.setString("userCoin", (data[0]["coin"]).toString());
                  preferences.setString("hostCoin", (data[1]["coin"]).toString());
                  userCoin.value = preferences.getString("userCoin")!;
                  hostCoin.value = preferences.getString("hostCoin")!;
                });
              });
            }
          });
        } else {
          log("Enter in private call");
          log("Socket is connected, emitting callReceive event third time");
          socket.emit("callReceive", {
            'callId': widget.callId,
            'callType': widget.callType,
            'coin': chargeForPrivateCall,
            'live': (widget.liveStatus == "live") ? true : false,
          });
          log("Call receive event emit successfully");

          socket.on("callReceive", (data) async {
            log("callReceive event listen successfully Third time :- $data");
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setString("userCoin", (data[0]["coin"]).toString());
            preferences.setString("hostCoin", (data[1]["coin"]).toString());
            userCoin.value = preferences.getString("userCoin")!;
            hostCoin.value = preferences.getString("hostCoin")!;
          });

          timer = Timer.periodic(const Duration(minutes: 1), (timer) {
            if (!isCallDisconnected) {
              checkUserCoinBalance();
            }
            if (mounted && !isCallDisconnected) {
              log("Socket is connected, emitting callReceive event four time");
              socket.emit("callReceive", {
                'callId': widget.callId,
                'callType': widget.callType,
                'coin': chargeForPrivateCall,
                'live': (widget.liveStatus == "live") ? true : false,
              });
              setState(() {
                log("private Call :- ${widget.callType}");
                socket.on("callReceive", (data) async {
                  log("Call Receive event listen successfully at random call fourth time :- $data");
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.setString("userCoin", (data[0]["coin"]).toString());
                  preferences.setString("hostCoin", (data[1]["coin"]).toString());
                  userCoin.value = preferences.getString("userCoin")!;
                  hostCoin.value = preferences.getString("hostCoin")!;
                });
              });
            }
          });
          createChatRoomController.createChatRoom(loginUserId, widget.hostId);
        }
      } else if (widget.videoCallType == "host" && !(preferences.getBool("isHost") ?? false)) {
        if (mounted) {
          log("Socket is connected, emitting callReceive event five time");
          setState(() {
            socket.emit("callReceive", {
              'callId': widget.callId,
              'callType': widget.callType,
              'coin': chargeForPrivateCall,
              'live': (widget.liveStatus == "live") ? true : false,
            });
            log("Call Receive event emit successfully at random call");

            socket.on("callReceive", (data) async {
              log("Call Receive event listen successfully at random call :- $data");

              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.setString("userCoin", (data[0]["coin"]).toString());
              preferences.setString("hostCoin", (data[1]["coin"]).toString());
              userCoin.value = preferences.getString("userCoin")!;
              hostCoin.value = preferences.getString("hostcoin")!;
            });
          });
        }
        if (mounted) {
          timer = Timer.periodic(const Duration(minutes: 1), (timer) {
            if (!isCallDisconnected) {
              checkUserCoinBalance();
            }
            log("Socket is connected, emitting callReceive event six time");
            if (mounted && !isCallDisconnected) {
              setState(() {
                socket.emit("callReceive", {
                  'callId': widget.callId,
                  'callType': widget.callType,
                  'coin': chargeForPrivateCall,
                  'live': (widget.liveStatus == "live") ? true : false,
                });

                log("Call Receive event emit successfully after one minute");

                socket.on("callReceive", (data) async {
                  log("Call Receive event listen successfully after one minute");

                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.setString("userCoin", (data[0]["coin"]).toString());
                  preferences.setString("hostCoin", (data[1]["coin"]).toString());
                  userCoin.value = preferences.getString("userCoin")!;
                  hostCoin.value = preferences.getString("hostCoin")!;
                });
              });
            }
          });
        }
      }
    });
    socket.onDisconnect((data) {
      log("Socket Disconnect:::::::");
      timer?.cancel();
    });
  }*/
  void connect() {
    log(widget.callId);
    log("Video call Connect function called");

    socket = IO.io(
      Constant.BASE_URL,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({"videoCallRoom": widget.callId}).build(),
    );

    socket.connect();

    socket.onConnect((data) async {
      log("Socket connected successfully.");

      await Future.delayed(const Duration(seconds: 2));

      log("Call receive event called after 2 seconds");
      log("Call type is :: ${widget.callType}");

      await handleCallReceive();
      setupPeriodicCheck();
    });

    socket.onDisconnect((data) {
      log("Socket disconnected.");
      timer?.cancel();
    });
  }

  Future<void> handleCallReceive() async {
    log("Enter in handle call receive function");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isHost = preferences.getBool("isHost") ?? false;

    if (widget.videoCallType == "user" && !isHost) {
      log("Enter in if condition");

      if (widget.callType == "random") {
        log("Enter in nested if condition call type random");
        emitCallReceive(chargeForRandomCall);
      } else {
        log("Enter in nested if condition call type private");
        emitCallReceive(chargeForPrivateCall);
      }
    } else if (widget.videoCallType == "host" && !isHost) {
      log("Enter in else if condition");
      emitCallReceive(chargeForPrivateCall);
    }
  }

  void emitCallReceive(int coinCharge) {
    log("Emitting 'callReceive' event with charge: $coinCharge");
    socket.emit("callReceive", {
      'callId': widget.callId,
      'callType': widget.callType,
      'coin': coinCharge,
      'live': (widget.liveStatus == "live") ? true : false,
    });

    socket.on("callReceive", (data) async {
      log("callReceive event received with data: $data");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("userCoin", (data[0]["coin"]).toString());
      preferences.setString("hostCoin", (data[1]["coin"]).toString());
      userCoin.value = preferences.getString("userCoin")!;
      hostCoin.value = preferences.getString("hostCoin")!;
    });
  }

  void setupPeriodicCheck() {
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted && !isCallDisconnected) {
        checkUserCoinBalance();
        int coinCharge = (widget.callType == "random") ? chargeForRandomCall : chargeForPrivateCall;
        emitCallReceive(coinCharge);
      }
    });
  }

  @override
  void initState() {
    settingController.setting();
    initialize();
    connect();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: Stack(
                  children: [
                    viewRows(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15, top: 20),
                          height: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.transparentColor,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time_filled,
                                size: 18,
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Container(
                            height: 75,
                            width: Get.width / 1.2,
                            decoration: BoxDecoration(
                              color: AppColors.appBarColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox.shrink(),
                                GestureDetector(
                                  onTap: () async {
                                    log("::::::::::::::: Leave Channel2");
                                    setState(() {
                                      _engine.destroy();
                                      _engine.leaveChannel();

                                      log("Call Disconnected Id Is host call preview:- ${widget.callId}");
                                      log(":::::::::::::::Host Leave Channel");
                                      if (isHost) {
                                        Get.put<GetHostController>(GetHostController()).getHost(loginUserId);
                                      }
                                      timer?.cancel();
                                      socket.emit("callDisconnect", {
                                        "callId": widget.callId,
                                      });
                                      isCallDisconnected = true;
                                      selectedIndex = 0;
                                      Get.back();
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.redColor,
                                    ),
                                    child: const Icon(Icons.call_end_outlined, color: Colors.white, size: 25),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      _engine.switchCamera();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.flipCameraColor,
                                        ),
                                        child: const ImageIcon(
                                          AssetImage(AppImages.flipCamera),
                                          color: Colors.white,
                                          size: 30,
                                        ))),
                                GestureDetector(
                                  onTap: () {
                                    log("On Tap Mic on and Off");
                                    setState(() {
                                      muted = !muted;
                                    });
                                    _engine.muteLocalAudioStream(muted);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.flipCameraColor,
                                    ),
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: (muted)
                                                ? const AssetImage(
                                                    AppIcons.micOff,
                                                  )
                                                : const AssetImage(
                                                    AppIcons.micOn,
                                                  )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).paddingOnly(bottom: 50),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
