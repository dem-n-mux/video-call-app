// import 'dart:async';
// import 'dart:developer';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
// import 'package:hokoo_flutter/view/utils/settings/models/dummy_host_model.dart';
// import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
// import 'package:lottie/lottie.dart';
// import 'user_dummy_call_panel.dart';
//
// class UserDummyCallWaiting extends StatefulWidget {
//   const UserDummyCallWaiting({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<UserDummyCallWaiting> createState() => _UserDummyCallWaitingState();
// }
//
// class _UserDummyCallWaitingState extends State<UserDummyCallWaiting>
//     with WidgetsBindingObserver {
//   CameraController? controller;
//   bool _isCameraInitialized = false;
//   bool _isRearCameraSelected = true;
//   bool _isMute = false;
//   String text = "Calling...";
//
//   DummyHostModel data = Get.arguments;
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
//   _navigateToBack() async {
//     await Future.delayed(const Duration(seconds: 5), () {});
//     if (!mounted) return;
//     Get.to(() => const UserDummyCallPreview(), arguments: data);
//   }
//
//   void onNewCameraSelected(CameraDescription cameraDescription) async {
//     final previousCameraController = controller;
//     // Instantiating the camera controller
//     final CameraController cameraController = CameraController(
//       cameraDescription,
//       ResolutionPreset.ultraHigh,
//       imageFormatGroup: ImageFormatGroup.jpeg,
//     );
//
//     // Dispose the previous controller
//     await previousCameraController?.dispose();
//
//     // Replace with the new controller
//     if (mounted) {
//       setState(() {
//         controller = cameraController;
//       });
//     }
//
//     // Update UI if controller updated
//     cameraController.addListener(() {
//       if (mounted) setState(() {});
//     });
//
//     // Initialize controller
//     try {
//       await cameraController.initialize();
//     } on CameraException catch (e) {
//       log('Error initializing camera: $e');
//     }
//
//     // Update the Boolean
//     if (mounted) {
//       setState(() {
//         _isCameraInitialized = controller!.value.isInitialized;
//       });
//     }
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final CameraController? cameraController = controller;
//
//     // App state changed before we got the chance to initialize.
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return;
//     }
//
//     if (state == AppLifecycleState.inactive) {
//       // Free up memory when camera not active
//       cameraController.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       // Reinitialize the camera with same properties
//       onNewCameraSelected(cameraController.description);
//     }
//   }
//
//   @override
//   void initState() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//     onNewCameraSelected(cameras[1]);
//     calling();
//     _navigateToBack();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       body: _isCameraInitialized
//           ? AspectRatio(
//               aspectRatio: 0.85 / controller!.value.aspectRatio,
//               child: Stack(
//                 children: [
//                   controller!.buildPreview(),
//                   Container(
//                     padding: const EdgeInsets.only(bottom: 40, top: 60),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           text,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: SizeConfig.blockSizeHorizontal * 6),
//                         ),
//                         Container(
//                           height: SizeConfig.blockSizeVertical * 25,
//                           color: Colors.transparent,
//                           child: Lottie.asset(AppLottie.callingLottie),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _isMute = !_isMute;
//                                 });
//                               },
//                               child: CircleAvatar(
//                                 radius: SizeConfig.blockSizeVertical * 3,
//                                 backgroundColor: Colors.white,
//                                 child: Icon(
//                                   (_isMute ? Icons.mic_off : Icons.mic),
//                                   color: Colors.black,
//                                   size: SizeConfig.blockSizeVertical * 3.5,
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Get.back();
//                               },
//                               child: CircleAvatar(
//                                 radius: SizeConfig.blockSizeVertical * 4,
//                                 backgroundColor: Colors.red,
//                                 child: Icon(Icons.call_end,
//                                     color: Colors.white,
//                                     size: SizeConfig.blockSizeVertical * 4.5),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _isCameraInitialized = false;
//                                 });
//
//                                 onNewCameraSelected(
//                                   cameras[_isRearCameraSelected ? 0 : 1],
//                                 );
//                                 setState(() {
//                                   _isRearCameraSelected =
//                                       !_isRearCameraSelected;
//                                 });
//                               },
//                               child: CircleAvatar(
//                                 radius: SizeConfig.blockSizeVertical * 3,
//                                 backgroundColor: Colors.white,
//                                 child: Icon(
//                                   (_isRearCameraSelected
//                                       ? Icons.camera_front
//                                       : Icons.camera_rear),
//                                   color: Colors.black,
//                                   size: SizeConfig.blockSizeVertical * 3.5,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ))
//           : Container(
//               color: Colors.black,
//             ),
//     );
//   }
// }
