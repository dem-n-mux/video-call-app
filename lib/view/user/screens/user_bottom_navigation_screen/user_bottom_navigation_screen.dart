import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/profile_screen/user_profile_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'home_screen/user_home_screen.dart';
import 'matching_screen/user_matching_screen.dart';
import 'message_screen/user_message_screen.dart';

class UserBottomNavigationScreen extends StatefulWidget {
  const UserBottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<UserBottomNavigationScreen> createState() => _UserBottomNavigationScreenState();
}

class _UserBottomNavigationScreenState extends State<UserBottomNavigationScreen> {
  final screen = [
    const UserHomeScreen(),
    const MessageScreen(),
    const UserMatchingScreen(),
    const UserProfileScreen(),
  ];

  // @override
  // void initState() {
  //   startCamera(cameras[1]);
  //   super.initState();
  // }

  void startCamera(CameraDescription cameraDescription) async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }
        return false;
      },
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Scaffold(
            backgroundColor: Colors.black,
            body: screen[selectedIndex],
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: selectedIndex,
              selectedItemColor: AppColors.pinkColor,
              unselectedItemColor: AppColors.grey,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              items: [
                SalomonBottomBarItem(
                  icon: const ImageIcon(
                    AssetImage(AppIcons.homeIcon),
                  ),
                  title: const Text("Home"),
                  selectedColor: AppColors.pinkColor,
                ),
                SalomonBottomBarItem(
                  icon: const ImageIcon(
                    AssetImage(AppIcons.messageIcon),
                  ),
                  title: const Text("Message"),
                  selectedColor: AppColors.pinkColor,
                ),
                SalomonBottomBarItem(
                  icon: const ImageIcon(
                    AssetImage(AppIcons.matchIcon),
                  ),
                  title: const Text("Match"),
                  selectedColor: AppColors.pinkColor,
                ),
                SalomonBottomBarItem(
                  icon: const ImageIcon(
                    AssetImage(AppIcons.profileIcon),
                  ),
                  title: const Text("Profile"),
                  selectedColor: AppColors.pinkColor,
                ),
              ],
            )

            // bottomNavigationBar: Theme(
            //   data: ThemeData(
            //     splashColor: Colors.transparent,
            //     highlightColor: Colors.transparent,
            //   ),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: Colors.black,
            //     ),
            //     height: 70,
            //     child: BottomNavigationBar(
            //       type: BottomNavigationBarType.fixed,
            //       selectedItemColor: AppColors.pinkColor,
            //       unselectedItemColor: AppColors.grey,
            //       backgroundColor: Colors.transparent,
            //       onTap: (value) {
            //         setState(() {
            //           selectedIndex = value;
            //         });
            //       },
            //       currentIndex: selectedIndex,
            //       items: const [
            //         BottomNavigationBarItem(
            //           backgroundColor: Colors.transparent,
            //           icon: ImageIcon(
            //             AssetImage(AppIcons.homeIcon),
            //           ),
            //
            //           // icon: Column(
            //           //   children: [
            //           //     const SizedBox(
            //           //       height: 10,
            //           //     ),
            //           //     SizedBox(
            //           //         height: 22,
            //           //         width: 22,
            //           //         child: ImageIcon(const AssetImage(AppIcons.homeIcon),
            //           //           size: 20,
            //           //           color: (selectedIndex == 0) ? AppColors.pinkColor : AppColors.grey,
            //           //         )),
            //           //   ],
            //           // ),
            //
            //
            //           label: "Home",
            //         ),
            //         BottomNavigationBarItem(
            //
            //           icon: ImageIcon(
            //             AssetImage(AppIcons.messageIcon),
            //           ),
            //
            //           // icon: Column(
            //           //   children: [
            //           //     const SizedBox(
            //           //       height: 10,
            //           //     ),
            //           //     SizedBox(
            //           //         height: 22,
            //           //         width: 22,
            //           //         child: ImageIcon(const AssetImage(AppIcons.messageIcon),
            //           //           size: 20,
            //           //           color: (selectedIndex == 1) ? AppColors.pinkColor : AppColors.grey,
            //           //         )),
            //           //   ],
            //           // ),
            //           label: "Message",
            //         ),
            //         BottomNavigationBarItem(
            //           icon: ImageIcon(
            //             AssetImage(AppIcons.matchIcon),
            //           ),
            //           // icon: Column(
            //           //   children: [
            //           //     const SizedBox(
            //           //       height: 10,
            //           //     ),
            //           //     SizedBox(
            //           //         height: 22,
            //           //         width: 22,
            //           //         child: ImageIcon(const AssetImage(AppIcons.matchIcon),
            //           //           size: 20,
            //           //           color: (selectedIndex == 2) ? AppColors.pinkColor : AppColors.grey,
            //           //         )),
            //           //   ],
            //           // ),
            //           label: "Match",
            //         ),
            //         BottomNavigationBarItem(
            //           icon: ImageIcon(
            //             AssetImage(AppIcons.profileIcon),
            //           ),
            //           // icon: Column(
            //           //   children: [
            //           //     const SizedBox(
            //           //       height: 10,
            //           //     ),
            //           //     SizedBox(
            //           //         height: 22,
            //           //         width: 22,
            //           //         child: ImageIcon(const AssetImage(AppIcons.profileIcon),
            //           //           size: 20,
            //           //           color: (selectedIndex == 3) ? AppColors.pinkColor : AppColors.grey,
            //           //         )),
            //           //   ],
            //           // ),
            //           label: "Profile",
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // )),
            ),
      ),
    );
  }
}
