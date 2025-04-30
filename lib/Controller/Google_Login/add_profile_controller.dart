import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_user_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/update_user_controller.dart';
import 'package:hokoo_flutter/Controller/Google_Login/google_controller.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProfileController extends GetxController {
  int currentIndex = 0;
  int currentAge = 18;
  dynamic userImagePicker;
  dynamic userType;
  bool isLoading = false;
  int selectedGender = 0;

  //-----Country--------
  String? selectedBirthCountry;
  String? birthCountry;
  String? birthCountry1;
  String? gender;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  DateTime dateOfBirth = DateTime.now();

  final PageController pageController = PageController(initialPage: 0, keepPage: true);
  UpdateUserController updateUserController = Get.put(UpdateUserController());
  FetchUserController fetchUserController = Get.put(FetchUserController());
  FetchHostController fetchHostController = Get.put(FetchHostController());
  AuthController authController = Get.put(AuthController());

  // TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    userImagePicker = ImagePicker();
    super.onInit();
  }

  /// ------------------->>>> for a get live location
  String? deviceCurrentCountry;
  onChangeAge(int value) {
    currentAge = value;

    log("_currentIntValue$currentAge ");
    log("vaule$value ");
    update();
  }

  Future<void> startDatePicket(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateOfBirth,
        helpText: "Select Date of Birth",
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.redColor,
                onPrimary: Colors.white,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.black,
            ),
            child: child!,
          );
        },
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (picked != null && picked != dateOfBirth) {
      dateOfBirth = picked;
      log(dateOfBirth.toString());
      update();
    }
  }

  clickImage() async {
    var source = userType == ImageSourceType.camera ? ImageSource.camera : ImageSource.gallery;
    XFile userImage =
        await userImagePicker.pickImage(source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
    getUserProfileImage = File(userImage.path);
    if (getUserProfileImage == null) {
    } else {
      on = true;
    }
    update();
  }

  onChangedGender(int value) {
    selectedGender = value;
    update();
    log(selectedGender.toString());
  }

  onChangedBirthCountry(String? value) {
    selectedBirthCountry = value.toString();
    update();
    log(selectedBirthCountry.toString());
  }

  onClickSaveBtnForGoogle() async {
    await Fluttertoast.showToast(
      msg: "Please Wait...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.35),
      textColor: Colors.white,
      fontSize: 16.0,
    );

    isDisable = false;
    update();
    if (countryProfile.isEmpty) {
      await Fluttertoast.showToast(
        msg: "Please selected country",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.35),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      final user = authController.user;
      if (user != null) {
        log("Authcontoller found :: $user");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isBottom", true);
        isBottom = preferences.getBool('isBottom')!;
        await fetchUserController.fetchUser(
          1,
          fcmToken,
          androidId,
          authController.user?.email ?? "",
          countryProfile,
          getUserProfileImage != null ? getUserProfileImage!.path : authController.user?.photoUrl ?? "",
          authController.user?.displayName ?? "",
          currentAge.toString(),
          selectedGender == 0 ? "Male" : "Female",
        );
        preferences.setString("userEmail", user.email);
        if (fetchUserController.userData?.status ?? false) {
          /// Is host ture
          if (fetchUserController.userData?.user?.isHost == true) {
            log("Get is host true");
            await fetchHostController.fetchHost(
                1, fcmToken, androidId, user.email, fetchCountry["country"] ?? "", user.displayName ?? '');
            //------------------------
            preferences.setBool("hostIsBlock", fetchHostController.hostData?.host?.isBlock ?? false);
            preferences.setBool("isHost", fetchHostController.hostData?.host?.isHost ?? false);
            preferences.setBool("isLogin", true);
            preferences.setString("userName", fetchHostController.hostData?.host?.name.toString() ?? '');
            preferences.setString("userCoin", fetchHostController.hostData?.host?.coin.toString() ?? '');
            preferences.setString("userImage", fetchHostController.hostData?.host?.image.toString() ?? "");
            preferences.setString("getHostCoverImage", fetchHostController.hostData?.host?.coverImage.toString() ?? '');
            preferences.setString("userBio", fetchHostController.hostData?.host?.bio.toString() ?? '');
            preferences.setString("userGender", fetchHostController.hostData?.host?.gender.toString() ?? '');
            preferences.setString("loginUserId", fetchHostController.hostData?.host?.id.toString() ?? "");
            preferences.setString("uniqueID", fetchHostController.hostData?.host?.uniqueID ?? "");
            //----------------------------
            isHost = preferences.getBool("isHost") ?? false;
            hostIsBlock = preferences.getBool("hostIsBlock") ?? false;
            userName = preferences.getString("userName") ?? "";
            userCoin.value = preferences.getString("userCoin") ?? "";
            userImage = preferences.getString("userImage") ?? "";
            hostCoverImage = preferences.getString("getHostCoverImage") ?? "";
            userBio = preferences.getString("userBio") ?? "";
            uniqueId = preferences.getString("uniqueID") ?? "";
            userGender = preferences.getString("userGender") ?? "";
            loginUserId = preferences.getString("loginUserId") ?? "";
            //--------------------
            selectedIndex = 0;
            Get.off(() => const HostBottomNavigationBarScreen());
          } else {
            preferences.setBool("isLogin", true);
            preferences.setString("getUserName", fetchUserController.userData?.user?.name.toString() ?? "");
            preferences.setString("getUserBio", fetchUserController.userData?.user?.bio.toString() ?? "");
            preferences.setString("getUserImage", fetchUserController.userData?.user?.image.toString() ?? "");
            preferences.setString("loginUserId", fetchUserController.userData?.user?.id.toString() ?? "");
            preferences.setString("userGender", fetchUserController.userData?.user?.gender.toString() ?? "");
            preferences.setString("userCoin", fetchUserController.userData?.user?.coin.toString() ?? "");
            preferences.setBool("userIsBlock", fetchUserController.userData?.user?.isBlock ?? false);
            preferences.setBool("isHost", fetchUserController.userData?.user?.isHost ?? false);
            preferences.setString("uniqueID", fetchUserController.userData?.user?.uniqueID ?? "");

            //--------------------------------------------
            userName = preferences.getString("getUserName") ?? "";
            userBio = preferences.getString("getUserBio") ?? "";
            userImage = preferences.getString("getUserImage") ?? "";
            loginUserId = preferences.getString("loginUserId") ?? "";
            userGender = preferences.getString("userGender") ?? "";
            uniqueId = preferences.getString("uniqueID") ?? "";
            isHost = preferences.getBool("isHost") ?? false;
            userIsBlock = preferences.getBool("userIsBlock") ?? false;
            userCoin.value = preferences.getString("userCoin") ?? "";
            //---------------------------------------------
            selectedIndex = 0;
            Get.off(() => const UserBottomNavigationScreen());
          }
        }
      } else {
        const Text("User Not Found");
      }
    }
    // Get.offAll(() => const UserBottomNavigationScreen());
  }

  onClickSaveBtnForQuick() async {
    isLoading = true;
    update();
    await Fluttertoast.showToast(
      msg: "Please Wait...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.35),
      textColor: Colors.white,
      fontSize: 16.0,
    );

    isDisable = false;
    update();
    if (countryProfile.isEmpty) {
      isLoading = false;
      update();
      await Fluttertoast.showToast(
        msg: "Please selected country",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.35),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      isLoading = false;
      update();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("isBottom", true);
      isBottom = preferences.getBool('isBottom')!;
      await fetchUserController.fetchUser(
        0,
        fcmToken,
        androidId,
        androidId,
        countryProfile,
        selectedGender == 0 ? "${Constant.BASE_URL}storage/male.png" : "${Constant.BASE_URL}storage/female.png",
        "Babble User",
        currentAge.toString(),
        selectedGender == 0 ? "Male" : "Female",
      );
      preferences.setString("userEmail", androidId);
      if (fetchUserController.userData?.status ?? false) {
        /// Is host ture
        if (fetchUserController.userData?.user?.isHost == true) {
          log("Get is host true");
          await fetchHostController.fetchHost(0, fcmToken, androidId, androidId,
              fetchUserController.userData?.user?.country ?? '', fetchUserController.userData?.user?.name ?? "");
          //------------------------
          preferences.setBool("hostIsBlock", fetchHostController.hostData?.host?.isBlock ?? false);
          preferences.setBool("isHost", true);
          preferences.setBool("isLogin", true);
          preferences.setString("userName", fetchHostController.hostData?.host?.name.toString() ?? '');
          preferences.setString("userCoin", fetchHostController.hostData?.host?.coin.toString() ?? '');
          preferences.setString("userImage", fetchHostController.hostData?.host?.image.toString() ?? "");
          preferences.setString("getHostCoverImage", fetchHostController.hostData?.host?.coverImage.toString() ?? '');
          preferences.setString("userBio", fetchHostController.hostData?.host?.bio.toString() ?? '');
          preferences.setString("userGender", fetchHostController.hostData?.host?.gender.toString() ?? '');
          preferences.setString("loginUserId", fetchHostController.hostData?.host?.id.toString() ?? "");
          preferences.setString("uniqueID", fetchHostController.hostData?.host?.uniqueID ?? "");
          //----------------------------
          isHost = preferences.getBool("isHost") ?? false;
          hostIsBlock = preferences.getBool("hostIsBlock") ?? false;
          userName = preferences.getString("userName") ?? "";
          userCoin.value = preferences.getString("userCoin") ?? "";
          userImage = preferences.getString("userImage") ?? "";
          hostCoverImage = preferences.getString("getHostCoverImage") ?? "";
          userBio = preferences.getString("userBio") ?? "";
          uniqueId = preferences.getString("uniqueID") ?? "";
          userGender = preferences.getString("userGender") ?? "";
          loginUserId = preferences.getString("loginUserId") ?? "";
          //--------------------
          selectedIndex = 0;
          Get.off(() => const HostBottomNavigationBarScreen());
        } else {
          isLoading = false;
          update();
          preferences.setBool("isLogin", true);
          preferences.setString("getUserName", fetchUserController.userData?.user?.name.toString() ?? "");
          preferences.setString("getUserBio", fetchUserController.userData?.user?.bio.toString() ?? "");
          preferences.setString("getUserImage", fetchUserController.userData?.user?.image.toString() ?? "");
          preferences.setString("loginUserId", fetchUserController.userData?.user?.id.toString() ?? "");
          preferences.setString("userGender", fetchUserController.userData?.user?.gender.toString() ?? "");
          preferences.setString("userCoin", fetchUserController.userData?.user?.coin.toString() ?? "");
          preferences.setBool("userIsBlock", fetchUserController.userData?.user?.isBlock ?? false);
          preferences.setBool("isHost", fetchUserController.userData?.user?.isHost ?? false);
          preferences.setString("uniqueID", fetchUserController.userData?.user?.uniqueID ?? "");

          //--------------------------------------------
          userName = preferences.getString("getUserName") ?? "";
          userBio = preferences.getString("getUserBio") ?? "";
          userImage = preferences.getString("getUserImage") ?? "";
          loginUserId = preferences.getString("loginUserId") ?? "";
          userGender = preferences.getString("userGender") ?? "";
          uniqueId = preferences.getString("uniqueID") ?? "";
          isHost = preferences.getBool("isHost") ?? false;
          userIsBlock = preferences.getBool("userIsBlock") ?? false;
          userCoin.value = preferences.getString("userCoin") ?? "";
          //---------------------------------------------
          selectedIndex = 0;
          Get.off(() => const UserBottomNavigationScreen());
        }
      }
    }
    // Get.offAll(() => const UserBottomNavigationScreen());
  }

  onPageChanged(int index) {
    currentIndex = index;
    update();
  }
}
