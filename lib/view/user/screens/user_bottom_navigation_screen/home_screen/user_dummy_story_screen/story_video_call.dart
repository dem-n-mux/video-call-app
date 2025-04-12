// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
// import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/matching_screen/user_matched_calling_screen.dart';
// import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
// import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
// import 'package:video_player/video_player.dart';
//
// class StoryVideoCall extends StatefulWidget {
//   final String matchName;
//   final String matchImage;
//
//   const StoryVideoCall({
//     Key? key,
//     required this.matchName,
//     required this.matchImage,
//   }) : super(key: key);
//
//   @override
//   State<StoryVideoCall> createState() => _StoryVideoCallState();
// }
//
// class _StoryVideoCallState extends State<StoryVideoCall> {
//   late VideoPlayerController _controller;
//   bool isRearCameraSelected = true;
//   bool isVolume = true;
//
//   @override
//   void initState() {
//     _controller = VideoPlayerController.asset("assets/video/video_3.mp4")
//       ..initialize().then((_) {
//         const Center(
//           child: CircularProgressIndicator(),
//         );
//         setState(() {
//           _controller.play();
//           _controller.setLooping(true);
//         });
//       });
//     setState(() {});
//     startCamera(cameras[1]);
//     super.initState();
//   }
//
//   void startCamera(CameraDescription cameraDescription) async {
//     cameras = await availableCameras();
//     cameraController = CameraController(
//       cameraDescription,
//       ResolutionPreset.low,
//       enableAudio: false,
//     );
//     await cameraController.initialize().then((value) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((e) {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return WillPopScope(
//       onWillPop: () async {
//         _controller.pause();
//         (isMatchCall)
//             ? Get.offAll(() => UserMatchedCallingScreen(
//           matchName: widget.matchName,
//           matchImage: widget.matchImage,
//         ))
//             : Get.back();
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: SafeArea(
//           child: SizedBox(
//             height: SizeConfig.screenHeight,
//             width: SizeConfig.screenWidth,
//             child: SizedBox(
//                 height: SizeConfig.screenHeight,
//                 width: SizeConfig.screenWidth,
//                 child: Stack(
//                   children: [
//                     VideoPlayer(_controller),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Spacer(),
//                             ClipRRect(
//                               clipBehavior: Clip.hardEdge,
//                               borderRadius: BorderRadius.circular(10),
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 height: 130,
//                                 width: 100,
//                                 child: CameraPreview(
//                                   cameraController,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 15),
//                                   child: Container(
//                                     height: 75,
//                                     width: 250,
//                                     decoration: BoxDecoration(
//                                       color: AppColors.appBarColor,
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () async {
//                                             selectedIndex = 0;
//                                             _controller.pause();
//                                             cameraController.pausePreview();
//                                             (isMatchCall)
//                                                 ? (isVideo)
//                                                 ? Get.offAll(() =>
//                                             const UserBottomNavigationScreen())
//                                                 : Get.offAll(() =>
//                                                 UserMatchedCallingScreen(
//                                                   matchName:
//                                                   widget.matchName,
//                                                   matchImage:
//                                                   widget.matchImage,
//                                                 ))
//                                                 : Get.back();
//                                           },
//                                           child: Container(
//                                             height: 50,
//                                             width: 50,
//                                             decoration: const BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: AppColors.redColor,
//                                             ),
//                                             child: const Icon(
//                                                 Icons.call_end_outlined,
//                                                 color: Colors.white,
//                                                 size: 25),
//                                           ),
//                                         ),
//                                         GestureDetector(
//                                             onTap: () {
//                                               startCamera(cameras[
//                                               isRearCameraSelected
//                                                   ? 0
//                                                   : 1]);
//                                               setState(() {
//                                                 isRearCameraSelected =
//                                                 !isRearCameraSelected;
//                                               });
//                                             },
//                                             child: Container(
//                                                 alignment: Alignment.center,
//                                                 height: 50,
//                                                 width: 50,
//                                                 decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: AppColors.flipCameraColor,
//                                                 ),
//                                                 child: const ImageIcon(
//                                                   AssetImage(
//                                                       AppImages.flipCamera),
//                                                   color: Colors.white,
//                                                   size: 30,
//                                                 ))),
//                                         GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               isVolume = !isVolume;
//                                               _controller.setVolume(
//                                                   (isVolume) ? 1.0 : 0.0);
//                                             });
//                                           },
//                                           child: Container(
//                                             alignment: Alignment.center,
//                                             height: 50,
//                                             width: 50,
//                                             decoration: const BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: AppColors.flipCameraColor,
//                                             ),
//                                             child: Container(
//                                               height: 25,
//                                               width: 25,
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                     image: (isVolume == true)
//                                                         ? const AssetImage(
//                                                       AppIcons.micOn,
//                                                     )
//                                                         : const AssetImage(
//                                                       AppIcons.micOff,
//                                                     )),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 )),
//           ),
//         ),
//       ),
//     );
//   }
// }
