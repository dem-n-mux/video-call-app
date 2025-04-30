import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/Api_Service/Fetch_Country/Global_Country/global_country_controller.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/host_thumb_controller.dart';
import 'package:hokoo_flutter/Api_Service/gift/controller/create_gift_category_controller.dart';
import 'package:hokoo_flutter/Api_Service/story/controller/get_host_story_controller.dart';
import 'package:hokoo_flutter/Controller/carousal_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/pages/live_host_grid.dart';
import 'package:hokoo_flutter/view/user/pages/story_view_page.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/dummy_host_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/gradient_text.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import 'user_notification_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  CreateGiftCategoryController createGiftCategoryController = Get.put(CreateGiftCategoryController());
  // FetchBannerController fetchBannerController = Get.put(FetchBannerController());
  HostThumbController hostThumbController = Get.put(HostThumbController());
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());
  List<DummyHostModel> countryWiseUserList = [];
  PageController pageController = PageController(initialPage: 0);
  CarouselSliderController controller = CarouselSliderController();
  int initialIndex = 0;
  String selectedCountry = "Global";

  CarousalController carousalController = Get.put(CarousalController());
  GlobalCountryController globalCountryController = Get.put(GlobalCountryController());
  GetHostStoryController getHostStoryController = Get.put(GetHostStoryController());

  @override
  void initState() {
    hostThumbController.fetchHostThumb(country);
    getHostStoryController.getHostStory(loginUserId);
    createGiftCategoryController.createGift();
    globalCountryController.globalCountry("");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});

    super.initState();
  }

  Future _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    hostThumbController.fetchHostThumb(country);
    getHostStoryController.getHostStory(loginUserId);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), // 80
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: SizeConfig.blockSizeHorizontal * 14,
              leading: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 4,
                  ),
                  Image.asset(
                    AppIcons.appLogo,
                    height: 35,
                    width: 35,
                  ),
                ],
              ),
              title: GradientText(
                "Babble",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.blockSizeHorizontal * 7),
                gradient: const LinearGradient(colors: [AppColors.pinkColor, Color(0xff573777)]),
              ),
              actions: [
                // Padding(
                //   padding: const EdgeInsets.only(right: 13),
                //   child: GestureDetector(
                //     onTap: () {
                //       showModalBottomSheet(
                //         shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(25),
                //             topRight: Radius.circular(25),
                //           ),
                //         ),
                //         barrierColor: AppColors.appBarColor.withOpacity(0.8),
                //         context: context,
                //         isScrollControlled: true,
                //         builder: (_) {
                //           return StatefulBuilder(
                //             builder: (BuildContext context, StateSetter setModelState) {
                //               return NotificationListener<OverscrollIndicatorNotification>(
                //                 onNotification: (overscroll) {
                //                   overscroll.disallowIndicator();
                //                   return false;
                //                 },
                //                 child: DraggableScrollableSheet(
                //                   expand: false,
                //                   initialChildSize: 0.67,
                //                   minChildSize: 0.1,
                //                   maxChildSize: 0.9,
                //                   builder: (BuildContext context, ScrollController scrollController) {
                //                     return Container(
                //                       decoration: const BoxDecoration(
                //                           color: AppColors.scaffoldColor,
                //                           borderRadius: BorderRadius.only(
                //                               topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                //                       child: Column(
                //                         children: [
                //                           Container(
                //                             margin: const EdgeInsets.symmetric(vertical: 20),
                //                             height: 4.5,
                //                             width: 70,
                //                             decoration: BoxDecoration(
                //                                 borderRadius: BorderRadius.circular(10), color: Colors.white),
                //                           ),
                //                           Padding(
                //                             padding: const EdgeInsets.all(12.0),
                //                             child: Container(
                //                               height: 57,
                //                               padding: const EdgeInsets.only(
                //                                 left: 15,
                //                               ),
                //                               decoration: BoxDecoration(
                //                                 color: AppColors.textFormFiledColor,
                //                                 borderRadius: BorderRadius.circular(14),
                //                               ),
                //                               child: GetBuilder<GlobalCountryController>(
                //                                 id: "idSearch",
                //                                 builder: (controller) {
                //                                   return Center(
                //                                     child: TextFormField(
                //                                       onEditingComplete: () {
                //                                         controller
                //                                             .globalCountry(controller.searchCountryController.text);
                //                                       },
                //                                       // onChanged: (value) {
                //                                       //   controller.globalCountryForProfile(value);
                //                                       // },
                //                                       textInputAction: TextInputAction.search,
                //                                       cursorColor: AppColors.grey,
                //                                       controller: controller.searchCountryController,
                //                                       style: GoogleFonts.poppins(
                //                                         decoration: TextDecoration.none,
                //                                         color: AppColors.whiteColor,
                //                                         fontSize: 15,
                //                                         fontWeight: FontWeight.w500,
                //                                       ),
                //                                       maxLines: 1,
                //                                       keyboardType: TextInputType.text,
                //                                       decoration: InputDecoration(
                //                                         prefixIcon: const Icon(Icons.search),
                //                                         counterText: "",
                //                                         border: InputBorder.none,
                //                                         hintText: "Search your country",
                //                                         hintStyle: GoogleFonts.poppins(
                //                                             color: AppColors.grey,
                //                                             fontSize: 15,
                //                                             fontWeight: FontWeight.w400),
                //                                       ),
                //                                     ),
                //                                   );
                //                                 },
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             height: SizeConfig.blockSizeVertical * 52,
                //                             child: GetBuilder<GlobalCountryController>(
                //                               id: "idCountry",
                //                               builder: (controller) {
                //                                 return ListView.separated(
                //                                   physics: const ScrollPhysics(),
                //                                   itemCount: controller.globalCountryData!.flag!.length,
                //                                   itemBuilder: (BuildContext context, int index) {
                //                                     return Padding(
                //                                       padding: const EdgeInsets.only(bottom: 5, left: 20, top: 10),
                //                                       child: InkWell(
                //                                         onTap: () async {
                //                                           setState(() {
                //                                             country = controller.globalCountryData!.flag![index].name
                //                                                 .toString();
                //                                           });
                //                                           hostThumbController.fetchHostThumb(country);
                //                                           Get.back();
                //                                         },
                //                                         child: Row(
                //                                           children: [
                //                                             (controller.globalCountryData!.flag![index].name
                //                                                         .toString() ==
                //                                                     "Global")
                //                                                 ? Container(
                //                                                     margin: const EdgeInsets.only(left: 10),
                //                                                     height: 30,
                //                                                     width: 30,
                //                                                     decoration:
                //                                                         const BoxDecoration(shape: BoxShape.circle),
                //                                                     child: SvgPicture.network(
                //                                                       controller.globalCountryData!.flag![index].flag
                //                                                           .toString(),
                //                                                       fit: BoxFit.cover,
                //                                                     ),
                //                                                   )
                //                                                 : Container(
                //                                                     margin: const EdgeInsets.only(left: 5),
                //                                                     height: 25,
                //                                                     width: 40,
                //                                                     decoration: BoxDecoration(
                //                                                       borderRadius: BorderRadius.circular(3),
                //                                                     ),
                //                                                     child: SvgPicture.network(
                //                                                       controller.globalCountryData!.flag![index].flag
                //                                                           .toString(),
                //                                                       fit: BoxFit.cover,
                //                                                     ),
                //                                                   ),
                //                                             const SizedBox(
                //                                               width: 20,
                //                                             ),
                //                                             Text(
                //                                               controller.globalCountryData!.flag![index].name
                //                                                           .toString()
                //                                                           .length >
                //                                                       30
                //                                                   ? "${controller.globalCountryData!.flag![index].name.toString().substring(0, 30)}..."
                //                                                   : controller.globalCountryData!.flag![index].name
                //                                                       .toString(),
                //                                               style: const TextStyle(color: Colors.white, fontSize: 16),
                //                                             ),
                //                                           ],
                //                                         ),
                //                                       ),
                //                                     );
                //                                   },
                //                                   separatorBuilder: (BuildContext context, int index) {
                //                                     return Padding(
                //                                       padding: const EdgeInsets.only(
                //                                         left: 18,
                //                                         right: 25,
                //                                       ),
                //                                       child: Divider(
                //                                         color: AppColors.lightPinkColor.withOpacity(0.1),
                //                                         thickness: 1,
                //                                       ),
                //                                     );
                //                                   },
                //                                 );
                //                               },
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               );
                //             },
                //           );
                //         },
                //       );
                //     },
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.keyboard_arrow_down,
                //           color: AppColors.pinkColor,
                //           size: SizeConfig.blockSizeHorizontal * 7,
                //         ),
                //         Text(
                //           country,
                //           style: TextStyle(
                //               fontWeight: FontWeight.w600,
                //               fontSize: SizeConfig.blockSizeHorizontal * 4,
                //               color: AppColors.pinkColor),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Get.to(() => const UserNotificationScreen());
                //   },
                //   child: Image.asset(
                //     AppImages.noNotification,
                //     width: SizeConfig.blockSizeHorizontal * 10,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Obx(() {
          if (hostThumbController.isLoading.value) {
            return Shimmer.fromColors(
              period: const Duration(milliseconds: 1200),
              baseColor: Colors.grey.withOpacity(0.18),
              highlightColor: Colors.grey.shade700,
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.pinkColor, width: 2),
                              ),
                              child: Image.asset(
                                AppIcons.userSimmer,
                              ).paddingAll(14),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.redColor,
                              ),
                              height: 10,
                              width: 70,
                            )
                          ],
                        ).paddingOnly(left: 12);
                      },
                    ),
                  ).paddingOnly(bottom: 6),
                  const Divider(),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                      itemCount: 10,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: 12, childAspectRatio: 0.8, mainAxisSpacing: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColors.pinkColor.withOpacity(0.35), borderRadius: BorderRadius.circular(15)),
                          child: Image.asset(AppIcons.logoPlaceholder),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return NestedScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            if (getHostStoryController.hostStoryList.isNotEmpty) {
                              return SizedBox(
                                height: 100,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: getHostStoryController.hostStoryList.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      log("object::::::${getHostStoryController.hostStoryList.length}");
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              hostId = getHostStoryController.hostStoryList[index].id.toString();
                                              Get.to(() => StoryViewPage(
                                                    storyList: getHostStoryController.hostStoryList,
                                                    index: index,
                                                  ));
                                            },
                                            child: Container(
                                              height: 70,
                                              clipBehavior: Clip.antiAlias,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: AppColors.pinkColor, width: 2),
                                              ),
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      getHostStoryController.hostStoryList[index].hostImage.toString(),
                                                  errorWidget: (context, url, error) {
                                                    return Center(
                                                      child: Image.asset(
                                                        AppIcons.userPlaceholder,
                                                        width: 110,
                                                        height: 110,
                                                      ),
                                                    );
                                                  },
                                                  placeholder: (context, url) {
                                                    return Center(
                                                      child: Image.asset(
                                                        fit: BoxFit.cover,
                                                        AppIcons.userPlaceholder,
                                                        width: 110,
                                                        height: 110,
                                                      ),
                                                    );
                                                  },
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            getHostStoryController.hostStoryList[index].hostName.toString(),
                                            style: const TextStyle(color: AppColors.pinkColor, fontSize: 14),
                                          ),
                                        ],
                                      ).paddingOnly(left: 12);
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          const Divider()
                        ],
                      ),
                    ),
                  ];
                },
                body: RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: AppColors.pinkColor,
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    child: CustomScrollView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      slivers: [
                        // SliverToBoxAdapter(
                        //   child: Container(
                        //     height: 160,
                        //     width: 100,
                        //     clipBehavior: Clip.hardEdge,
                        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                        //     child: ScrollPageView(
                        //       controller: ScrollPageController(),
                        //       delay: const Duration(seconds: 5),
                        //       indicatorAlign: Alignment.bottomCenter,
                        //       indicatorColor: AppColors.grey,
                        //       indicatorPadding: const EdgeInsets.only(bottom: 5),
                        //       checkedIndicatorColor: AppColors.pinkColor,
                        //       children: fetchBannerController.bannersImages.asMap().entries.map((e) {
                        //         log("Banner images :: ${Constant.BASE_URL + e.value}");
                        //         return SizedBox(
                        //             height: 100,
                        //             width: 100,
                        //             child: CachedNetworkImage(
                        //               imageUrl: Constant.BASE_URL + e.value,
                        //               fit: BoxFit.cover,
                        //               filterQuality: FilterQuality.high,
                        //               progressIndicatorBuilder: (context, url, progress) =>
                        //                   const Center(child: CircularProgressIndicator()),
                        //               errorWidget: (context, url, error) {
                        //                 return Container(
                        //                   color: Colors.grey.withOpacity(0.3),
                        //                   child: Center(child: Icon(Icons.error)),
                        //                 );
                        //               },
                        //             ));
                        //       }).toList(),
                        //     ),
                        //   ).paddingSymmetric(horizontal: 10, vertical: 15),
                        // ),
                        Obx(() {
                          if (hostThumbController.hostThumbList.isEmpty) {
                            return SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  SizedBox(height: SizeConfig.blockSizeVertical * 15),
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
                              ),
                            );
                          } else {
                            return SliverPadding(
                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                                sliver: SliverGrid(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 0.8,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return OnlineHostGrid(
                                        hostData: hostThumbController.hostThumbList,
                                        index: index,
                                        createGiftCategoryModel: createGiftCategoryController.createGiftCategoryModel,
                                      );
                                    },
                                    childCount: hostThumbController.hostThumbList.length,
                                  ),
                                ));
                          }
                        })
                      ],
                    ),
                  ),
                ));
          }
        }),
      ),
    );
  }

  void animateToSlide(int index) => controller.animateToPage(index);
}
