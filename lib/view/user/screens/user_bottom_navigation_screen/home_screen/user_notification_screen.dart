import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/notification/user_notification/user_notification_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';

class UserNotificationScreen extends StatefulWidget {
  const UserNotificationScreen({Key? key}) : super(key: key);

  @override
  State<UserNotificationScreen> createState() => _UserNotificationScreenState();
}

class _UserNotificationScreenState extends State<UserNotificationScreen> {
  UserNotificationController userNotificationController = Get.put(UserNotificationController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await userNotificationController.getUserNotificationData(loginUserId);
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
          Get.offAll(() => const UserBottomNavigationScreen());
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
          title:
              const Text("Notification", style: TextStyle(color: AppColors.pinkColor, fontSize: 18, fontWeight: FontWeight.bold)),
          leading: IconButton(
            splashColor: AppColors.transparentColor,
            highlightColor: AppColors.transparentColor,
            onPressed: () {
              if (notificationVisit == true) {
                selectedIndex = 0;
                Get.offAll(() => const UserBottomNavigationScreen());
              } else {
                Get.back();
              }
            },
            icon: const Icon(Icons.arrow_back_ios, size: 22, color: AppColors.pinkColor),
          ),
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.appBackground), fit: BoxFit.cover),
          ),
          child: Obx(() {
            if (userNotificationController.isLoading.value) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.pinkColor,
              ));
            } else {
              return (userNotificationController.userNotificationModel?.notification == null ||
                      userNotificationController.userNotificationModel!.notification!.isEmpty)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.blockSizeVertical * 20),
                        Lottie.asset(AppLottie.notificationLottieTwo,
                            repeat: true, reverse: false, width: SizeConfig.blockSizeHorizontal * 45),
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
                      itemCount: userNotificationController.userNotificationModel?.notification?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
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
                                    userNotificationController.userNotificationModel?.notification?[index].image.toString() ??
                                        ''),
                              ),
                              title: Text(
                                  userNotificationController.userNotificationModel?.notification?[index].title.toString() ?? '',
                                  style: const TextStyle(color: AppColors.lightPinkColor, fontSize: 18)),
                              subtitle: Text(
                                  userNotificationController.userNotificationModel?.notification?[index].message.toString() ?? "",
                                  style: const TextStyle(color: AppColors.pinkColor, fontSize: 15)),
                              trailing: Text(
                                  userNotificationController.userNotificationModel?.notification?[index].time.toString() ?? '',
                                  style: const TextStyle(color: Color(0xff717171), fontSize: 12)),
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
