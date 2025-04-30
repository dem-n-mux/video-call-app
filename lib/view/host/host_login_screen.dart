import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/Host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_login_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HostLoginScreen extends StatefulWidget {
  const HostLoginScreen({super.key});

  @override
  State<HostLoginScreen> createState() => _HostLoginScreenState();
}

class _HostLoginScreenState extends State<HostLoginScreen> {

  TextEditingController uniqueID=TextEditingController();
  TextEditingController password=TextEditingController();

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
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            height: height,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.loginModel),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 450,
                  ),
                  const CommonLoginButton(
                    icon: AppIcons.googleIcon,
                    title: "Login with Gmail",
                    padding: 8,
                  ),
                  CommonLoginButton(
                    onTap: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setBool("isBottom", true);
                      isBottom=pref.getBool("isBottom") ?? true;
                      selectedIndex = 0;
                        Get.off(() => const HostBottomNavigationBarScreen());
                    },
                    icon: AppIcons.rocketIcon,
                    title: "Quick Login",
                    padding: 5,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
