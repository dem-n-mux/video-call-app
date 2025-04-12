import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/gift/controller/create_gift_category_controller.dart';
import 'package:hokoo_flutter/Api_Service/gift/controller/generate_gift_controller.dart';
import 'package:hokoo_flutter/Controller/user_live_streaming_comment_profile_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/comment_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/custom_report.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:video_player/video_player.dart';

class FakeLivePage extends StatefulWidget {
  final String videoUrl;
  final String name;
  final String coin;
  final String image;
  final String country;
  final String age;

  const FakeLivePage(
      {Key? key,
      required this.videoUrl,
      required this.name,
      required this.coin,
      required this.image,
      required this.country,
      required this.age})
      : super(key: key);

  @override
  State<FakeLivePage> createState() => _FakeLivePageState();
}

class _FakeLivePageState extends State<FakeLivePage> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  final ScrollController scrollController1 = ScrollController();
  TextEditingController commentTextController = TextEditingController();
  var dropdownValue = 0;
  var dropdownValue1 = 1;
  TabController? _tabController;
  GenerateGiftController generateGiftController = Get.put(GenerateGiftController());
  CreateGiftCategoryController createGiftCategoryController = Get.put(CreateGiftCategoryController());
  UserLiveStreamingCommentProfile userLiveStreamingCommentProfile = Get.put(UserLiveStreamingCommentProfile());
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
  void addItems() {
    hostCommentList1.shuffle();
    log("object::::  1${hostCommentList1.first.message}");
    if (mounted) {
      setState(() {
        demoStreamList1.add(hostCommentList1.first);
        scrollController1.animateTo(scrollController1.position.maxScrollExtent,
            duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
      });
    }
  }

  Timer? time;
  @override
  void initState() {
    // TODO: implement initState
    log("object::::initState");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await createGiftCategoryController.createGift();
      generateGiftController.generateGift(createGiftCategoryController.createGiftCategoryModel!.gift![0].id.toString());
      log("List tabbar leanth  :: ${createGiftCategoryController.createGiftCategoryModel!.gift!.length}");
      _tabController =
          TabController(length: createGiftCategoryController.createGiftCategoryModel!.gift!.length, vsync: this, initialIndex: 0);
    });
    time = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      log("object::::initState");
      addItems();
    });
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

    _controller.addListener(() {
      if (_controller.value.isInitialized && _controller.value.position == _controller.value.duration) {
        // Video has ended, seek back to the beginning for replay
        _controller.seekTo(Duration.zero);
        _controller.play(); // Start playing again
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    time?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: WillPopScope(
        onWillPop: () async {
          demoStreamList1.clear();
          // Get.offAll(UserBottomNavigationScreen());
          Get.back();
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
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : const Center(child: CircularProgressIndicator()),
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
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
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
                                      //             image: NetworkImage(widget.image), fit: BoxFit.cover)),
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
                                            imageUrl: widget.image,
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
                                        widget.name,
                                        style: GoogleFonts.poppins(
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
                                                Text(widget.age,
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: SizeConfig.blockSizeHorizontal * 3))
                                              ],
                                            ),
                                          ),
                                          Text(
                                            widget.country,
                                            style: GoogleFonts.poppins(
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
                                              onTap: () {},
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
                                                      color: AppColors.whiteColor,
                                                      width: SizeConfig.blockSizeHorizontal * 6,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      "Say Hi",
                                                      style: GoogleFonts.poppins(
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
                                      imageUrl: widget.image,
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
                                      widget.name,
                                      style: GoogleFonts.poppins(
                                        color: AppColors.whiteColor,
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
                                        Text(
                                          widget.coin,
                                          style: GoogleFonts.poppins(
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
                            child: Text(
                              "LIVE",
                              style: GoogleFonts.poppins(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
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
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.whiteColor.withOpacity(0.30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.visibility,
                                  color: AppColors.whiteColor,
                                  size: 20,
                                ),
                                Text(
                                  "12",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.whiteColor.withOpacity(0.30),
                                    ),
                                    child: const Icon(Icons.power_settings_new_rounded)),
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
              Positioned(
                bottom: 76,
                child: Container(
                  color: Colors.red,
                  margin: const EdgeInsets.only(left: 8),
                  height: 230,
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
                    child: SingleChildScrollView(
                      controller: scrollController1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        reverse: false,
                        physics: NeverScrollableScrollPhysics(),
                        controller: scrollController1,
                        itemCount: demoStreamList1.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (demoStreamList1.isEmpty) {
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
                                          // child: Container(
                                          //   alignment: Alignment.center,
                                          //   height: 30,
                                          //   width: 30,
                                          //   decoration: const BoxDecoration(
                                          //       shape: BoxShape.circle,
                                          //       gradient: LinearGradient(
                                          //         colors: [
                                          //           AppColors.pinkColor,
                                          //           AppColors.pinkColor,
                                          //           Colors.transparent,
                                          //         ],
                                          //         begin: Alignment.topLeft,
                                          //         end: Alignment.bottomRight,
                                          //       )),
                                          //   child: Container(
                                          //     width: 28,
                                          //     height: 28,
                                          //     decoration: BoxDecoration(
                                          //       shape: BoxShape.circle,
                                          //       image: DecorationImage(
                                          //           image: NetworkImage(demoStreamList1[index].image), fit: BoxFit.cover),
                                          //     ),
                                          //   ),
                                          // ),
                                          child: Container(
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
                                                width: 30,
                                                height: 30,
                                                imageUrl: demoStreamList1[index].image,
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
                                                demoStreamList1[index].user,
                                                style: const TextStyle(
                                                    color: AppColors.pinkColor, fontSize: 11, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: Get.width / 1.6,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 50,
                                                  bottom: 3,
                                                ),
                                                child: Text(
                                                  softWrap: false,
                                                  demoStreamList1[index].message,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                  ),
                                                  maxLines: 100,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildTextField(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
                  controller: commentTextController,
                  keyboardAppearance: Brightness.light,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20, bottom: 5),
                      border: InputBorder.none,
                      hintText: "Write Comment...",
                      hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.white,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (commentTextController.text.isNotEmpty) {
                            setState(() {
                              demoStreamList1.add(HostComment1(
                                message: commentTextController.text.toString(),
                                user: userName,
                                image: userImage,
                              ));
                            });
                            commentTextController.clear();
                          }
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
                      )),
                ),
              ),
            ),
            // const SizedBox(width: ,),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AbsorbPointer(
                  child: GestureDetector(
                    onTap: () {},
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
                                      overlayColor: WidgetStateProperty.all(Colors.transparent),
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
                                                              log("Gift sand on tap");
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
                                              // onTap: () async {
                                              //   setState(() {
                                              //     dropdownValue = dropdownValue1;
                                              //     if (userLiveStreamingCommentProfile.selectedTab == 1) {
                                              //       if (int.parse(userCoin.value) >=
                                              //           (generateGiftController
                                              //               .generateGiftModel!
                                              //               .gift![userLiveStreamingCommentProfile
                                              //               .selectedGiftIndex.value]
                                              //               .coin)! *
                                              //               dropdownValue) {
                                              //         liveSocket.emit("UserGift", {
                                              //           "coin": (generateGiftController
                                              //               .generateGiftModel!
                                              //               .gift![userLiveStreamingCommentProfile
                                              //               .selectedGiftIndex.value]
                                              //               .coin)! *
                                              //               dropdownValue,
                                              //           "countOfGift": "x$dropdownValue",
                                              //           "senderUserId": loginUserId,
                                              //           "receiverHostId": widget.hostId,
                                              //           "isshowGif": true,
                                              //           "gift": generateGiftController.generateGiftModel!.gift![
                                              //           userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                              //         });
                                              //         Get.back();
                                              //       } else {
                                              //         Fluttertoast.showToast(
                                              //           msg: "Insufficient Balance",
                                              //           toastLength: Toast.LENGTH_SHORT,
                                              //           gravity: ToastGravity.SNACKBAR,
                                              //           backgroundColor: Colors.black.withOpacity(0.35),
                                              //           textColor: Colors.white,
                                              //           fontSize: 16.0,
                                              //         );
                                              //         Get.back();
                                              //       }
                                              //     } else if (userLiveStreamingCommentProfile.selectedTab == 2) {
                                              //       if (int.parse(userCoin.value) >=
                                              //           (generateGiftController
                                              //               .generateGiftModel!
                                              //               .gift![userLiveStreamingCommentProfile
                                              //               .selectedGiftIndex.value]
                                              //               .coin)! *
                                              //               dropdownValue) {
                                              //         liveSocket.emit("UserGift", {
                                              //           "coin": (generateGiftController
                                              //               .generateGiftModel!
                                              //               .gift![userLiveStreamingCommentProfile
                                              //               .selectedGiftIndex.value]
                                              //               .coin)! *
                                              //               dropdownValue,
                                              //           "countOfGift": "x$dropdownValue",
                                              //           "senderUserId": loginUserId,
                                              //           "receiverHostId": widget.hostId,
                                              //           "isshowGif": true,
                                              //           "gift": generateGiftController.generateGiftModel!.gift![
                                              //           userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                              //         });
                                              //         Get.back();
                                              //       } else {
                                              //         Fluttertoast.showToast(
                                              //           msg: "Insufficient Balance",
                                              //           toastLength: Toast.LENGTH_SHORT,
                                              //           gravity: ToastGravity.SNACKBAR,
                                              //           backgroundColor: Colors.black.withOpacity(0.35),
                                              //           textColor: Colors.white,
                                              //           fontSize: 16.0,
                                              //         );
                                              //         Get.back();
                                              //       }
                                              //     } else if (userLiveStreamingCommentProfile.selectedTab == 3) {
                                              //       if (int.parse(userCoin.value) >=
                                              //           (generateGiftController
                                              //               .generateGiftModel!
                                              //               .gift![userLiveStreamingCommentProfile
                                              //               .selectedGiftIndex.value]
                                              //               .coin)! *
                                              //               dropdownValue) {
                                              //         liveSocket.emit("UserGift", {
                                              //           "coin": (generateGiftController
                                              //               .generateGiftModel!
                                              //               .gift![userLiveStreamingCommentProfile
                                              //               .selectedGiftIndex.value]
                                              //               .coin)! *
                                              //               dropdownValue,
                                              //           "countOfGift": "x$dropdownValue",
                                              //           "senderUserId": loginUserId,
                                              //           "receiverHostId": widget.hostId,
                                              //           "isshowGif": true,
                                              //           "gift": generateGiftController.generateGiftModel!.gift![
                                              //           userLiveStreamingCommentProfile.selectedGiftIndex.value]
                                              //         });
                                              //         Get.back();
                                              //       } else {
                                              //         Fluttertoast.showToast(
                                              //           msg: "Insufficient Balance",
                                              //           toastLength: Toast.LENGTH_SHORT,
                                              //           gravity: ToastGravity.SNACKBAR,
                                              //           backgroundColor: Colors.black.withOpacity(0.35),
                                              //           textColor: Colors.white,
                                              //           fontSize: 16.0,
                                              //         );
                                              //         Get.back();
                                              //       }
                                              //     }
                                              //   });
                                              // },
                                              onTap: () {},
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
            child: SizedBox(
              height: 270,
              child: EmojiPicker(
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
      ],
    );
  }

  Stack commentSection() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [],
    );
  }
}
