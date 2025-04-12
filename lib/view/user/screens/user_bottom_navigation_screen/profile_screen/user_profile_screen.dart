import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/delete_user_account_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_coin_plan_controller.dart';
import 'package:hokoo_flutter/Controller/Google_Login/google_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/profile_screen/user_history_screen/user_history_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_login_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'More_Option/user_more_option.dart';
import 'My_Complain_Ticket_Screen/user_complain_screen.dart';
import 'Recharge/recharge_coin_screen.dart';
import 'user_edit_profile.dart';
import 'user_host_request_screen.dart';
// todo
class UserProfileScreen extends StatefulWidget {
  final String? message;
  final String? contact;

  const UserProfileScreen({Key? key, this.message, this.contact}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  FetchCoinPlanController fetchCoinPlanController = Get.put(FetchCoinPlanController());
  DeleteUserAccountController deleteAccountController = Get.put(DeleteUserAccountController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<UserProfile> userLogin = [
      UserProfile(
          color: const Color(0xffFE8757).withOpacity(0.2),
          onTap: () {
            setState(() {
              isDisable = true;
            });
            Get.to(() => const UserHostRequestScreen());
          },
          icon: AppImages.hostCenter,
          name: "Host Center"),
      // UserProfile(
      //     color: const Color(0xffA057FE).withOpacity(0.2),
      //     onTap: () {
      //       Get.to(() => const UserHistoryScreen());
      //     },
      //     icon: AppImages.history,
      //     name: "Coin History"),
      UserProfile(
          color: AppColors.pinkColor.withOpacity(0.2),
          onTap: () {
            setState(() {
              switchComplain = true;
            });
            Get.to(
              () => const UserComplainScreen(),
            );
          },
          icon: AppImages.supportUs,
          name: "Complains"),
      UserProfile(
          color: const Color(0xff807BF4).withOpacity(0.2),
          icon: AppImages.switchUser,
          name: "Log Out",
          onTap: () {
            Get.bottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                backgroundColor: AppColors.appBarColor,
                SizedBox(
                  height: Get.height / 3.5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign out from MyVideoApp",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Are you sure you would like to sign out of your MyVideoApp account?",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 140,
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
                            GestureDetector(
                              onTap: () async {
                                await authController.signOut();
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                preferences.setBool("isBottom", false);
                                isBottom = preferences.getBool("isBottom")!;
                                preferences.clear();
                                log('preferences.getString("userName") :: ${preferences.getString("userName")}');
                                log('preferences.getString("userBio") :: ${preferences.getString("userBio")}');
                                log('preferences.getString("userImage") :: ${preferences.getString("userImage")}');
                                log('preferences.getString("uniqueId") :: ${preferences.getString("uniqueId")}');
                                log('preferences.getString("getHostCoverImage") :: ${preferences.getString("getHostCoverImage")}');

                                Get.offAll(
                                  () => const UserLoginScreen(),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: AppColors.pinkColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  "Sign out",
                                  style: TextStyle(
                                    color: AppColors.pinkColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ));
          }),
      UserProfile(
          color: AppColors.pinkColor.withOpacity(0.2),
          icon: AppImages.delete,
          name: "Delete Account",
          onTap: () {
            Get.bottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                backgroundColor: AppColors.appBarColor,
                SizedBox(
                  height: Get.height / 3.3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delete Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Are you sure you want to permanently delete your account? This action cannot be undone and will result in the loss of all your data and access to associated services.",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 140,
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
                            GestureDetector(
                              onTap: () async {
                                Get.dialog(const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.pink,
                                )));

                                await deleteAccountController.deleteAccount(loginUserId);
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                preferences.setBool("isBottom", false);
                                isBottom = preferences.getBool("isBottom")!;
                                preferences.clear();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: AppColors.pinkColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  "Delete Account",
                                  style: TextStyle(
                                    color: AppColors.pinkColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    ];

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          centerTitle: true,
          elevation: 0,
          leading: Container(),
          title: const Text(
            "Profile",
            style: TextStyle(
              color: AppColors.pinkColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isDisable = true;
                });
                Get.to(
                  () => UserEditProfileScreen(
                    userProfileImage: userImage,
                  ),
                );
              },
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 10, left: 10, top: 11, bottom: 11),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.transparentColor,
                    border: Border.all(color: AppColors.pinkColor, width: 1.1),
                  ),
                  child: Image.asset(
                    AppImages.edit,
                    fit: BoxFit.cover,
                    width: 28,
                    height: 28,
                  )),
            ),
            // const UserMoreOption(),
          ],
        ),
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.appBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  height: 125,
                  width: 125,
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
                    height: 115,
                    width: 115,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // image: DecorationImage(image: NetworkImage(userImage), fit: BoxFit.cover)
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: userImage,
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
                  height: 2,
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    color: AppColors.pinkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Id: $uniqueId",
                  style: const TextStyle(
                    color: Color(0xffABABAB),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // InkWell(
                //   onTap: () {
                //     Get.to(() => const RechargeCoinScreen());
                //   },
                //   highlightColor: Colors.transparent,
                //   splashColor: Colors.transparent,
                //   child: Container(
                //     margin: const EdgeInsets.symmetric(horizontal: 15),
                //     padding: const EdgeInsets.all(2),
                //     height: height / 8.5,
                //     width: width,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(15),
                //         gradient: const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                //           AppColors.pinkColor,
                //           AppColors.transparentColor,
                //           AppColors.transparentColor,
                //           AppColors.transparentColor,
                //           AppColors.pinkColor
                //         ])),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           gradient: const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                //             Color(0xff1E1D1D),
                //             Color(0xff291F22),
                //             Color(0xff291F22),
                //             Color(0xff1E1D1D),
                //             Color(0xff332127),
                //           ]),
                //           borderRadius: BorderRadius.circular(12)),
                //       width: Get.width,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               const Text(
                //                 "Balance",
                //                 style: TextStyle(
                //                   color: AppColors.pinkColor,
                //                   fontWeight: FontWeight.w700,
                //                   fontSize: 22,
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 50,
                //                 child: VerticalDivider(color: Colors.black, thickness: 1),
                //               ),
                //               SizedBox(
                //                 child: Row(
                //                   children: [
                //                     Image.asset(
                //                       AppImages.diamond,
                //                       height: 28,
                //                     ),
                //                     const SizedBox(
                //                       width: 5,
                //                     ),
                //                     Obx(() => Text(
                //                           userCoin.value,
                //                           style: const TextStyle(
                //                             color: AppColors.lightPinkColor,
                //                             fontWeight: FontWeight.bold,
                //                             fontSize: 22,
                //                           ),
                //                         )),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   height: height / 13,
                //   width: width,
                //   margin: const EdgeInsets.only(left: 15, right: 15),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       image: const DecorationImage(fit: BoxFit.fill, image: AssetImage(AppImages.rechargeBox))),
                //   child: ListTile(
                //     onTap: () {
                //       Get.to(() => const RechargeCoinScreen());
                //     },
                //     leading: Container(
                //       margin: const EdgeInsets.only(
                //         left: 5,
                //       ),
                //       height: 26,
                //       child: Image.asset(
                //         AppImages.singleCoin,
                //       ),
                //     ),
                //     title: const Text(
                //       "Recharge Coins",
                //       style: TextStyle(
                //         fontWeight: FontWeight.w500,
                //         fontSize: 18,
                //         color: Color(0xffFFC86C),
                //       ),
                //     ),
                //     trailing: const Icon(
                //       Icons.arrow_forward_ios_sharp,
                //       color: Color(0xffFFB842),
                //       size: 20,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  child: ListView.separated(
                    separatorBuilder: (context, i) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userLogin.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          alignment: Alignment.center,
                          height: height / 13,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade900,
                          ),
                          child: ListTile(
                            onTap: userLogin[i].onTap,
                            leading: Container(
                              alignment: Alignment.center,
                              height: height / 19.5,
                              width: width / 9.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: userLogin[i].color,
                              ),
                              child: SizedBox(height: 25, child: Image.asset(userLogin[i].icon)),
                            ),
                            title: Text(
                              userLogin[i].name,
                              style: const TextStyle(
                                color: AppColors.lightPinkColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 20,
                              color: AppColors.lightPinkColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
