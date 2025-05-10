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

import '../../utils/widgets/signup_text_field.dart';

class UserLoginScreen2 extends StatefulWidget {

  UserLoginScreen2({Key? key}) : super(key: key);

  @override
  State<UserLoginScreen2> createState() => _UserLoginScreen2State();
}

class _UserLoginScreen2State extends State<UserLoginScreen2> {
  AddProfileController addProfileController = Get.put(AddProfileController());
  GlobalCountryController globalCountryController = Get.put(GlobalCountryController());
  AuthController authController = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    globalCountryController.globalCountryForProfile("");
    countryProfile = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  "Login",
                  style: GoogleFonts.poppins(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                  ),
                )),
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
                      SignupTextField(
                        controller: emailController,
                        onEditingComplete: () => Get.focusScope?.nextFocus(),
                        title: 'Email Address',
                      ),
                      SignupTextField(
                        controller: passwordController,
                        obscureText: true,
                        onEditingComplete: () => Get.focusScope?.unfocus(),
                        title: 'Password',
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
                    text: "Login",
                    onTap: () {
                      controller.onChangedEmail(emailController.text);
                      controller.onChangedPassword(passwordController.text);
                      controller.onClickSaveBtnForLogin();
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
