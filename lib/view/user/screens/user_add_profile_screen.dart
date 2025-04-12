// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/Api_Service/Fetch_Country/Global_Country/global_country_controller.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Controller/Google_Login/add_profile_controller.dart';
import 'package:hokoo_flutter/Controller/Google_Login/google_controller.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/progress_dialog.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_button.dart';
import 'package:numberpicker/numberpicker.dart';

class UserAddProfileScreen extends StatefulWidget {
  bool isGoogle;
  String? photoUrl;
  UserAddProfileScreen({Key? key, required this.isGoogle, this.photoUrl}) : super(key: key);

  @override
  State<UserAddProfileScreen> createState() => _UserAddProfileScreenState();
}

class _UserAddProfileScreenState extends State<UserAddProfileScreen> {
  AddProfileController addProfileController = Get.put(AddProfileController());
  GlobalCountryController globalCountryController = Get.put(GlobalCountryController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    globalCountryController.globalCountryForProfile("");
    countryProfile = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    log("Height is :: $height");
    log("Width is :: $width");

    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ProgressDialog(
          inAsyncCall: addProfileController.isLoading,
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: AppColors.appBarColor,
                automaticallyImplyLeading: false,
                elevation: 0,
                toolbarHeight: 65,
                centerTitle: true,
                title: Text(
                  "Fill Your Profile",
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                  ),
                )),
            // backgroundColor: AppColors.appBackgroundHeart,
            body: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.appBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<AddProfileController>(
                        builder: (controller) {
                          log("authController.user?.photoUrl${authController.user?.photoUrl}");
                          log("authController.user?.photoUrl${authController.user?.photoUrl}");
                          return Center(
                            child: Container(
                                height: 115,
                                width: 115,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: CachedNetworkImage(
                                  imageUrl: widget.isGoogle
                                      ? widget.photoUrl ?? ""
                                      : controller.selectedGender == 0
                                          ? "${Constant.BASE_URL}storage/male.png"
                                          : "${Constant.BASE_URL}storage/female.png",
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
                          );
                        },
                      ),

                      /// FOR  Pick Image

                      /*  GetBuilder<AddProfileController>(
                        builder: (controller) {
                          return GestureDetector(
                            onTap: () async {
                              controller.clickImage();
                            },
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    alignment: Alignment.center,
                                    height: 120,
                                    width: 120,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primaryPurple,
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )),
                                    child: getUserProfileImage == null
                                        ? Container(
                                            height: 115,
                                            width: 115,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      "${Constant.BASE_URL}storage/female.png",
                                                    ))),
                                          )
                                        : Container(
                                            height: 115,
                                            width: 115,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(getUserProfileImage!),
                                              ),
                                            ),
                                          ),
                                  ),
                                  const Text(
                                    "Change Photo",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: AppColors.lightPinkColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),*/
                      Text(
                        "Country",
                        style:
                            GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: 15),
                      ).paddingOnly(top: 20, bottom: 10),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            barrierColor: AppColors.appBarColor.withOpacity(0.8),
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setModelState) {
                                  return NotificationListener<OverscrollIndicatorNotification>(
                                    onNotification: (overscroll) {
                                      overscroll.disallowIndicator();
                                      return false;
                                    },
                                    child: DraggableScrollableSheet(
                                      expand: false,
                                      initialChildSize: 0.8,
                                      minChildSize: 0.8,
                                      maxChildSize: 0.8,
                                      builder: (BuildContext context, ScrollController scrollController) {
                                        return Container(
                                          height: Get.height,
                                          width: Get.width,
                                          decoration: const BoxDecoration(
                                              color: AppColors.appBarColor,
                                              image: DecorationImage(
                                                  image: AssetImage(AppImages.appBackground), fit: BoxFit.cover),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.symmetric(vertical: 20),
                                                height: 3.5,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: AppColors.textFormFiledColor),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Container(
                                                  height: 57,
                                                  padding: const EdgeInsets.only(
                                                    left: 15,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.textFormFiledColor,
                                                    borderRadius: BorderRadius.circular(14),
                                                  ),
                                                  child: GetBuilder<GlobalCountryController>(
                                                    id: "idSearch",
                                                    builder: (controller) {
                                                      return Center(
                                                        child: TextFormField(
                                                          onChanged: (value) async {
                                                            log("object.....$value");
                                                            controller.isLoading(true);

                                                            await controller.globalCountryForProfile(value);
                                                          },
                                                          // onEditingComplete: () {
                                                          //   controller.globalCountryForProfile(
                                                          //       controller.searchCountryController.text);
                                                          // },
                                                          textInputAction: TextInputAction.search,
                                                          cursorColor: AppColors.grey,
                                                          controller: controller.searchCountryController,
                                                          style: GoogleFonts.poppins(
                                                            decoration: TextDecoration.none,
                                                            color: AppColors.whiteColor,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          maxLines: 1,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(
                                                            prefixIcon: const Icon(Icons.search),
                                                            counterText: "",
                                                            border: InputBorder.none,
                                                            hintText: "Search your country",
                                                            hintStyle: GoogleFonts.poppins(
                                                                color: AppColors.grey,
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              GetBuilder<GlobalCountryController>(
                                                id: "idCountry",
                                                builder: (controller) {
                                                  return controller.isLoading.value
                                                      ? const CircularProgressIndicator()
                                                      : Expanded(
                                                          child: ListView.builder(
                                                            physics: const BouncingScrollPhysics(),
                                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                                            itemCount: controller.globalCountryData?.flag?.length,
                                                            itemBuilder: (BuildContext context, int index) {
                                                              return InkWell(
                                                                onTap: () async {
                                                                  setState(() {
                                                                    countryProfile = controller
                                                                            .globalCountryData?.flag?[index].name
                                                                            .toString() ??
                                                                        '';
                                                                  });
                                                                  controller.searchCountryController.clear();
                                                                  log("Country: $countryProfile");
                                                                  Get.back();
                                                                },
                                                                child: Container(
                                                                  height: 70,
                                                                  width: Get.width,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(16),
                                                                      border: Border.all(
                                                                          width: 0.6,
                                                                          color: AppColors.grey.withOpacity(0.25))),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        margin: const EdgeInsets.only(left: 16),
                                                                        height: 25,
                                                                        width: 40,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                        child: SvgPicture.network(
                                                                          controller
                                                                                  .globalCountryData?.flag?[index].flag
                                                                                  .toString() ??
                                                                              "",
                                                                          fit: BoxFit.cover,
                                                                          placeholderBuilder: (context) {
                                                                            return Image.asset(
                                                                              AppIcons.flag2,
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        controller.globalCountryData!.flag![index].name
                                                                                    .toString()
                                                                                    .length >
                                                                                30
                                                                            ? "${controller.globalCountryData?.flag?[index].name.toString().substring(0, 30)}..."
                                                                            : controller
                                                                                .globalCountryData!.flag![index].name
                                                                                .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            color: Colors.white, fontSize: 16),
                                                                      ).paddingOnly(left: 10),
                                                                    ],
                                                                  ),
                                                                ).paddingSymmetric(horizontal: 15, vertical: 4.5),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 57,
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.textFormFiledColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(countryProfile.isNotEmpty ? countryProfile : "Select your country",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.textFormFiledTxtColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.textFormFiledTxtColor,
                                size: 21,
                              ),
                            ],
                          ),

                          // child: Center(
                          //   child: TextFormField(
                          //     maxLength: 20,
                          //     onEditingComplete: () => FocusScope.of(context).nextFocus(),
                          //     textInputAction: TextInputAction.done,
                          //     cursorColor: AppColors.grey,
                          //     // controller: userNameController,
                          //     style: GoogleFonts.poppins(
                          //       decoration: TextDecoration.none,
                          //       color: AppColors.whiteColor,
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //     maxLines: 1,
                          //     decoration: InputDecoration(
                          //        counterText: "",
                          //       border: InputBorder.none,
                          //       hintText: "Select your country",
                          //       hintStyle:
                          //           GoogleFonts.poppins(color: AppColors.grey, fontSize: 15, fontWeight: FontWeight.w400),
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                      Text(
                        "Age",
                        style:
                            GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: 15),
                      ).paddingOnly(top: 20, bottom: 10),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            barrierColor: AppColors.appBarColor.withOpacity(0.8),
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setModelState) {
                                  return NotificationListener<OverscrollIndicatorNotification>(
                                    onNotification: (overscroll) {
                                      overscroll.disallowIndicator();
                                      return false;
                                    },
                                    child: DraggableScrollableSheet(
                                      expand: false,
                                      initialChildSize: 0.5,
                                      minChildSize: 0.5,
                                      maxChildSize: 0.5,
                                      builder: (BuildContext context, ScrollController scrollController) {
                                        return Container(
                                          height: Get.height,
                                          width: Get.width,
                                          decoration: const BoxDecoration(
                                              color: AppColors.whiteColor,
                                              image: DecorationImage(
                                                  image: AssetImage(AppImages.appBackground), fit: BoxFit.cover),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.symmetric(vertical: 20),
                                                height: 3.5,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10), color: Colors.white),
                                              ),
                                              Text(
                                                "Select your age",
                                                style: GoogleFonts.poppins(
                                                    color: AppColors.whiteColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ).paddingOnly(top: 20, bottom: 10),
                                              StatefulBuilder(
                                                builder:
                                                    (BuildContext context, void Function(void Function()) setState) {
                                                  return GetBuilder<AddProfileController>(
                                                    builder: (controller) {
                                                      return NumberPicker(
                                                        minValue: 18,
                                                        maxValue: 100,
                                                        infiniteLoop: true,
                                                        selectedTextStyle: GoogleFonts.poppins(
                                                            color: AppColors.pinkColor,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(color: AppColors.pinkColor)),
                                                        onChanged: (value) {
                                                          controller.onChangeAge(value);
                                                        },
                                                        value: controller.currentAge,
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            height: 55,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(30),
                                                              border: Border.all(color: AppColors.appBarColor),
                                                            ),
                                                            child: Text(
                                                              "Cancel",
                                                              style: GoogleFonts.poppins(
                                                                color: AppColors.lightPinkColor,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 18,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            height: 55,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(30),
                                                              color: AppColors.pinkColor,
                                                            ),
                                                            child: Text(
                                                              "Ok",
                                                              style: GoogleFonts.poppins(
                                                                color: AppColors.lightPinkColor,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 18,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ).paddingOnly(bottom: 20)
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 57,
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.textFormFiledColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetBuilder<AddProfileController>(
                                builder: (controller) {
                                  return Text(controller.currentAge.toString(),
                                      style: GoogleFonts.poppins(
                                        color: AppColors.textFormFiledTxtColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ));
                                },
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.textFormFiledTxtColor,
                                size: 21,
                              ).paddingOnly(right: 16),
                            ],
                          ),
                          /* child: GetBuilder<AddProfileController>(
                            builder: (controller) {
                              return Center(
                                child: TextFormField(
                                  maxLength: 3,
                                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                  textInputAction: TextInputAction.done,
                                  cursorColor: AppColors.grey,
                                  controller: controller.ageController,
                                  style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: AppColors.whiteColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: "Enter your age",
                                    hintStyle: GoogleFonts.poppins(
                                        color: AppColors.grey, fontSize: 15, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            },
                          ),*/
                        ),
                      ),
                      // SizedBox(height: 20),
                      Text(
                        "Gender",
                        style:
                            GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: 15),
                      ).paddingOnly(top: 20, bottom: 10),
                      GetBuilder<AddProfileController>(
                        builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.onChangedGender(0);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        alignment: Alignment.center,
                                        height: Get.width * 0.27,
                                        width: Get.width * 0.27,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white,
                                                AppColors.pinkColor,
                                                Colors.black,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: Get.width * 0.26,
                                          width: Get.width * 0.26,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: (controller.selectedGender == 0)
                                                  ? const LinearGradient(
                                                      colors: [
                                                        Colors.white,
                                                        AppColors.pinkColor,
                                                        Colors.black,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    )
                                                  : const LinearGradient(
                                                      colors: [
                                                        AppColors.appBarColor,
                                                        AppColors.appBarColor,
                                                        AppColors.appBarColor,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    )),
                                          child: Image.asset(
                                            AppImages.profileMale,
                                            width: 50,
                                            color: AppColors.whiteColor,
                                          ),
                                        )),
                                    Text(
                                      "Male",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: (controller.selectedGender == 0)
                                            ? AppColors.pinkColor
                                            : AppColors.lightPinkColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.onChangedGender(1);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        alignment: Alignment.center,
                                        height: Get.width * 0.27,
                                        width: Get.width * 0.27,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white,
                                                AppColors.pinkColor,
                                                Colors.black,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: Get.width * 0.26,
                                          width: Get.width * 0.26,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: (controller.selectedGender == 1)
                                                  ? const LinearGradient(
                                                      colors: [
                                                        Colors.white,
                                                        AppColors.pinkColor,
                                                        Colors.black,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    )
                                                  : const LinearGradient(
                                                      colors: [
                                                        AppColors.appBarColor,
                                                        AppColors.appBarColor,
                                                        AppColors.appBarColor,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    )),
                                          child: Image.asset(
                                            AppImages.profileFemale,
                                            width: 50,
                                            color: AppColors.whiteColor,
                                          ),
                                        )),
                                    Text(
                                      "Female",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: (controller.selectedGender == 1)
                                            ? AppColors.pinkColor
                                            : AppColors.lightPinkColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            extendBody: true,
            bottomNavigationBar: GetBuilder<AddProfileController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CommonButton(
                    text: "Save",
                    onTap: () {
                      widget.isGoogle ? controller.onClickSaveBtnForGoogle() : controller.onClickSaveBtnForQuick();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
