import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/setting_controller.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HostPrivacyPolicyScreen extends StatefulWidget {

  const HostPrivacyPolicyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HostPrivacyPolicyScreen> createState() => _HostPrivacyPolicyScreenState();
}

class _HostPrivacyPolicyScreenState extends State<HostPrivacyPolicyScreen> {
  // bool isLoading = true;
  SettingController settingController = Get.put(SettingController());

  @override
  void initState() {
    settingController.setting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            color: AppColors.pinkColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.appBarColor,
        leading: IconButton(
          highlightColor: AppColors.transparentColor,
          splashColor: AppColors.transparentColor,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.pinkColor),
        ),
      ),
      body: Obx(
        () {
          if (settingController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return WebView(
                      onPageStarted: (url) {},
                      initialUrl: settingController.getSetting!.setting!.privacyPolicyLink ?? '',
                      javascriptMode: JavascriptMode.unrestricted,
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
