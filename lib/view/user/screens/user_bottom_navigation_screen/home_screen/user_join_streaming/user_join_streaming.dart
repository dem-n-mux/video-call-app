import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Controller/user_live_streaming_comment_profile_controller.dart';
import 'package:hokoo_flutter/Controller/video_call_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/comment_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/dummy_host_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/sticker_model.dart';
import 'package:hokoo_flutter/view/utils/settings/models/user_live_streaming_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

class UserJoinStreaming extends StatefulWidget {
  const UserJoinStreaming({
    Key? key,
  }) : super(key: key);

  @override
  State<UserJoinStreaming> createState() => _UserJoinStreamingState();
}

class _UserJoinStreamingState extends State<UserJoinStreaming> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  var userCommentList = List.filled(100, userLiveStreamingCommentList);
  bool userLiveStreamingShowSizeBox = false;
  bool userLiveStreamingIsRearCameraSelected = true;
  bool userLiveStreamingIsButtonDisabled = true;
  bool userLiveStreamingWillPop = true;
  int randomNumber = 0;
  Random random = Random();

  TextEditingController commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  VideoCallController videoCallController = Get.put(VideoCallController());

  bool showSizeBox = false;
  bool isRearCameraSelected = true;
  bool isButtonDisabled = true;
  bool willPop = true;
  FocusNode focusNode = FocusNode();
  bool emojiShowing = false;
  bool showColor = true;

  String dropdownValue1 = "x1";
  String dropdownValue = '';
  var items = [
    'x1',
    'x5',
    'x10',
    'x15',
    'x20',
    'x25',
    'x30',
    'x35',
    'x40',
    'x45',
    'x50',
  ];

  TextEditingController userLiveStreamingCommentController = TextEditingController();

  final ScrollController userLiveStreamingScrollController = ScrollController(keepScrollOffset: true, initialScrollOffset: 10);

  late VideoPlayerController _controller;

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

  void startCamera(CameraDescription cameraDescription) async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {});
  }

  void addItems() {
    hostCommentList.shuffle();
    if (!mounted) return;
    setState(() {
      demoStreamList.add(hostCommentList.first);
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      "assets/video/video_3.mp4",
    )..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
    // videoCallController.initializePlayer();
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
    startCamera(cameras[1]);
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      addItems();
    });
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      randomNumber = random.nextInt(450);
    });

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);

    super.initState();
  }

  animateToMaxMin(double max, double min, double direction, int seconds, ScrollController scrollController) {
    scrollController.animateTo(direction, duration: Duration(seconds: seconds), curve: Curves.linear);
  }

  UserLiveStreamingCommentProfile userLiveStreamingCommentProfile = Get.put(UserLiveStreamingCommentProfile());

  DummyHostModel data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
              _controller.pause();
              Get.offAll(() => const UserBottomNavigationScreen());
            }
            return false;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                VideoPlayer(_controller),
                Stack(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height,
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 190,
                        width: 190,
                        child: Image(
                          image: AssetImage(commentBlankImage.last),
                        ),
                      ),
                    ),
                    Container(
                      height: Get.height,
                      width: Get.width,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100, right: 85),
                        child: Text(dropdownValue,
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
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(3),
                                          height: SizeConfig.blockSizeVertical * 14,
                                          width: SizeConfig.blockSizeHorizontal * 28,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient:
                                                  LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
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
                                                image: DecorationImage(image: NetworkImage(data.personImage), fit: BoxFit.cover)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data.personName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: SizeConfig.blockSizeHorizontal * 5.8),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          "ID : ${data.iD}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5),
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
                                                  Text(data.age,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: SizeConfig.blockSizeHorizontal * 3))
                                                ],
                                              ),
                                            ),
                                            Text(
                                              data.country,
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
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // Get.to(() =>
                                                  //     UserCallingScreen(
                                                  //       matchImage:
                                                  //       data.personImage,
                                                  //       matchName:
                                                  //       data.personName,
                                                  //     ));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
                                                  height: SizeConfig.blockSizeVertical * 6,
                                                  width: SizeConfig.screenWidth * 0.53,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15), color: const Color(0xffF24A80)),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        AppIcons.videoCallIcon,
                                                        color: Colors.white,
                                                        width: SizeConfig.blockSizeHorizontal * 7,
                                                      ),
                                                      SizedBox(
                                                        width: SizeConfig.blockSizeHorizontal * 3,
                                                      ),
                                                      Text(
                                                        "Video Chat",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                                            fontWeight: FontWeight.w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // Get.to(() => UserChatScreen(
                                                  //   hostImage:
                                                  //   data.personImage,
                                                  //   hostName:
                                                  //   data.personName,
                                                  //   isOnline:
                                                  //   data.isOnline,
                                                  // ));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
                                                  height: SizeConfig.blockSizeVertical * 6,
                                                  width: SizeConfig.screenWidth * .35,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      border: Border.all(width: 1, color: Colors.grey),
                                                      color: const Color(0xff2A2A2A)),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Image.asset(
                                                        AppIcons.commentIcon,
                                                        color: Colors.white,
                                                        width: SizeConfig.blockSizeHorizontal * 6,
                                                      ),
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
                                  CircleAvatar(
                                    backgroundColor: AppColors.pinkColor,
                                    radius: 27,
                                    child: CircleAvatar(
                                      radius: 25,
                                      foregroundImage: NetworkImage(data.personImage),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.personName,
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
                                          const Text(
                                            "1753",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
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
                                    "$randomNumber",
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
                            GestureDetector(
                              onTap: () {
                                // videoCallController.videoPlayerController
                                //     .pause();
                                // videoCallController.chewieController!.pause();
                                _controller.pause();
                                Get.back();
                              },
                              child: const CircleAvatar(
                                  radius: 18,
                                  backgroundImage: AssetImage(
                                    AppImages.powerOff,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      commentSection(),
                      Focus(
                        child: Row(
                          children: [
                            Container(
                              height: 43,
                              width: Get.width / 1.5,
                              margin: const EdgeInsets.only(left: 10, top: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.black.withOpacity(0.40)),
                              child: TextFormField(
                                focusNode: focusNode,
                                autofocus: false,
                                autocorrect: false,
                                // keyboardType: TextInputType.multiline,
                                keyboardAppearance: Brightness.light,
                                cursorColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();
                                  showColor = true;
                                },
                                controller: commentController,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
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
                                                  user: userName,
                                                  image: userImage,
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
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Share.share("Hello MyVideoApp User");
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
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  dropdownValue = " ";
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
                                                ///
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
                                                      indicatorColor: AppColors.pinkColor,
                                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                                      labelColor: Colors.white,
                                                      indicatorSize: TabBarIndicatorSize.label,
                                                      controller: _tabController,
                                                      labelStyle: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      tabs: const [
                                                        Tab(
                                                          child: Text(
                                                            "Sticker",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Tab(
                                                          child: Text(
                                                            "Emoji",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Tab(
                                                          child: Text(
                                                            "Love",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                ///

                                                SingleChildScrollView(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  child: SizedBox(
                                                    height: 190,
                                                    child: TabBarView(
                                                      controller: _tabController,
                                                      children: [
                                                        sticker(),
                                                        emojis(),
                                                        loveSticker(),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                ///

                                                const SizedBox(
                                                  height: 15,
                                                ),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(
                                                        right: 20,
                                                      ),
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
                                                                    topLeft: Radius.circular(100),
                                                                    bottomLeft: Radius.circular(100)),
                                                              ),
                                                              alignment: Alignment.center,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top: 4),
                                                                child: DropdownButton(
                                                                  value: dropdownValue1,
                                                                  icon:
                                                                      const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                                                  elevation: 0,
                                                                  underline: Container(),
                                                                  dropdownColor: Colors.black,
                                                                  items: items.map((String items) {
                                                                    return DropdownMenuItem(
                                                                      value: items,
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                                                                        child: Text(
                                                                          items,
                                                                          style: const TextStyle(
                                                                            fontSize: 18,
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged: (String? newValue) {
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
                                                                  commentBlankImage.add(stickerList[
                                                                          userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                                      .image);
                                                                  commentBlankImage.removeRange(0, commentBlankImage.length - 1);
                                                                  Get.back();
                                                                } else if (userLiveStreamingCommentProfile.selectedTab == 2) {
                                                                  commentBlankImage.add(emojiList[
                                                                          userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                                      .image);
                                                                  commentBlankImage.removeRange(0, commentBlankImage.length - 1);
                                                                  Get.back();
                                                                } else if (userLiveStreamingCommentProfile.selectedTab == 3) {
                                                                  commentBlankImage.add(loveList[
                                                                          userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                                                      .image);
                                                                  commentBlankImage.removeRange(0, commentBlankImage.length - 1);
                                                                  Get.back();
                                                                }
                                                              });
                                                              await Future.delayed(const Duration(seconds: 2)).then((value) {
                                                                setState(() {
                                                                  dropdownValue = "";
                                                                  commentBlankImage.add(
                                                                    AppImages.flairImage,
                                                                  );
                                                                });
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: AppColors.pinkColor,
                                                                border: Border.all(color: AppColors.pinkColor, width: 1),
                                                                borderRadius: const BorderRadius.only(
                                                                    topRight: Radius.circular(100),
                                                                    bottomRight: Radius.circular(100)),
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

                            // Padding(
                            //   padding: const EdgeInsets.only(top: 20),
                            //   child: Container(
                            //     height: 42,
                            //     width: 42,
                            //     decoration: const BoxDecoration(
                            //         image: DecorationImage(
                            //             image: AssetImage(
                            //               AppImages.gift,
                            //             ),),),
                            //   ),
                            // ),

                            const SizedBox(
                              width: 10,
                            ),
                          ],
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
                      ),
                      (showSizeBox) ? const SizedBox(height: 280) : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
            padding: const EdgeInsets.only(bottom: 5),
            child: GestureDetector(
              onTap: () {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                } else {
                  // Get.bottomSheet(
                  //   shape: const OutlineInputBorder(
                  //       borderSide: BorderSide.none,
                  //       borderRadius: BorderRadius.only(
                  //           topRight: Radius.circular(20),
                  //           topLeft: Radius.circular(20))),
                  //   backgroundColor: const Color(0xff161622),
                  //   Container(
                  //     height: Get.height / 2.1,
                  //     decoration: const BoxDecoration(
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(20),
                  //         topRight: Radius.circular(20),
                  //       ),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 20, vertical: 15),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 "ID: ${demoStreamList[index].id}",
                  //                 style: const TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //               GestureDetector(
                  //                 onTap: () => Get.back(),
                  //                 child: const SizedBox(
                  //                   height: 20,
                  //                   width: 20,
                  //                   child: Icon(
                  //                     Icons.close,
                  //                     color: Color(0xffDCDCDC),
                  //                     size: 25,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Container(
                  //           height: 95,
                  //           width: 95,
                  //           decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               border: Border.all(
                  //                   color: AppColors.pinkColor, width: 2),
                  //               image: DecorationImage(
                  //                 fit: BoxFit.cover,
                  //                 image:
                  //                     NetworkImage(demoStreamList[index].image),
                  //               )),
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         Text(
                  //           demoStreamList[index].user,
                  //           style: const TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 19,
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               alignment: Alignment.center,
                  //               height: 25,
                  //               width: 110,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(5),
                  //                 color: const Color(0xff686872),
                  //               ),
                  //               child: Text(
                  //                 demoStreamList[index].country,
                  //                 style: const TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 16,
                  //                 ),
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 13,
                  //             ),
                  //             Container(
                  //               alignment: Alignment.center,
                  //               height: 25,
                  //               width: 60,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(5),
                  //                 color: const Color(0xff811DE7),
                  //               ),
                  //               child: Row(
                  //                 children: [
                  //                   const Icon(Icons.female,
                  //                       color: Colors.white),
                  //                   const SizedBox(
                  //                     width: 5,
                  //                   ),
                  //                   Text(
                  //                     demoStreamList[index].age,
                  //                     style: const TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 16,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         const SizedBox(
                  //           height: 15,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //             left: 20,
                  //             right: 20,
                  //           ),
                  //           child: Column(
                  //             children: [
                  //               Container(
                  //                 height: 70,
                  //                 width: MediaQuery.of(context).size.width,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(15),
                  //                   border: Border.all(
                  //                       color: const Color(0xff4A4A55),
                  //                       width: 1),
                  //                 ),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(
                  //                       left: 20, right: 20),
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Column(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: const [
                  //                           Text(
                  //                             "814",
                  //                             style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 17,
                  //                               fontWeight: FontWeight.w500,
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             height: 7,
                  //                           ),
                  //                           Text(
                  //                             "Followers",
                  //                             style: TextStyle(
                  //                               fontSize: 13,
                  //                               color: Color(0xff888894),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 40,
                  //                         child: VerticalDivider(
                  //                           color: Color(0xff3F3F4B),
                  //                         ),
                  //                       ),
                  //                       Column(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: const [
                  //                           Text(
                  //                             "44",
                  //                             style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 17,
                  //                               fontWeight: FontWeight.w500,
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             height: 7,
                  //                           ),
                  //                           Text(
                  //                             "Relites",
                  //                             style: TextStyle(
                  //                               fontSize: 13,
                  //                               color: Color(0xff888894),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 40,
                  //                         child: VerticalDivider(
                  //                           color: Color(0xff3F3F4B),
                  //                         ),
                  //                       ),
                  //                       Column(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: const [
                  //                           Text(
                  //                             "29",
                  //                             style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 17,
                  //                               fontWeight: FontWeight.w500,
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             height: 7,
                  //                           ),
                  //                           Text(
                  //                             "Posts",
                  //                             style: TextStyle(
                  //                               fontWeight: FontWeight.w400,
                  //                               fontSize: 13,
                  //                               color: Color(0xff888894),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           height: 15,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //             left: 20,
                  //             right: 20,
                  //           ),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               GetBuilder<UserLiveStreamingCommentProfile>(
                  //                 builder: (profileController) {
                  //                   return GestureDetector(
                  //                     onTap: () {
                  //                       profileController.changevalue();
                  //                     },
                  //                     child: (profileController
                  //                                 .followUnFollow ==
                  //                             true)
                  //                         ? Container(
                  //                             alignment: Alignment.center,
                  //                             height: 35,
                  //                             width: Get.width / 2.35,
                  //                             decoration: BoxDecoration(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(5),
                  //                               color: AppColors.pinkColor,
                  //                             ),
                  //                             child: (profileController
                  //                                         .indicater ==
                  //                                     false)
                  //                                 ? const Text(
                  //                                     "FOLLOW",
                  //                                     style: TextStyle(
                  //                                       color: Colors.white,
                  //                                       fontSize: 17,
                  //                                       fontWeight:
                  //                                           FontWeight.w600,
                  //                                     ),
                  //                                   )
                  //                                 : const SizedBox(
                  //                                     height: 20,
                  //                                     width: 20,
                  //                                     child:
                  //                                         CircularProgressIndicator(
                  //                                       color: Colors.white,
                  //                                       strokeWidth: 2,
                  //                                     ),
                  //                                   ),
                  //                           )
                  //                         : Container(
                  //                             alignment: Alignment.center,
                  //                             height: 35,
                  //                             width: Get.width / 2.35,
                  //                             decoration: BoxDecoration(
                  //                               color: AppColors.grey,
                  //                               borderRadius:
                  //                                   BorderRadius.circular(5),
                  //                             ),
                  //                             child: (profileController
                  //                                         .indicater ==
                  //                                     false)
                  //                                 ? const Text(
                  //                                     "UNFOLLOW",
                  //                                     style: TextStyle(
                  //                                       color: Colors.white,
                  //                                       fontSize: 17,
                  //                                       fontWeight:
                  //                                           FontWeight.w600,
                  //                                     ),
                  //                                   )
                  //                                 : const SizedBox(
                  //                                     height: 20,
                  //                                     width: 20,
                  //                                     child:
                  //                                         CircularProgressIndicator(
                  //                                       color: Colors.white,
                  //                                       strokeWidth: 2,
                  //                                     ),
                  //                                   ),
                  //                           ),
                  //                   );
                  //                 },
                  //               ),
                  //               const Spacer(),
                  //               Container(
                  //                 alignment: Alignment.center,
                  //                 height: 35,
                  //                 width: Get.width / 2.35,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(5),
                  //                   color: AppColors.pinkColor,
                  //                 ),
                  //                 child: const Text(
                  //                   "MESSAGE",
                  //                   style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontSize: 17,
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(0.40),
                    ),
                    child: Row(
                      children: [
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
                                maxWidth: Get.width / 1.2,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 40,
                                  bottom: 3,
                                ),
                                child: Text(
                                    softWrap: false,
                                    maxLines: 100,
                                    overflow: TextOverflow.ellipsis,
                                    demoStreamList[index].message,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      overflow: TextOverflow.ellipsis,
                                    )),
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
    );
  }

  List<Sticker> stickerList = [
    Sticker(image: AppImages.s1),
    Sticker(image: AppImages.s2),
    Sticker(image: AppImages.s3),
    Sticker(image: AppImages.s4),
    Sticker(image: AppImages.s5),
    Sticker(image: AppImages.s6),
    Sticker(image: AppImages.s7),
    Sticker(image: AppImages.s8),
  ];

  List<Love> loveList = [
    Love(
      image: AppImages.b1,
    ),
    Love(
      image: AppImages.b2,
    ),
    Love(
      image: AppImages.b3,
    ),
    Love(
      image: AppImages.b4,
    ),
    Love(
      image: AppImages.b5,
    ),
    Love(
      image: AppImages.b6,
    ),
    Love(
      image: AppImages.b7,
    ),
    Love(
      image: AppImages.b8,
    ),
    Love(
      image: AppImages.b9,
    ),
    Love(
      image: AppImages.b10,
    ),
    Love(
      image: AppImages.b11,
    ),
    Love(
      image: AppImages.b12,
    ),
    Love(
      image: AppImages.b13,
    ),
    Love(
      image: AppImages.b14,
    ),
    Love(
      image: AppImages.b15,
    ),
  ];

  List<UserLiveStreamingCommentEmoji> emojiList = [
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee1,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee2,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee3,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee4,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee5,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee6,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee7,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee8,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee9,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee10,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee11,
    ),
    UserLiveStreamingCommentEmoji(
      image: AppImages.ee12,
    ),
  ];

  GridView sticker() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 5, right: 5),
      shrinkWrap: true,
      itemCount: stickerList.length,
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
                userLiveStreamingCommentProfile.selectedGiftIndex.value = i;
                userLiveStreamingCommentProfile.selectedTab = 1;
              },
              child: Container(
                decoration: (userLiveStreamingCommentProfile.selectedGiftIndex.value == i)
                    ? BoxDecoration(
                        color: const Color(0xff1C1C2E),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                          image: AssetImage(stickerList[i].image),
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
                        const Text("50", style: TextStyle(fontSize: 12, color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  GridView emojis() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: emojiList.length,
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
                userLiveStreamingCommentProfile.selectedGiftIndex.value = i;
                userLiveStreamingCommentProfile.selectedTab = 2;
              },
              child: Container(
                decoration: (userLiveStreamingCommentProfile.selectedGiftIndex.value == i)
                    ? BoxDecoration(
                        color: const Color(0xff1C1C2E),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                          image: AssetImage(emojiList[i].image),
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
                        // Icon(
                        //   Icons.diamond,
                        //   color: Colors.yellow,
                        //   size: 15,
                        // ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text("50", style: TextStyle(fontSize: 12, color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  GridView loveSticker() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: loveList.length,
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
                userLiveStreamingCommentProfile.selectedGiftIndex.value = i;
                userLiveStreamingCommentProfile.selectedTab = 3;
              },
              child: Container(
                decoration: (userLiveStreamingCommentProfile.selectedGiftIndex.value == i)
                    ? BoxDecoration(
                        color: const Color(0xff1C1C2E),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                          image: AssetImage(loveList[i].image),
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
                        const Text("50", style: TextStyle(fontSize: 12, color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
