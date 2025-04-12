import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Complain/user_complain/get_user_complain/get_user_complain_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/profile_screen/My_Complain_Ticket_Screen/user_support_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/profile_screen/My_Complain_Ticket_Screen/user_ticket_list_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';
import '../../user_bottom_navigation_screen.dart';

class UserComplainScreen extends StatefulWidget {
  final String? userMessage;
  final String? userContact;

  const UserComplainScreen({Key? key, this.userMessage, this.userContact}) : super(key: key);

  @override
  State<UserComplainScreen> createState() => _UserComplainScreenState();
}

class _UserComplainScreenState extends State<UserComplainScreen> {
  GetUserComplainController getUserComplainController = Get.put(GetUserComplainController());

  @override
  void initState() {
    getUserComplainController.getUserComplain(loginUserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        selectedIndex = 3;
        await Get.offAll(() => const UserBottomNavigationScreen());
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
                Get.to(() => const UserSupportScreen());
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 15, top: 15, right: 20),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
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
                    selectedIndex = 3;
                    Get.off(() => const UserBottomNavigationScreen());
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
                    selectedIndex = 3;
                    Get.off(() => const UserBottomNavigationScreen());
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.pinkColor,
                    size: 22,
                  ),
                ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        }, child: Obx(() {
          if (getUserComplainController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.pinkColor,
              ),
            );
          } else if (getUserComplainController.complainDataList.isEmpty) {
            return complainNotFound(height);
          } else {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.appBackground,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                itemCount: getUserComplainController.complainDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserTicketList(
                    complainData: getUserComplainController.complainDataList,
                    index: index,
                  );
                },
              ),
            );
          }
        })),
      ),
    );
  }

  Container complainNotFound(double height) {
    return Container(
      padding: const EdgeInsets.only(bottom: 80),
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(AppImages.appBackground), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 20),
          Lottie.asset(AppLottie.notificationLottieTwo, repeat: true, reverse: false, width: SizeConfig.blockSizeHorizontal * 45),
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
              Get.to(() => const UserSupportScreen());
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
