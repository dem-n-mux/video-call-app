import 'dart:developer';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/controller/check_user_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_user_controller.dart';
import 'package:hokoo_flutter/Controller/Google_Login/google_controller.dart';
import 'package:hokoo_flutter/view/Host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_add_profile_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_login_button.dart';
import 'package:hokoo_flutter/view/utils/widgets/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController password = TextEditingController();
  FetchUserController fetchUserController = Get.put(FetchUserController());
  FetchHostController fetchHostController = Get.put(FetchHostController());
  AuthController authController = Get.put(AuthController());
  CheckUserController checkUserController = Get.put(CheckUserController());
  bool isLoading = false;
  @override
  void initState() {
    log("==============================================================");
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    [
      Permission.camera,
      Permission.microphone,
    ].request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (kDebugMode) {
      log("Build");
    }
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: ProgressDialog(
          inAsyncCall: isLoading,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            body: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.loginModel), fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Fluttertoast.showToast(
                        msg: "Please Wait...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.35),
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      await authController.signInWithGoogle();
                      if (authController.user != null) {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        preferences.setBool("isBottom", true);
                        isBottom = preferences.getBool('isBottom')!;
                        final user = authController.user;
                        await checkUserController.checkUser(user?.email ?? "");
                        if (checkUserController.checkUserModel?.status == true) {
                          if (checkUserController.checkUserModel?.isProfile == true) {
                            setState(() {
                              isLoading = false;
                            });
                            Get.off(() => UserAddProfileScreen(
                                  isGoogle: true,
                                  photoUrl: authController.user?.photoUrl ?? "",
                                ));
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            await fetchUserController.fetchUser(
                                1,
                                fcmToken,
                                androidId,
                                checkUserController.checkUserModel?.user?.email ?? "",
                                checkUserController.checkUserModel?.user?.country ?? '',
                                checkUserController.checkUserModel?.user?.image ?? "",
                                checkUserController.checkUserModel?.user?.name ?? "",
                                checkUserController.checkUserModel?.user?.age.toString() ?? "",
                                checkUserController.checkUserModel?.user?.gender ?? "");
                            if (fetchUserController.userData?.status ?? false) {
                              if (fetchUserController.userData?.user?.isHost == true) {
                                await fetchHostController.fetchHost(1, fcmToken, androidId, user?.email ?? "",
                                    fetchCountry["country"] ?? "", user?.displayName ?? "");
                                log("fetchHostController.hostData?.status found ::${fetchHostController.hostData?.status}");
                                log("fetchHostController.hostData?.status found ::${fetchHostController.hostData?.message}");
                                log("fetchHostController.hostData?.status found ::${fetchHostController.hostData?.host?.name}");
                                if (fetchHostController.hostData?.status == true) {
                                  preferences.setString(
                                      "userName", fetchHostController.hostData?.host?.name.toString() ?? "");
                                  preferences.setString(
                                      "userBio", fetchHostController.hostData?.host?.bio.toString() ?? "");
                                  preferences.setString(
                                      "userImage", fetchHostController.hostData?.host?.image.toString() ?? "");
                                  preferences.setString("getHostCoverImage",
                                      fetchHostController.hostData?.host?.coverImage.toString() ?? "");
                                  preferences.setBool("isLogin", true);
                                  preferences.setString(
                                      "loginUserId", fetchHostController.hostData?.host?.id.toString() ?? "");
                                  preferences.setString(
                                      "userGender", fetchHostController.hostData?.host?.gender.toString() ?? "");
                                  preferences.setString(
                                      "userCoin", fetchHostController.hostData?.host?.coin.toString() ?? "");
                                  userCoin.value = preferences.getString("userCoin") ?? '';
                                  userName = preferences.getString("userName") ?? "";
                                  userBio = preferences.getString("userBio") ?? "";
                                  userImage = preferences.getString("userImage") ?? "";
                                  hostCoverImage = preferences.getString("getHostCoverImage") ?? "";
                                  loginUserId = preferences.getString("loginUserId") ?? "";
                                  userGender = preferences.getString("userGender") ?? "";
                                  selectedIndex = 0;
                                  Get.off(() => const HostBottomNavigationBarScreen());

                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Fluttertoast.showToast(msg: fetchHostController.hostData?.message ?? "");
                                }
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                await fetchUserController.fetchUser(
                                    1,
                                    fcmToken,
                                    androidId,
                                    checkUserController.checkUserModel?.user?.email ?? "",
                                    checkUserController.checkUserModel?.user?.country ?? "",
                                    checkUserController.checkUserModel?.user?.image ?? "",
                                    checkUserController.checkUserModel?.user?.name ?? "",
                                    checkUserController.checkUserModel?.user?.age.toString() ?? "",
                                    checkUserController.checkUserModel?.user?.gender ?? "");
                                preferences.setString(
                                    "userName", fetchUserController.userData?.user?.name.toString() ?? "");
                                preferences.setString(
                                    "userBio", fetchUserController.userData?.user?.bio.toString() ?? "");
                                preferences.setString(
                                    "userImage", fetchUserController.userData?.user?.image.toString() ?? "");
                                preferences.setString(
                                    "loginUserId", fetchUserController.userData?.user?.id.toString() ?? "");
                                preferences.setBool("isLogin", true);
                                preferences.setString(
                                    "userGender", fetchUserController.userData?.user?.gender.toString() ?? "");
                                preferences.setString(
                                    "uniqueId", fetchUserController.userData?.user?.uniqueID.toString() ?? "");
                                preferences.setString(
                                    "userCoin", fetchUserController.userData?.user?.coin.toString() ?? "");
                                userCoin.value = preferences.getString("userCoin") ?? '';
                                userName = preferences.getString("userName") ?? '';
                                userBio = preferences.getString("userBio") ?? '';
                                userImage = preferences.getString("userImage") ?? '';
                                loginUserId = preferences.getString("loginUserId") ?? '';
                                userGender = preferences.getString("userGender") ?? '';
                                uniqueId = preferences.getString("uniqueId") ?? '';
                                selectedIndex = 0;
                                if (fetchUserController.userData?.status == true) {
                                  Get.off(() => const UserBottomNavigationScreen());
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Fluttertoast.showToast(msg: fetchUserController.userData?.message ?? "");
                                }
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(msg: fetchUserController.userData?.message ?? "");
                            }
                          }
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        log("+++++++++++");
                        const Text("User Not Found");
                      }

                      /// ============================= \\\
                      // await Fluttertoast.showToast(
                      //   msg: "Please Wait...",
                      //   toastLength: Toast.LENGTH_SHORT,
                      //   gravity: ToastGravity.BOTTOM,
                      //   timeInSecForIosWeb: 1,
                      //   backgroundColor: Colors.black.withOpacity(0.35),
                      //   textColor: Colors.white,
                      //   fontSize: 16.0,
                      // );
                      // SharedPreferences preferences = await SharedPreferences.getInstance();
                      // preferences.setBool("isBottom", true);
                      // isBottom = preferences.getBool('isBottom')!;
                      // if (isHost) {
                      //   await fetchHostController.fetchHost(0, fcmToken, androidId,
                      //       "Flirtzy@gmail.com", fetchCountry["country"]);
                      //   preferences.setString(
                      //       "userName", fetchHostController.hostData!.host!.name.toString());
                      //   preferences.setString(
                      //       "userBio", fetchHostController.hostData!.host!.bio.toString());
                      //   preferences.setString("userImage",
                      //       fetchHostController.hostData!.host!.image.toString());
                      //   preferences.setString("getHostCoverImage",
                      //       fetchHostController.hostData!.host!.coverImage.toString());
                      //   preferences.setString(
                      //       "loginUserId", fetchHostController.hostData!.host!.id.toString());
                      //   preferences.setString("userGender",
                      //       fetchHostController.hostData!.host!.gender.toString());
                      //   userName = preferences.getString("userName")!;
                      //   userBio = preferences.getString("userBio")!;
                      //   userImage = preferences.getString("userImage")!;
                      //   hostCoverImage = preferences.getString("getHostCoverImage")!;
                      //   loginUserId = preferences.getString("loginUserId")!;
                      //   userGender = preferences.getString("userGender")!;
                      //   selectedIndex = 0;
                      //   Get.off(() => const HostBottomNavigationBarScreen());
                      // } else {
                      //   await fetchUserController.fetchUser(
                      //       0,
                      //       fcmToken,
                      //       androidId,
                      //       "Flirtzy@gmail.com",
                      //       (fetchCountry.isEmpty) ? "India" : fetchCountry["country"]);
                      //   preferences.setString("getUserName",
                      //       fetchUserController.userData!.user!.name.toString());
                      //   preferences.setString(
                      //       "getUserBio", fetchUserController.userData!.user!.bio.toString());
                      //   preferences.setString("getUserImage",
                      //       fetchUserController.userData!.user!.image.toString());
                      //   preferences.setString(
                      //       "loginUserId", fetchUserController.userData!.user!.id.toString());
                      //   preferences.setString("userGender",
                      //       fetchUserController.userData!.user!.gender.toString());
                      //   userName = preferences.getString("getUserName")!;
                      //   userBio = preferences.getString("getUserBio")!;
                      //   userImage = preferences.getString("getUserImage")!;
                      //   loginUserId = preferences.getString("loginUserId")!;
                      //   userGender = preferences.getString("userGender")!;
                      //   selectedIndex = 0;
                      //   Get.off(() => const UserBottomNavigationScreen());
                      // }
                    },
                    child: const CommonLoginButton(
                      icon: AppIcons.googleIcon,
                      title: "Login with gmail",
                      padding: 8,
                    ),
                  ),
                  CommonLoginButton(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Fluttertoast.showToast(
                        msg: "Please Wait...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.35),
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setBool("isBottom", true);
                      isBottom = preferences.getBool('isBottom')!;
                      await checkUserController.checkUser(androidId);
                      if (checkUserController.checkUserModel?.status == true) {
                        setState(() {
                          isLoading = false;
                        });
                        if (checkUserController.checkUserModel?.isProfile == true) {
                          setState(() {
                            isLoading = false;
                          });
                          Get.off(() => UserAddProfileScreen(
                                isGoogle: false,
                              ));
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          await fetchUserController.fetchUser(
                              0,
                              fcmToken,
                              checkUserController.checkUserModel?.user?.identity ?? "",
                              checkUserController.checkUserModel?.user?.email ?? '',
                              checkUserController.checkUserModel?.user?.country ?? "",
                              checkUserController.checkUserModel?.user?.image ?? "",
                              checkUserController.checkUserModel?.user?.name ?? "",
                              checkUserController.checkUserModel?.user?.age.toString() ?? "",
                              checkUserController.checkUserModel?.user?.gender.toString() ?? "");

                          preferences.setString("loginUserId", fetchUserController.userData?.user?.id.toString() ?? "");
                          log("is host available :: ${fetchUserController.userData?.user?.isHost}");

                          if (fetchUserController.userData?.user?.isHost == true) {
                            await fetchHostController.fetchHost(
                                0, fcmToken, androidId, androidId, fetchCountry["country"] ?? "", "MyVideoApp User");
                            preferences.setString(
                                "userName", fetchHostController.hostData?.host?.name.toString() ?? "");
                            preferences.setString("userBio", fetchHostController.hostData?.host?.bio.toString() ?? "");
                            preferences.setString(
                                "userImage", fetchHostController.hostData?.host?.image.toString() ?? "");
                            preferences.setString(
                                "getHostCoverImage", fetchHostController.hostData?.host?.coverImage.toString() ?? "");
                            preferences.setBool("isLogin", true);
                            preferences.setString(
                                "loginUserId", fetchHostController.hostData?.host?.id.toString() ?? "");
                            preferences.setString(
                                "userGender", fetchHostController.hostData?.host?.gender.toString() ?? "");
                            preferences.setString(
                                "userCoin", fetchHostController.hostData?.host?.coin.toString() ?? "");
                            userCoin.value = preferences.getString("userCoin") ?? '';
                            userName = preferences.getString("userName") ?? '';
                            userBio = preferences.getString("userBio") ?? '';
                            userImage = preferences.getString("userImage") ?? '';
                            hostCoverImage = preferences.getString("getHostCoverImage") ?? '';
                            isLogin = preferences.getBool("isLogin") ?? false;
                            loginUserId = preferences.getString("loginUserId") ?? '';
                            userGender = preferences.getString("userGender") ?? '';
                            selectedIndex = 0;
                            log("userName:::::::>>>$userName");
                            log("userBio:::::::>>>$userBio");
                            log("userImage:::::::>>>$userImage");
                            log("hostCoverImage:::::::>>>$hostCoverImage");
                            log("isLogin:::::::>>>$isLogin");
                            log("loginUserId:::::::>>>$loginUserId");
                            log("userGender:::::::>>>$userGender");
                            log("userCoin.value::::::>${userCoin.value}");
                            log("isHost ::::$isHost");
                            Get.off(() => const HostBottomNavigationBarScreen());
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            await fetchUserController.fetchUser(
                                0,
                                fcmToken,
                                androidId,
                                androidId,
                                (fetchCountry.isEmpty) ? "India" : fetchCountry["country"],
                                "${Constant.BASE_URL}storage/female.png",
                                "MyVideoApp User",
                                "",
                                "");
                            preferences.setString(
                                "userName", fetchUserController.userData?.user?.name.toString() ?? "");
                            preferences.setString("userBio", fetchUserController.userData?.user?.bio.toString() ?? "");
                            preferences.setString(
                                "loginUserId", fetchUserController.userData?.user?.id.toString() ?? "");
                            preferences.setString(
                                "userImage", fetchUserController.userData?.user?.image.toString() ?? "");
                            preferences.setBool("isLogin", true);
                            preferences.setString(
                                "userGender", fetchUserController.userData?.user?.gender.toString() ?? "");
                            preferences.setString(
                                "uniqueId", fetchUserController.userData?.user?.uniqueID.toString() ?? "");
                            preferences.setString(
                                "userCoin", fetchUserController.userData?.user?.coin.toString() ?? "");
                            userCoin.value = preferences.getString("userCoin") ?? '';
                            userName = preferences.getString("userName") ?? "";
                            userBio = preferences.getString("userBio") ?? "";
                            userImage = preferences.getString("userImage") ?? "";
                            loginUserId = preferences.getString("loginUserId") ?? "";
                            isLogin = preferences.getBool("isLogin") ?? false;
                            userGender = preferences.getString("userGender") ?? "";
                            uniqueId = preferences.getString("uniqueId") ?? "";
                            log("userImage::::::::$userImage");
                            selectedIndex = 0;
                            Get.off(() => const UserBottomNavigationScreen());
                          }
                        }
                      }
                    },
                    icon: AppIcons.rocketIcon,
                    title: "Quick Login",
                    padding: 5,
                  ),


                  const Text(
                    "By Signing up you will be agree to our",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Terms & Condition",
                        style: TextStyle(color: AppColors.pinkColor, fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Text(
                        " and ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(color: AppColors.pinkColor, fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CommonLoginButton quickLogin(BuildContext context) {
    return CommonLoginButton(
      onTap: () async {
        await Fluttertoast.showToast(
          msg: "Please Wait...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black.withOpacity(0.35),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isBottom", true);
        isBottom = preferences.getBool('isBottom')!;

        await fetchUserController.fetchUser(
            0,
            fcmToken,
            androidId,
            androidId,
            (fetchCountry.isEmpty) ? "India" : fetchCountry["country"] ?? "",
            "${Constant.BASE_URL}storage/female.png",
            "MyVideoApp User",
            "",
            "");

        preferences.setString("loginUserId", fetchUserController.userData?.user?.id.toString() ?? "");

        if (fetchUserController.userData?.user?.isHost == true) {
          await fetchHostController.fetchHost(
              0, fcmToken, androidId, androidId, fetchCountry["country"] ?? "", "MyVideoApp User");
          preferences.setString("userName", fetchHostController.hostData?.host?.name.toString() ?? "");
          preferences.setString("userBio", fetchHostController.hostData?.host?.bio.toString() ?? "");
          preferences.setString("userImage", fetchHostController.hostData?.host?.image.toString() ?? "");
          preferences.setString("getHostCoverImage", fetchHostController.hostData?.host?.coverImage.toString() ?? "");
          preferences.setBool("isLogin", true);
          preferences.setString("loginUserId", fetchHostController.hostData?.host?.id.toString() ?? "");
          preferences.setString("userGender", fetchHostController.hostData?.host?.gender.toString() ?? "");
          preferences.setString("userCoin", fetchHostController.hostData?.host?.coin.toString() ?? "");
          userCoin.value = preferences.getString("userCoin") ?? '';
          userName = preferences.getString("userName") ?? '';
          userBio = preferences.getString("userBio") ?? '';
          userImage = preferences.getString("userImage") ?? '';
          hostCoverImage = preferences.getString("getHostCoverImage") ?? '';
          isLogin = preferences.getBool("isLogin") ?? false;
          loginUserId = preferences.getString("loginUserId") ?? '';
          userGender = preferences.getString("userGender") ?? '';
          selectedIndex = 0;
          log("userName:::::::>>>$userName");
          log("userBio:::::::>>>$userBio");
          log("userImage:::::::>>>$userImage");
          log("hostCoverImage:::::::>>>$hostCoverImage");
          log("isLogin:::::::>>>$isLogin");
          log("loginUserId:::::::>>>$loginUserId");
          log("userGender:::::::>>>$userGender");
          log("userCoin.value::::::>${userCoin.value}");
          log("isHost ::::$isHost");
          Get.off(() => const HostBottomNavigationBarScreen());
        } else {
          await fetchUserController.fetchUser(
              0,
              fcmToken,
              androidId,
              androidId,
              (fetchCountry.isEmpty) ? "India" : fetchCountry["country"],
              "${Constant.BASE_URL}storage/female.png",
              "MyVideoApp User",
              "",
              "");
          preferences.setString("userName", fetchUserController.userData?.user?.name.toString() ?? "");
          preferences.setString("userBio", fetchUserController.userData?.user?.bio.toString() ?? "");
          preferences.setString("loginUserId", fetchUserController.userData?.user?.id.toString() ?? "");
          preferences.setString("userImage", fetchUserController.userData?.user?.image.toString() ?? "");
          preferences.setBool("isLogin", true);
          preferences.setString("userGender", fetchUserController.userData?.user?.gender.toString() ?? "");
          preferences.setString("uniqueId", fetchUserController.userData?.user?.uniqueID.toString() ?? "");
          preferences.setString("userCoin", fetchUserController.userData?.user?.coin.toString() ?? "");
          userCoin.value = preferences.getString("userCoin") ?? '';
          userName = preferences.getString("userName") ?? "";
          userBio = preferences.getString("userBio") ?? "";
          userImage = preferences.getString("userImage") ?? "";
          loginUserId = preferences.getString("loginUserId") ?? "";
          isLogin = preferences.getBool("isLogin") ?? false;
          userGender = preferences.getString("userGender") ?? "";
          uniqueId = preferences.getString("uniqueId") ?? "";
          log("userImage::::::::$userImage");
          selectedIndex = 0;
          Get.off(() => const UserBottomNavigationScreen());
        }
      },
      icon: AppIcons.rocketIcon,
      title: "Quick Login",
      padding: 5,
    );
  }

 
}
