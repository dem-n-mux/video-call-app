// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
// import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/matching_screen/user_one_to_one_call.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
// import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:share/share.dart';
// import '../../../../utils/settings/models/dummy_host_model.dart';
//
// class DummyMatchProfileScreen extends StatefulWidget {
//   final String matchName;
//   final String matchImage;
//
//   const DummyMatchProfileScreen({
//     Key? key,
//     required this.matchName,
//     required this.matchImage,
//   }) : super(key: key);
//
//   @override
//   State<DummyMatchProfileScreen> createState() =>
//       _DummyMatchProfileScreenState();
// }
//
// class _DummyMatchProfileScreenState extends State<DummyMatchProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     userprofileImageList.shuffle();
//     dummyHostList.shuffle();
//     final String id = dummyHostList.first.iD;
//     final String age = dummyHostList.first.age;
//     final String country = dummyHostList.first.country;
//     SizeConfig().init(context);
//     return NotificationListener<OverscrollIndicatorNotification>(
//         onNotification: (overscroll) {
//           overscroll.disallowIndicator();
//           return false;
//         },
//         child: WillPopScope(
//           onWillPop: () async {
//             Get.back();
//             return false;
//           },
//           child: Container(
//               height: SizeConfig.screenHeight,
//               width: SizeConfig.screenWidth,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(AppImages.appBackground),
//                       fit: BoxFit.cover)),
//               child: Scaffold(
//                   resizeToAvoidBottomInset: false,
//                   backgroundColor: Colors.transparent,
//                   body: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           Container(
//                             alignment: Alignment.topCenter,
//                             padding: EdgeInsets.only(
//                                 left: SizeConfig.blockSizeHorizontal * 3,
//                                 right: SizeConfig.blockSizeHorizontal * 3,
//                                 top: SizeConfig.blockSizeVertical * 5),
//                             height: SizeConfig.blockSizeVertical * 35,
//                             width: SizeConfig.screenWidth,
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   bottomRight: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20)),
//                               image: DecorationImage(
//                                   image:
//                                       NetworkImage(AppImages.userProfileModel),
//                                   fit: BoxFit.cover),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 GestureDetector(
//                                     onTap: () {
//                                       Get.back();
//                                     },
//                                     child: const Icon(
//                                       Icons.arrow_back_ios_new,
//                                       color: Colors.white,
//                                     )),
//                                 GestureDetector(
//                                     onTap: () {
//                                       Share.share(
//                                         "Hello Hokoo",
//                                       );
//                                     },
//                                     child: const Icon(
//                                       Icons.share,
//                                       color: Colors.white,
//                                     )),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: SizeConfig.blockSizeVertical * 27,
//                             margin: EdgeInsets.only(
//                                 left: SizeConfig.blockSizeHorizontal * 5,
//                                 right: SizeConfig.blockSizeHorizontal * 5,
//                                 top: SizeConfig.blockSizeVertical * 27),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       alignment: Alignment.center,
//                                       padding: const EdgeInsets.all(3),
//                                       height: SizeConfig.blockSizeVertical * 14,
//                                       width:
//                                           SizeConfig.blockSizeHorizontal * 28,
//                                       decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           gradient: LinearGradient(
//                                               begin: Alignment.topLeft,
//                                               end: Alignment.bottomRight,
//                                               colors: [
//                                                 Color(0xffE5477A),
//                                                 Color(0xffE5477A),
//                                                 Color(0xffE5477A),
//                                                 Color(0xffE5477A),
//                                                 AppColors.appBarColor,
//                                                 AppColors.appBarColor,
//                                               ])),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             image: DecorationImage(
//                                                 image: NetworkImage(
//                                                     widget.matchImage),
//                                                 fit: BoxFit.cover)),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 7),
//                                       child: Text(
//                                         widget.matchName,
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize:
//                                                 SizeConfig.blockSizeHorizontal *
//                                                     5.8),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 7),
//                                       child: Text(
//                                         "ID : $id",
//                                         style: TextStyle(
//                                             color: Colors.grey,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize:
//                                                 SizeConfig.blockSizeHorizontal *
//                                                     3.5),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           top: SizeConfig.blockSizeVertical *
//                                               0.7,
//                                           left: 5),
//                                       child: Row(
//                                         children: [
//                                           Container(
//                                             margin: EdgeInsets.only(
//                                                 right: SizeConfig
//                                                         .blockSizeHorizontal *
//                                                     3),
//                                             padding: const EdgeInsets.all(5),
//                                             height:
//                                                 SizeConfig.blockSizeVertical *
//                                                     3.5,
//                                             width:
//                                                 SizeConfig.blockSizeHorizontal *
//                                                     13,
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 color: const Color(0xff6C2D42),
//                                                 border: Border.all(
//                                                     width: 1,
//                                                     color: const Color(
//                                                         0xffD97998))),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 Container(
//                                                   alignment: Alignment.center,
//                                                   width: SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       4,
//                                                   decoration: const BoxDecoration(
//                                                       image: DecorationImage(
//                                                           image: AssetImage(
//                                                               AppIcons
//                                                                   .genderIcon),
//                                                           fit: BoxFit.fill)),
//                                                 ),
//                                                 Text(age,
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: SizeConfig
//                                                                 .blockSizeHorizontal *
//                                                             3))
//                                               ],
//                                             ),
//                                           ),
//                                           Text(
//                                             country,
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: SizeConfig
//                                                         .blockSizeVertical *
//                                                     1.8),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: SizeConfig.blockSizeHorizontal * 18,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             SizeConfig.blockSizeVertical * 8.5,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           const CircleAvatar(
//                                             backgroundColor:
//                                                 AppColors.onlineColor,
//                                             radius: 4.5,
//                                           ),
//                                           Text(
//                                             "Online",
//                                             style: TextStyle(
//                                                 color: AppColors.onlineColor,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: SizeConfig
//                                                         .blockSizeHorizontal *
//                                                     4.5),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 1.5,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: SizeConfig.blockSizeHorizontal * 5),
//                             child: Text(
//                               "Photos",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: const Color(0xffEB497E),
//                                   fontSize: SizeConfig.blockSizeVertical * 2.3),
//                             ),
//                           ),
//                           SizedBox(
//                             height: SizeConfig.blockSizeVertical * 1.5,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 60),
//                             height: SizeConfig.blockSizeVertical * 20,
//                             child: ListView.builder(
//                               padding: const EdgeInsets.only(left: 10),
//                               scrollDirection: Axis.horizontal,
//                               physics: const ScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: userprofileImageList.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Container(
//                                   margin:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   width: SizeConfig.blockSizeHorizontal * 30,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       image: DecorationImage(
//                                           image: NetworkImage(
//                                               userprofileImageList[index]),
//                                           fit: BoxFit.cover)),
//                                 );
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: SizeConfig.blockSizeHorizontal * 5),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   Get.to(() => DummyMatchCallPreview(
//                                         matchName: widget.matchName,
//                                         matchImage: widget.matchImage,
//                                       ));
//                                 });
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal:
//                                         SizeConfig.blockSizeHorizontal * 5),
//                                 height: SizeConfig.blockSizeVertical * 6,
//                                 width: SizeConfig.screenWidth * 0.53,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     color: const Color(0xffF24A80)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       AppIcons.videoCallIcon,
//                                       color: Colors.white,
//                                       width: SizeConfig.blockSizeHorizontal * 7,
//                                     ),
//                                     SizedBox(
//                                       width: SizeConfig.blockSizeHorizontal * 3,
//                                     ),
//                                     Text(
//                                       "Video Chat",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize:
//                                               SizeConfig.blockSizeHorizontal *
//                                                   4.5,
//                                           fontWeight: FontWeight.w500),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Get.back();
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal:
//                                         SizeConfig.blockSizeHorizontal * 4),
//                                 height: SizeConfig.blockSizeVertical * 6,
//                                 width: SizeConfig.screenWidth * .35,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     border: Border.all(
//                                         width: 1, color: Colors.grey),
//                                     color: const Color(0xff2A2A2A)),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Image.asset(
//                                       AppIcons.commentIcon,
//                                       color: Colors.white,
//                                       width: SizeConfig.blockSizeHorizontal * 6,
//                                     ),
//                                     Text(
//                                       "Say Hi",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize:
//                                               SizeConfig.blockSizeHorizontal *
//                                                   4.5,
//                                           fontWeight: FontWeight.w500),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ))),
//         ));
//   }
//
//   Future<void> handlePermission(Permission permission) async {
//     final status = await permission.request();
//     log(status.toString());
//   }
// }
