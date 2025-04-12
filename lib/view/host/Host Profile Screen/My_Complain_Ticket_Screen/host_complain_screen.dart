import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Complain/host_complain/get_host_complain/get_host_complain_controller.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/host/Host%20Profile%20Screen/My_Complain_Ticket_Screen/host_support_screen.dart';
import 'package:hokoo_flutter/view/host/Host%20Profile%20Screen/My_Complain_Ticket_Screen/host_ticket_list_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';

class HostComplainScreen extends StatefulWidget {
  final String? hostMessage;
  final String? hostContact;

  const HostComplainScreen({Key? key, this.hostMessage, this.hostContact})
      : super(key: key);

  @override
  State<HostComplainScreen> createState() => _HostComplainScreenState();
}

class _HostComplainScreenState extends State<HostComplainScreen> {
  GetHostComplainController getHostComplainController =
      Get.put(GetHostComplainController());

  @override
  void initState() {
    getHostComplainIs();
    super.initState();
  }

  getHostComplainIs() async {
    await getHostComplainController.getHostComplain(loginUserId);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          selectedIndex = 2;
          await Get.offAll(() => const HostBottomNavigationBarScreen());
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  Get.to(() => const HostSupportScreen());
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 17, left: 17, top: 14, bottom: 14),
                  alignment: Alignment.center,
                  width: 70,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.pinkColor,
                  ),
                  child: const Text(
                    "New",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
            title: const Text(
              "Tickets",
              style: TextStyle(
                color: AppColors.pinkColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            backgroundColor: AppColors.appBarColor,
            leading: (switchComplain)
                ? IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      //Get.back();
                      selectedIndex = 2;
                      Get.off(() => const HostBottomNavigationBarScreen());
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.pinkColor,
                      size: 22,
                    ),
                  )
                : IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      selectedIndex = 2;
                      Get.off(() => const HostBottomNavigationBarScreen());
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.pinkColor,
                      size: 22,
                    ),
                  ),
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.appBackground,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Obx(() {
                if (getHostComplainController.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.pinkColor,
                  ));
                } else if(getHostComplainController.complainDataList.isNotEmpty) {
                  return ListView.builder(
                    itemCount:
                        getHostComplainController.complainDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HostTicketList(
                        complainData:
                            getHostComplainController.complainDataList,
                        index: index,
                      );
                    },
                  );
                }else{
                  return complainNotFound(height);
                }
              }),
            ),
          ),
        ));
  }

  Container complainNotFound(double height) {
    return Container(
      padding: const EdgeInsets.only(bottom: 80),
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.appBackground), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 20),
          Lottie.asset(AppLottie.notificationLottieTwo,
              repeat: true,
              reverse: false,
              width: SizeConfig.blockSizeHorizontal * 45),
          Text(
            "Complain Not Found!!",
            style: TextStyle(
                color: const Color(
                  0xffDF4D97,
                ),
                fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Get.to(() => const HostSupportScreen());
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(
                horizontal: 85,
              ),
              height: height / 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.pinkColor,
              ),
              child: Text(
                "Complain Now",
                style: TextStyle(
                  color: AppColors.lightPinkColor,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
