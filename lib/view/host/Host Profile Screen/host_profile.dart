import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/album/controller/album_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/delete_host_account_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/get_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/controller/withdraw_type_controller.dart';
import 'package:hokoo_flutter/Controller/Google_Login/google_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Profile%20Screen/host_edit_profile.dart';
import 'package:hokoo_flutter/view/user/screens/user_login_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'My_Complain_Ticket_Screen/host_complain_screen.dart';
import 'host_history_screen/host_history_screen.dart';
import 'host_more_image.dart';
import 'host_more_option/host_more_option.dart';
import 'host_withdrawal_screen.dart';
// todo
class HostProfile extends StatefulWidget {
  final String? message;
  final String? contact;

  const HostProfile({Key? key, this.message, this.contact}) : super(key: key);

  @override
  State<HostProfile> createState() => _HostProfileState();
}

class _HostProfileState extends State<HostProfile> {
  bool isVisible = true;

  ImagePicker picker = ImagePicker();

  File? hostProfileImage;

  AuthController authController = Get.put(AuthController());

  AlbumController albumController = Get.put(AlbumController());

  GetHostController getHostController = Get.put(GetHostController());

  WithdrawTypeController withdrawTypeController = Get.put(WithdrawTypeController());
  DeleteHostAccountController deleteHostAccountController = Get.put(DeleteHostAccountController());

  @override
  void initState() {
    super.initState();
    getHostController.getHost(loginUserId);
    hostCoin.value = getHostController.getHostData?.host?.coin.toString() ?? "0";

    withdrawTypeController.withdrawType();
    if (hostProfileList.isEmpty) {
      setState(() {
        isVisible = false;
      });
    } else {
      setState(() {
        isVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<HostProfileModel> hostLogin = [
      // HostProfileModel(
      //     color: const Color(0xffA057FE).withOpacity(0.2),
      //     onTap: () {
      //       Get.to(() => const HostHistoryScreen());
      //     },
      //     icon: AppImages.history,
      //     name: "Coin History"),
      HostProfileModel(
          color: AppColors.pinkColor.withOpacity(0.2),
          onTap: () {
            setState(() {
              switchComplain = true;
            });
            Get.to(
              () => const HostComplainScreen(),
            );
          },
          icon: AppImages.supportUs,
          name: "Complains"),
      HostProfileModel(
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
                  height: Get.height / 3.4,
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
                                width: 150,
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
                                authController.signOut();
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                preferences.clear();
                                preferences.setBool("isBottom", false);
                                isBottom = preferences.getBool("isBottom")!;
                                log('::::::{preferences.getString("userName")::${preferences.getString("userName")}');
                                log('::::::{preferences.getString("userBio")::${preferences.getString("userBio")}');
                                log(
                                    '::::::{preferences.getString("userImage")::${preferences.getString("userImage")}');
                                log('::::::{preferences.getString("uniqueId")::${preferences.getString("uniqueId")}');
                                log(
                                    '::::::{preferences.getString("getHostCoverImage")::${preferences.getString("getHostCoverImage")}');
                                Get.offAll(
                                  () => const UserLoginScreen(),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 150,
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
      HostProfileModel(
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

                                log(" loginuserId :: ${getHostController.getHostData?.host?.id.toString()}");
                                await deleteHostAccountController
                                    .deleteAccount(getHostController.getHostData?.host?.id.toString() ?? '');
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                preferences.setBool("isBottom", false);
                                preferences.setBool("isHost", false);
                                isBottom = preferences.getBool("isBottom")!;
                                isHost = preferences.getBool("false")!;
                                log("isbottom :: $isHost");

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
              fontSize: 22,
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
                  () => HostEditProfileScreen(
                    hostProfileImage: userImage,
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
            // const HostMoreOptionScreen(),
          ],
        ),
        body: Obx(() {
          if (getHostController.isLoading.value) {
            log("get host login :: ${getHostController.isLoading.value}");
            return Container(
              height: height,
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.appBackground),
                    fit: BoxFit.cover,
                  ),
                ),
            );
          } else {
            log("Enter Else");
            return Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            alignment: Alignment.center,
                            height: 110,
                            width: 110,
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
                              height: 105,
                              width: 105,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    userImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 26,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // InkWell(
                    //   highlightColor: Colors.transparent,
                    //   splashColor: Colors.transparent,
                    //   onTap: () {
                    //     Get.to(() => const HostWithdrawScreen());
                    //   },
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(horizontal: 20),
                    //     padding: const EdgeInsets.all(2),
                    //     height: height / 8.5,
                    //     width: width,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15),
                    //         gradient:
                    //             const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                    //           AppColors.pinkColor,
                    //           AppColors.transparentColor,
                    //           AppColors.transparentColor,
                    //           AppColors.transparentColor,
                    //           AppColors.pinkColor
                    //         ])),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           gradient: const LinearGradient(
                    //               begin: Alignment.centerLeft,
                    //               end: Alignment.centerRight,
                    //               colors: [
                    //                 Color(0xff1E1D1D),
                    //                 Color(0xff291F22),
                    //                 Color(0xff291F22),
                    //                 Color(0xff1E1D1D),
                    //                 Color(0xff332127),
                    //               ]),
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
                    //                           hostCoin.value,
                    //                           style: const TextStyle(
                    //                             color: AppColors.lightPinkColor,
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 22,
                    //                           ),
                    //                         ))
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "My Images",
                            style: TextStyle(
                              color: Color(0xffABABAB),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => HostMoreImage(
                                    getHostModel: getHostController.getHostData!,
                                  ),
                                );
                              },
                              child: const Text(
                                "More",
                                style: TextStyle(
                                  color: Color(0xffABABAB),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: 185,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(top: 15)),
                                  SizedBox(
                                    height: 160,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                                            await _getAlbumGallery();
                                            Fluttertoast.showToast(
                                              msg: "Please Wait",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black.withOpacity(0.35),
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                            await albumController.getAlbumData(loginUserId);
                                            await getHostController.getHost(loginUserId);
                                            hostCoin.value = getHostController.getHostData?.host?.coin.toString() ?? "0";

                                            setState(() {
                                              visibleHost = !visibleHost;
                                            });
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 150,
                                                width: 106,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: const Color(0xff474747),
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 30,
                                                    color: AppColors.pinkColor,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: getHostController.getHostData!.host!.album!.length,
                                                separatorBuilder: (context, index) {
                                                  return const SizedBox(
                                                    width: 10,
                                                  );
                                                },
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    height: 137,
                                                    width: 106,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color(0xff474747),
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(15),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          getHostController.getHostData!.host!.album![index],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    //       Get.to(() => const HostWithdrawScreen());
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
                    //       "Withdraw",
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: ListView.separated(
                        separatorBuilder: (context, i) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: hostLogin.length,
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
                                onTap: hostLogin[i].onTap,
                                leading: Container(
                                  alignment: Alignment.center,
                                  height: height / 19.5,
                                  width: width / 9.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: hostLogin[i].color,
                                  ),
                                  child: SizedBox(
                                    height: 25,
                                    child: Image.asset(
                                      hostLogin[i].icon,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  hostLogin[i].name,
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
            );
          }
        }),
      ),
    );
  }

  _getAlbumGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(
        () {
          hostAlbumImage = File(image.path);
          if (hostAlbumImage == null) {
          } else {
            setState(() {
              on = true;
            });
          }
          if (kDebugMode) {
            log("album Image Is  :- $hostAlbumImage");
          }
        },
      );
      // _cropImage();
    }
  }
}
