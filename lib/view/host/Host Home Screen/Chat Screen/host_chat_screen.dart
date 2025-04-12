// import 'dart:io';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
// import 'package:hokoo_flutter/view/host/Host%20Home%20Screen/Video%20Call/host_calling_screen.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
// import 'package:hokoo_flutter/view/utils/settings/models/host_dummy_chat_model.dart';
// import 'package:hokoo_flutter/view/utils/widgets/recive_dummy_message.dart';
// import 'package:hokoo_flutter/view/utils/widgets/send_dummy_message.dart';
// import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
//
// class HostChatScreen extends StatefulWidget {
//   final String hostImage;
//   final String hostName;
//
//   const HostChatScreen({
//     Key? key,
//     required this.hostImage,
//     required this.hostName,
//   }) : super(key: key);
//
//   @override
//   State<HostChatScreen> createState() => _HostChatScreenState();
// }
//
// class _HostChatScreenState extends State<HostChatScreen> {
//   List<HostDummyChatModel> messages = [];
//   bool isButtonDisabled = true;
//   String a = "";
//   bool isVisible = false;
//   bool emojiShowing = false;
//   FocusNode focusNode = FocusNode();
//
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//
//   List dummyMessageWithDialog = [
//     "Hii",
//     "Hello",
//     "How are You?",
//     "Let's Hangout",
//     "I am Fine",
//   ];
//
//   void sendMessage(String message) async {
//     setMessage("0", message);
//     await Future.delayed(
//         const Duration(seconds: 2), () => setMessage("1", message));
//   }
//
//   void setMessage(String type, String message) {
//     HostDummyChatModel hostDummyChatModel = HostDummyChatModel(
//       type: type,
//       message: message,
//       time: DateFormat.jm().format(DateTime.now()),
//     );
//     setState(() {
//       messages.add(hostDummyChatModel);
//       _scrollController.animateTo(_scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
//     });
//   }
//
//   void validateField(text) {
//     if (_controller.text.isEmpty || _controller.text.isBlank == true) {
//       setState(() {
//         isButtonDisabled = true;
//       });
//     } else {
//       setState(() {
//         isButtonDisabled = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         setState(() {
//           emojiShowing = false;
//           _scrollController.animateTo(
//               _scrollController.position.maxScrollExtent,
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeOut);
//         });
//       }
//     });
//     _controller.addListener(() {
//       validateField(_controller.text);
//     });
//     super.initState();
//   }
//
//   File? proImage;
//
//   Future pickImage() async {
//     try {
//       final imagePick =
//           await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (imagePick == null) return;
//
//       final imagePickIs = File(imagePick.path);
//
//
//       setState(() {
//         proImage = imagePickIs;
//         Get.back();
//       });
//     } catch (e) {
//       // if (kDebugMode) {
//       //   log(e);
//       // }
//     }
//   }
//
//   Future cameraImage() async {
//     try {
//       final imageCamera =
//           await ImagePicker().pickImage(source: ImageSource.camera);
//       if (imageCamera == null) return;
//
//       final imageCameraIs = File(imageCamera.path);
//
//
//       setState(() {
//         proImage = imageCameraIs;
//         Get.back();
//       });
//     } catch (e)
//     {
//       // if (kDebugMode) {
//       //   log(e);
//       // }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var data = Get.arguments;
//     SizeConfig().init(context);
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         setState(() {
//           emojiShowing = false;
//         });
//       },
//       child: Scaffold(
//           backgroundColor: const Color(0xff302026),
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(80),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 15),
//               child: AppBar(
//                 backgroundColor: const Color(0xff302026),
//                 leadingWidth: SizeConfig.blockSizeHorizontal * 9,
//                 leading: Padding(
//                   padding: EdgeInsets.only(
//                       left: SizeConfig.blockSizeHorizontal * 2.5),
//                   child: IconButton(
//                     highlightColor: Colors.transparent,
//                     splashColor: Colors.transparent,
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back_ios,
//                       color: AppColors.pinkColor,
//                       size: 25,
//                     ),
//                   ),
//                 ),
//                 elevation: 0,
//                 title: GestureDetector(
//                   onTap: () {},
//                   child: Row(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                             right: SizeConfig.blockSizeHorizontal * 3),
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: NetworkImage(widget.hostImage),
//                                 fit: BoxFit.cover),
//                             border: Border.all(
//                                 width: 1.5, color: AppColors.pinkColor)),
//                       ),
//                       Text(
//                         widget.hostName,
//                         style: TextStyle(
//                             color: AppColors.pinkColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: SizeConfig.blockSizeHorizontal * 5),
//                       )
//                     ],
//                   ),
//                 ),
//                 actions: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         hostVideo=false;
//                       });
//                       Get.to(
//                           () => HostCallingScreen(
//                                 matchImage: widget.hostImage,
//                                 matchName: widget.hostName,
//                               ),
//                           arguments: data);
//                     },
//                     child: Padding(
//                         padding: const EdgeInsets.only(right: 10),
//                         child: Container(
//                             alignment: Alignment.center,
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: AppColors.pinkColor),
//                               shape: BoxShape.circle,
//                               color: Colors.transparent,
//                             ),
//                             child: const ImageIcon(
//                               color: AppColors.pinkColor,
//                               AssetImage(AppImages.videoCall),
//                             ))),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           body: NotificationListener<OverscrollIndicatorNotification>(
//             onNotification: (overscroll) {
//               overscroll.disallowIndicator();
//               return false;
//             },
//             child: Container(
//                 height: SizeConfig.screenHeight,
//                 width: SizeConfig.screenWidth,
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage(AppImages.appBackground),
//                         fit: BoxFit.cover)),
//                 child: WillPopScope(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           controller: _scrollController,
//                           shrinkWrap: true,
//                           itemCount: messages.length + 1,
//                           itemBuilder: (context, index) {
//                             if (index == messages.length) {
//                               return Container(
//                                 height: 60,
//                               );
//                             } else if (messages[index].type != "0") {
//                               return ReceiveDummyMessage(
//                                 message: messages[index].message,
//                                 profileImage: widget.hostImage,
//                                 time: messages[index].time,
//                               );
//                             } else {
//                               return SendDummyMessage(
//                                 message: messages[index].message,
//                                 time: messages[index].time,
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             SizedBox(
//                               height: 50,
//                               child: ListView.builder(
//                                 itemCount: dummyMessageWithDialog.length,
//                                 itemBuilder: (context, index) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         sendMessage(
//                                           dummyMessageWithDialog[index],
//                                         );
//                                       });
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15),
//                                         border: Border.all(
//                                             color: const Color(0xff767676),
//                                             width: 1),
//                                         color: const Color(0xff2D2B2C),
//                                       ),
//                                       padding: const EdgeInsets.only(
//                                           left: 10, right: 10, top: 2),
//                                       margin: const EdgeInsets.symmetric(
//                                           horizontal: 5),
//                                       child: Text(dummyMessageWithDialog[index],
//                                           style: const TextStyle(
//                                               color: Color(0xff767676),
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400)),
//                                     ),
//                                   );
//                                 },
//                                 scrollDirection: Axis.horizontal,
//                                 shrinkWrap: true,
//                                 padding: const EdgeInsets.all(10),
//                               ),
//                             ),
//                             Container(
//                               color: Colors.transparent,
//                               padding: const EdgeInsets.only(top: 9),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: Get.width - 60,
//                                     child: Card(
//                                       color: const Color(0xff2D2B2C),
//                                       margin: const EdgeInsets.only(
//                                           left: 5, right: 5, bottom: 8),
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(25)),
//                                       child: TextFormField(
//                                         keyboardAppearance: Brightness.dark,
//                                         focusNode: focusNode,
//                                         minLines: 1,
//                                         maxLines: 5,
//                                         keyboardType: TextInputType.multiline,
//                                         textAlignVertical:
//                                             TextAlignVertical.center,
//                                         controller: _controller,
//                                         autofocus: false,
//                                         autocorrect: false,
//                                         cursorColor: const Color(0xff767676),
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize:
//                                                 SizeConfig.blockSizeHorizontal *
//                                                     4,
//                                             color: const Color(0xff767676)),
//                                         decoration: InputDecoration(
//                                           prefixIcon: IconButton(
//                                             onPressed: () {
//                                               focusNode.unfocus();
//                                               focusNode.canRequestFocus = false;
//                                               setState(() {
//                                                 emojiShowing = !emojiShowing;
//                                               });
//                                             },
//                                             icon: const Icon(
//                                                 Icons.emoji_emotions,
//                                                 color: Color(0xff767676)),
//                                           ),
//                                           suffixIcon: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 3, right: 2),
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 Get.bottomSheet(Container(
//                                                   height: 200,
//                                                   decoration: const BoxDecoration(
//                                                       color: Color(0xff1E212D),
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                               topRight: Radius
//                                                                   .circular(22),
//                                                               topLeft: Radius
//                                                                   .circular(
//                                                                       22))),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             12.0),
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         const SizedBox(
//                                                           height: 10,
//                                                         ),
//                                                         const Text(
//                                                           "Select Image From",
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700,
//                                                               color: AppColors
//                                                                   .pinkColor,
//                                                               fontSize: 18),
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 5,
//                                                         ),
//                                                         const Divider(
//                                                           height: 1,
//                                                           color:
//                                                               Color(0xff1E212D),
//                                                           thickness: 0.8,
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 5,
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () =>
//                                                               cameraImage(),
//                                                           child: Container(
//                                                             height: 50,
//                                                             alignment: Alignment
//                                                                 .center,
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           6),
//                                                               color: const Color(
//                                                                   0xff1E212D),
//                                                             ),
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .start,
//                                                               children: const [
//                                                                 SizedBox(
//                                                                   width: 10,
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height: 24,
//                                                                   width: 22,
//                                                                   child: ImageIcon(
//                                                                       AssetImage(
//                                                                           AppImages
//                                                                               .messageCamera),
//                                                                       color: Colors
//                                                                           .white),
//                                                                 ),
//                                                                 SizedBox(
//                                                                   width: 15,
//                                                                 ),
//                                                                 Text(
//                                                                   "Take a photo",
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize:
//                                                                         14,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 10,
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () =>
//                                                               pickImage(),
//                                                           child: Container(
//                                                             height: 50,
//                                                             alignment: Alignment
//                                                                 .center,
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           6),
//                                                               color: const Color(
//                                                                   0xff1E212D),
//                                                             ),
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .start,
//                                                               children: const [
//                                                                 SizedBox(
//                                                                   width: 10,
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height: 24,
//                                                                   width: 22,
//                                                                   child:
//                                                                       ImageIcon(
//                                                                     AssetImage(
//                                                                         AppImages
//                                                                             .messageGellary),
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                                 SizedBox(
//                                                                   width: 15,
//                                                                 ),
//                                                                 Text(
//                                                                   "Choose From Gallery",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           14,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: Colors
//                                                                           .white),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ));
//                                               },
//                                               child: const Icon(
//                                                 Icons.camera_alt,
//                                                 color: Color(0xff767676),
//                                                 size: 25,
//                                               ),
//                                             ),
//
//                                             // IconButton(
//                                             //     onPressed: () {
//                                             //       cameraImage();
//                                             //     },
//                                             //     icon: const Icon(
//                                             //         Icons.camera_alt,
//                                             //         color:
//                                             //             Color(0xff767676))),
//                                           ),
//                                           border: InputBorder.none,
//                                           contentPadding:
//                                               const EdgeInsets.all(5),
//                                           hintText: "Message",
//                                           hintStyle: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: SizeConfig
//                                                       .blockSizeHorizontal *
//                                                   4,
//                                               color: const Color(0xff767676)),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         bottom: 8, right: 5),
//                                     child: CircleAvatar(
//                                       backgroundColor:
//                                           (const Color(0xff302026)),
//                                       radius: 25,
//                                       child: IconButton(
//                                         onPressed: isButtonDisabled
//                                             ? () {}
//                                             : () {
//                                                 if (_controller
//                                                     .text.isNotEmpty) {
//                                                   setState(() {
//                                                     isVisible = true;
//                                                   });
//                                                   sendMessage(
//                                                     _controller.text,
//                                                   );
//                                                   _controller.clear();
//                                                 }
//                                               },
//                                         icon: Icon(
//                                           (isButtonDisabled)
//                                               ? Icons.mic
//                                               : Icons.send,
//                                           color: AppColors.pinkColor,
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Offstage(
//                               offstage: !emojiShowing,
//                               child: SizedBox(
//                                 height: 250,
//                                 child: EmojiPicker(
//                                   textEditingController: _controller,
//                                   config: const Config(
//                                     columns: 7,
//                                     emojiSizeMax: 32,
//                                     verticalSpacing: 0,
//                                     horizontalSpacing: 0,
//                                     gridPadding: EdgeInsets.zero,
//                                     initCategory: Category.RECENT,
//                                     bgColor: Color(0xFFF2F2F2),
//                                     indicatorColor: Colors.blue,
//                                     iconColor: Colors.grey,
//                                     iconColorSelected: Colors.blue,
//                                     backspaceColor: Colors.blue,
//                                     skinToneDialogBgColor: Colors.white,
//                                     skinToneIndicatorColor: Colors.grey,
//                                     enableSkinTones: true,
//                                     showRecentsTab: true,
//                                     recentsLimit: 28,
//                                     replaceEmojiOnLimitExceed: false,
//                                     noRecents: Text(
//                                       'No Recent',
//                                       style: TextStyle(
//                                           fontSize: 20, color: Colors.black26),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     loadingIndicator: SizedBox.shrink(),
//                                     tabIndicatorAnimDuration:
//                                         kTabScrollDuration,
//                                     categoryIcons: CategoryIcons(),
//                                     buttonMode: ButtonMode.MATERIAL,
//                                     checkPlatformCompatibility: true,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   onWillPop: () {
//                     if (emojiShowing) {
//                       setState(() {
//                         emojiShowing = false;
//                       });
//                     } else {
//                       Get.back();
//                     }
//                     return Future.value(false);
//                   },
//                 )),
//           )),
//     );
//   }
// }
