import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/notification/host_notification/host_notofication_controller.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';

class HostNotificationScreen extends StatefulWidget {
  const HostNotificationScreen({Key? key}) : super(key: key);

  @override
  State<HostNotificationScreen> createState() => _HostNotificationScreenState();
}

class _HostNotificationScreenState extends State<HostNotificationScreen> {
  HostNotificationController hostNotificationController =
      Get.put(HostNotificationController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await hostNotificationController.getHostNotificationData(loginUserId);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        if (notificationVisit == true) {
          selectedIndex = 0;
          Get.offAll(() => const HostBottomNavigationBarScreen());
        } else {
          Get.back();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.appBarColor,
          title: const Text("Notification",
              style: TextStyle(
                  color: AppColors.pinkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          leading: IconButton(
            splashColor: AppColors.transparentColor,
            highlightColor: AppColors.transparentColor,
            onPressed: () {
              if (notificationVisit == true) {
                selectedIndex = 0;
                Get.offAll(() => const HostBottomNavigationBarScreen());
              } else {
                Get.back();
              }
            },
            icon: const Icon(Icons.arrow_back_ios,
                size: 22, color: AppColors.pinkColor),
          ),
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.appBackground), fit: BoxFit.cover),
          ),
          child: Obx(() {
            if (hostNotificationController.isLoading.value) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.pinkColor,
              ));
            } else {
              return (hostNotificationController
                      .hostNotificationModel!.notification!.isEmpty)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.blockSizeVertical * 20),
                        Lottie.asset(AppLottie.notificationLottieTwo,
                            repeat: true,
                            reverse: false,
                            width: SizeConfig.blockSizeHorizontal * 45),
                        Text(
                          "Notification Not Found!!",
                          style: TextStyle(
                              color: const Color(
                                0xffDF4D97,
                              ),
                              fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: hostNotificationController
                          .hostNotificationModel!.notification!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, top: 10),
                          child: Container(
                            alignment: Alignment.center,
                            height: 80,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade900,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                foregroundImage: NetworkImage(
                                    hostNotificationController
                                        .hostNotificationModel!
                                        .notification![index]
                                        .image
                                        .toString()),
                              ),
                              title: Text(
                                  hostNotificationController
                                      .hostNotificationModel!
                                      .notification![index]
                                      .title
                                      .toString(),
                                  style: const TextStyle(
                                      color: AppColors.lightPinkColor,
                                      fontSize: 18)),
                              subtitle: Text(
                                  hostNotificationController
                                      .hostNotificationModel!
                                      .notification![index]
                                      .message
                                      .toString(),
                                  style: const TextStyle(
                                      color: AppColors.pinkColor,
                                      fontSize: 15)),
                              trailing: Text(
                                  hostNotificationController
                                      .hostNotificationModel!
                                      .notification![index]
                                      .time
                                      .toString(),
                                  style: const TextStyle(
                                      color: Color(0xff717171), fontSize: 12)),
                            ),
                          ),
                        );
                      });
            }
          }),
        ),
      ),
    );
  }
}
