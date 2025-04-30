import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/get_host_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Home%20Screen/host_home_screen.dart';
import 'package:hokoo_flutter/view/host/Host%20Profile%20Screen/host_profile.dart';
import 'package:hokoo_flutter/view/host/host_message_screen/host_message_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HostBottomNavigationBarScreen extends StatefulWidget {
  const HostBottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<HostBottomNavigationBarScreen> createState() => _HostBottomNavigationBarScreenState();
}

class _HostBottomNavigationBarScreenState extends State<HostBottomNavigationBarScreen> {
  GetHostController getHostController = Get.put(GetHostController());
  final screen = [
    const HostHomeScreen(),
    const HostMessageScreen(),
    const HostProfile(),
  ];

  @override
  void initState() {
    getHostController.getHost(loginUserId);
    super.initState();
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: screen[hostSelectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        margin: const EdgeInsets.only(left: 28, right: 28, top: 10, bottom: 10),
        selectedItemColor: AppColors.pinkColor,
        unselectedItemColor: AppColors.grey,
        onTap: (value) {
          setState(() {
            hostSelectedIndex = value;
          });
        },
        currentIndex: hostSelectedIndex,
        items: [
          SalomonBottomBarItem(
            icon: const ImageIcon(
              AssetImage(AppImages.hostHome),
            ),
            title: const Text("Home"),
            selectedColor: AppColors.pinkColor,
          ),
          SalomonBottomBarItem(
            icon: const ImageIcon(
              AssetImage(AppImages.hostMessage),
            ),
            title: const Text("Message"),
            selectedColor: AppColors.pinkColor,
          ),
          SalomonBottomBarItem(
            icon: const ImageIcon(
              AssetImage(AppImages.hostProfile),
            ),
            title: const Text("Profile"),
            selectedColor: AppColors.pinkColor,
          ),
        ],
      ),
    );
  }
}
