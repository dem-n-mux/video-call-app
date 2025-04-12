// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
// import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/home_screen/user_dummy_story_screen/story_video_call.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
// import 'package:lottie/lottie.dart';
//
// class StoryCallWaiting extends StatefulWidget {
//   final String matchImage;
//   final String matchName;
//
//   const StoryCallWaiting(
//       {Key? key, required this.matchImage, required this.matchName})
//       : super(key: key);
//
//   @override
//   State<StoryCallWaiting> createState() => _StoryCallWaitingState();
// }
//
// class _StoryCallWaitingState extends State<StoryCallWaiting> {
//   String text = "Calling...";
//
//   _navigateToBack() async {
//     await Future.delayed(const Duration(seconds: 5), () {});
//     if (!mounted) return;
//     Get.to(() => StoryVideoCall(
//       matchName: widget.matchName,
//       matchImage: widget.matchImage,
//     ));
//   }
//
//   void calling() async {
//     await Future.delayed(const Duration(seconds: 3), () {}).then((value) {
//       if (!mounted) return;
//       setState(() {
//         text = "Ringing....";
//       });
//     });
//   }
//
//   @override
//   void initState() {
//     calling();
//     _navigateToBack();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Get.back();
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: const Color(
//           0xff111217,
//         ),
//         body: Container(
//           height: Get.height,
//           width: Get.width,
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(AppImages.appBackground),
//                   fit: BoxFit.cover)),
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(
//                   top: 35,
//                 ),
//               ),
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     child: Lottie.asset(
//                       width: 300,
//                       height: 300,
//                       repeat: true,
//                       AppLottie.callAnimation,
//                     ),
//                   ),
//                   Container(
//                     height: 90,
//                     width: 90,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: AppColors.pinkColor,
//                         width: 2,
//                       ),
//                       image: DecorationImage(
//                           image: NetworkImage(
//                             widget.matchImage,
//                           ),
//                           fit: BoxFit.cover),
//                     ),
//                   )
//                 ],
//               ),
//               Text(
//                 widget.matchName,
//                 style: const TextStyle(
//                   color: Color(
//                     0xffFCFDFE,
//                   ),
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 text,
//                 style: const TextStyle(
//                   color: Color(
//                     0xffFCFDFE,
//                   ),
//                   fontSize: 18,
//                 ),
//               ),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   bottom: 50,
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Container(
//                     height: 60,
//                     width: 60,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color(
//                         0xffE32827,
//                       ),
//                     ),
//                     child: const Icon(
//                       Icons.call_end,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
