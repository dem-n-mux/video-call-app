import 'package:hokoo_flutter/Api_Service/chat/model/chat_thumb_model.dart';
import 'package:hokoo_flutter/Api_Service/chat/model/get_old_chat_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';

List<ChatList> dummyChatList = [
  ChatList(
    total: 1,
    topic: "Topic 1",
    message: "Hello!",
    date: "2024-02-26",
    chatDate: "2024-02-26",
    name: "John",
    bio: "Software Engineer",
    image:
        "https://images.unsplash.com/photo-1623039497026-00af61471107?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZmVtYWxlJTIwbW9kZWx8ZW58MHx8MHx8fDA%3D",
    country: "USA",
    isOnline: true,
    count: 5,
    id: "1",
    time: "10:00 AM",
  ),
  ChatList(
    total: 2,
    topic: "Topic 2",
    message: "Hi there!",
    date: "2024-02-25",
    chatDate: "2024-02-25",
    name: "Alice",
    bio: "Data Scientist",
    image: "${Constant.BASE_URL}storage/1708516869269heleno-kaizer-xtNjW02Swag-unsplash.jpg",
    country: "Canada",
    isOnline: false,
    count: 3,
    id: "2",
    time: "11:30 AM",
  ),
  // Adding more dummy chat data
  ChatList(
    total: 3,
    topic: "Topic 3",
    message: "Hey!",
    date: "2024-02-24",
    chatDate: "2024-02-24",
    name: "Emily",
    bio: "Graphic Designer",
    image:
        "https://images.unsplash.com/photo-1527285540841-10bce6b1e588?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzJ8fGZlbWFsZSUyMG1vZGVsfGVufDB8fDB8fHww",
    country: "UK",
    isOnline: true,
    count: 2,
    id: "3",
    time: "9:00 AM",
  ),
  // Add more dummy chat data as needed
  ChatList(
    total: 4,
    topic: "Topic 4",
    message: "How are you?",
    date: "2024-02-23",
    chatDate: "2024-02-23",
    name: "Michael",
    bio: "Teacher",
    image:
        "https://images.unsplash.com/photo-1616683693504-3ea7e9ad6fec?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    country: "Australia",
    isOnline: false,
    count: 7,
    id: "4",
    time: "3:45 PM",
  ),
  // Add more dummy chat data as needed
  // Continuing adding more chat entries
  ChatList(
    total: 5,
    topic: "Topic 5",
    message: "What's up?",
    date: "2024-02-22",
    chatDate: "2024-02-22",
    name: "Sophia",
    bio: "Artist",
    image:
        "https://images.unsplash.com/photo-1618721405821-80ebc4b63d26?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    country: "France",
    isOnline: true,
    count: 4,
    id: "5",
    time: "2:00 PM",
  ),
  // Add more dummy chat data as needed
  // Continuing adding more chat entries
];

// class DummyChatScreen extends StatefulWidget {
//   final String callType;
//   final String hostName;
//   final String hostImage;
//   final String chatRoomId;
//   final String senderId;
//   final String receiverId;
//   final String screenType;
//   final int type;
//
//   const DummyChatScreen({
//     Key? key,
//     required this.hostName,
//     required this.chatRoomId,
//     required this.senderId,
//     required this.hostImage,
//     required this.receiverId,
//     required this.screenType,
//     required this.type,
//     required this.callType,
//   }) : super(key: key);
//
//   @override
//   State<DummyChatScreen> createState() => _DummyChatScreenState();
// }
//
// class _DummyChatScreenState extends State<DummyChatScreen>
//     with SingleTickerProviderStateMixin {
//   List<DummyChatModel> messages = [];
//   bool isButtonDisabled = true;
//   String a = "";
//   bool isVisible = false;
//   bool emojiShowing = false;
//   FocusNode focusNode = FocusNode();
//   // CreateChatController createChatController = Get.put(CreateChatController());
//   // GetOldChatController getOldChatController = Get.put(GetOldChatController());
//
//   // bool enabled = true;
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
//   late IO.Socket socket;
//
//
//
//   void setMessage({
//     required String senderId,
//     required String message,
//     required int type,
//     required String time,
//     required bool isRead,
//     required int messageType,
//   }) {
//     ChatModel messageModel = ChatModel(
//         senderId: senderId,
//         message: message,
//         type: type,
//         time: time,
//         isRead: isRead,
//         messageType: messageType);
//     setState(() {
//
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
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
//     super.initState();
//
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         setState(() {
//           emojiShowing = false;
//           _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//         });
//       }
//     });
//     _controller.addListener(() {
//       validateField(_controller.text);
//     });
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
//
//   File? proImage;
//
//   Future pickImage() async {
//     try {
//       final imagePick =
//       await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (imagePick == null) return;
//
//       final imagePickIs = File(imagePick.path);
//       createChatImage = imagePickIs;
//       CreateChatController().createChat(
//           widget.chatRoomId, 0, widget.senderId, widget.type, imagePickIs);
//
//       setState(() {
//         proImage = imagePickIs;
//         Get.back();
//       });
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   Future cameraImage() async {
//     try {
//       final imageCamera =
//       await ImagePicker().pickImage(source: ImageSource.camera);
//       if (imageCamera == null) return;
//
//       final imageCameraIs = File(imageCamera.path);
//       createChatImage = imageCameraIs;
//       CreateChatController().createChat(
//           widget.chatRoomId, 0, widget.senderId, widget.type, imageCameraIs);
//       setState(() {
//         proImage = imageCameraIs;
//         Get.back();
//       });
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   ///Voice Message ///
//   late AnimationController animationController;
//
//   @override
//   Widget build(BuildContext context) {
//
//     log("button is :- $videoButtonIs");
//
//     SizeConfig().init(context);
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         setState(() {
//           emojiShowing = false;
//         });
//       },
//       child: WillPopScope(
//         onWillPop: () async {
//
//
//
//           if (widget.screenType == 'HostScreen') {
//             selectedIndex = 1;
//             Get.offAll(const HostBottomNavigationBarScreen());
//             Get.delete<GetOldChatController>();
//             // hostSelectedIndex = 1;
//             // Get.off(const HostBottomNavigationBarScreen());
//           } else if (widget.screenType == "UserScreen") {
//             selectedIndex = 1;
//             Get.offAll(const UserBottomNavigationScreen());
//             Get.delete<GetOldChatController>();
//           } else if (widget.screenType == "StoryUserScreen" ||
//               widget.screenType == "UserProfileScreen") {
//             Get.back();
//             Get.delete<GetOldChatController>();
//           } else {}
//           return false;
//         },
//         child: Scaffold(
//           backgroundColor: AppColors.chatBackgroundColor,
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(80),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 15),
//               child: AppBar(
//                 backgroundColor: AppColors.chatBackgroundColor,
//                 leadingWidth: SizeConfig.blockSizeHorizontal * 9,
//                 leading: Padding(
//                   padding: EdgeInsets.only(
//                       left: SizeConfig.blockSizeHorizontal * 2.5),
//                   child: IconButton(
//                     highlightColor: AppColors.transparentColor,
//                     splashColor: AppColors.transparentColor,
//                     onPressed: () {
//                       if (widget.screenType == 'HostScreen') {
//                         selectedIndex = 1;
//                         Get.offAll(const HostBottomNavigationBarScreen());
//                         Get.delete<GetOldChatController>();
//                         // hostSelectedIndex = 1;
//                         // Get.off(const HostBottomNavigationBarScreen());
//                       } else if (widget.screenType == "UserScreen") {
//                         selectedIndex = 1;
//                         Get.offAll(const UserBottomNavigationScreen());
//                         Get.delete<GetOldChatController>();
//                       } else if (widget.screenType == "StoryUserScreen" ||
//                           widget.screenType == "UserProfileScreen") {
//                         Get.back();
//                         Get.delete<GetOldChatController>();
//                       } else {}
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
//                   onTap: () {
//                     setState(() {
//                       isStory = false;
//                     });
//
//                   },
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
//                   AbsorbPointer(
//                     absorbing: !videoButtonIs,
//                     child: GestureDetector(
//                       onTap:  () {
//                         Fluttertoast.showToast(
//                           msg: "It's Demo App",
//                           toastLength: Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.SNACKBAR,
//                           backgroundColor: Colors.black.withOpacity(0.35),
//                           textColor: Colors.white,
//                           fontSize: 16.0,
//                         );
//                       },
//                       child: Padding(
//                           padding: const EdgeInsets.only(right: 10),
//                           child: Container(
//                               alignment: Alignment.center,
//                               height: 40,
//                               width: 40,
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: AppColors.pinkColor),
//                                 shape: BoxShape.circle,
//                                 color: AppColors.transparentColor,
//                               ),
//                               child: const ImageIcon(
//                                 color: AppColors.pinkColor,
//                                 AssetImage(AppImages.videoCall),
//                               ))),
//                     ),
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
//               height: SizeConfig.screenHeight,
//               width: SizeConfig.screenWidth,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(AppImages.appBackground),
//                       fit: BoxFit.cover)),
//               child: WillPopScope(
//                 child: Column(
//                   children: [
//                       Expanded(
//                           child: ListView.builder(
//                             controller: _scrollController,
//                             shrinkWrap: true,
//                             // itemCount: getOldChatController
//                             //     .oldChatData!.chat!.length,
//                             itemCount: dummyChat.length,
//                             itemBuilder: (context, index) {
//                               if (dummyChat[index].senderId ==
//                                   widget.senderId) {
//
//                                   return Column(
//                                     children: [
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//
//                                       SendDummyMessage(
//                                         message: dummyChat[index].message
//                                             .toString(),
//                                         time: "5:30",
//                                         messageType: dummyChat[index].messageType!.toInt(),
//                                         index: index,
//                                       ),
//                                     ],
//                                   );
//
//                               } else {
//
//                                   return   Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       // Container(
//                                       //   height: 30,
//                                       //   width: 85,
//                                       //   decoration: BoxDecoration(
//                                       //       color: const Color(0xff676767),
//                                       //       borderRadius:
//                                       //       BorderRadius.circular(10)),
//                                       //   alignment: Alignment.center,
//                                       //   child: Text(
//                                       //    " getOldChatController.dateYt[index]",
//                                       //     style: const TextStyle(
//                                       //       fontSize: 16,
//                                       //       fontWeight: FontWeight.w500,
//                                       //       color: Color(0xff9F9F9F),
//                                       //     ),
//                                       //   ),
//                                       // ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       ReceiveDummyMessage(
//                                         message:dummyChat[index].message
//                                             .toString(),
//                                         profileImage: (dummyChat[index].senderId
//                                             .toString() ==
//                                             widget.senderId)
//                                             ? userImage
//                                             : widget.hostImage,
//                                         time: "05:00",
//                                         messageType: dummyChat[index].messageType!.toInt(),
//                                       ),
//                                     ],
//                                   );
//
//                               }
//                             },
//                           ),
//                         ),
//
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(
//                             height: 50,
//                             child: ListView.builder(
//                               itemCount: dummyMessageWithDialog.length,
//                               itemBuilder: (context, index) {
//                                 return GestureDetector(
//                                   onTap: () {
//
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.circular(15),
//                                       border: Border.all(
//                                           color: const Color(0xff767676),
//                                           width: 1),
//                                       color: const Color(0xff2D2B2C),
//                                     ),
//                                     padding: const EdgeInsets.only(
//                                         left: 10, right: 10, top: 2),
//                                     margin: const EdgeInsets.symmetric(
//                                         horizontal: 5),
//                                     child: Text(
//                                         dummyMessageWithDialog[index],
//                                         style: const TextStyle(
//                                             color: Color(0xff767676),
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400)),
//                                   ),
//                                 );
//                               },
//                               scrollDirection: Axis.horizontal,
//                               shrinkWrap: true,
//                               padding: const EdgeInsets.all(10),
//                             ),
//                           ),
//                           Container(
//                             color: AppColors.transparentColor,
//                             padding: const EdgeInsets.only(top: 9),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: Get.width - 60,
//                                   child: Card(
//                                     color: AppColors.optionMessageBorderColor,
//                                     margin: const EdgeInsets.only(
//                                         left: 5, right: 5, bottom: 8),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                         BorderRadius.circular(25)),
//                                     child: TextFormField(
//                                       keyboardAppearance: Brightness.dark,
//                                       focusNode: focusNode,
//                                       minLines: 1,
//                                       maxLines: 5,
//                                       keyboardType: TextInputType.multiline,
//                                       textAlignVertical:
//                                       TextAlignVertical.center,
//                                       controller: _controller,
//                                       autofocus: false,
//                                       autocorrect: false,
//                                       cursorColor: AppColors.messageOptionColor,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize:
//                                         SizeConfig.blockSizeHorizontal * 4,
//                                         color: AppColors.messageOptionColor,
//                                       ),
//                                       decoration: InputDecoration(
//                                         prefixIcon: IconButton(
//                                           onPressed: () {
//                                             focusNode.unfocus();
//                                             focusNode.canRequestFocus = false;
//                                             setState(() {
//                                               emojiShowing = !emojiShowing;
//                                             });
//                                           },
//                                           icon: const Icon(
//                                             Icons.emoji_emotions,
//                                             color: AppColors.messageOptionColor,
//                                           ),
//                                         ),
//                                         suffixIcon: Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 2, right: 2),
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               Get.bottomSheet(Container(
//                                                 height: 200,
//                                                 decoration: const BoxDecoration(
//                                                     color: AppColors
//                                                         .cameraBottomSheetColor,
//                                                     borderRadius:
//                                                     BorderRadius.only(
//                                                         topRight: Radius
//                                                             .circular(22),
//                                                         topLeft:
//                                                         Radius.circular(
//                                                             22))),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(
//                                                       12.0),
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                     crossAxisAlignment:
//                                                     CrossAxisAlignment
//                                                         .center,
//                                                     children: [
//                                                       const SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       const Text(
//                                                         "Select Image From",
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                             FontWeight.w700,
//                                                             color: AppColors
//                                                                 .pinkColor,
//                                                             fontSize: 18),
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 5,
//                                                       ),
//                                                       const Divider(
//                                                         height: 1,
//                                                         color: AppColors
//                                                             .cameraBottomSheetColor,
//                                                         thickness: 0.8,
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 5,
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () =>
//                                                             cameraImage(),
//                                                         child: Container(
//                                                           height: 50,
//                                                           alignment:
//                                                           Alignment.center,
//                                                           decoration:
//                                                           BoxDecoration(
//                                                             borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                 6),
//                                                             color: AppColors
//                                                                 .cameraBottomSheetColor,
//                                                           ),
//                                                           child: const Row(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                             children: [
//                                                               SizedBox(
//                                                                 width: 10,
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 24,
//                                                                 width: 22,
//                                                                 child: ImageIcon(
//                                                                     AssetImage(
//                                                                         AppImages
//                                                                             .messageCamera),
//                                                                     color: Colors
//                                                                         .white),
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 15,
//                                                               ),
//                                                               Text(
//                                                                 "Take a photo",
//                                                                 style:
//                                                                 TextStyle(
//                                                                   fontSize: 14,
//                                                                   fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () =>
//                                                             pickImage(),
//                                                         child: Container(
//                                                           height: 50,
//                                                           alignment:
//                                                           Alignment.center,
//                                                           decoration:
//                                                           BoxDecoration(
//                                                             borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                 6),
//                                                             color: AppColors
//                                                                 .cameraBottomSheetColor,
//                                                           ),
//                                                           child: const Row(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                             children: [
//                                                               SizedBox(
//                                                                 width: 10,
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 24,
//                                                                 width: 22,
//                                                                 child:
//                                                                 ImageIcon(
//                                                                   AssetImage(
//                                                                       AppImages
//                                                                           .messageGellary),
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 15,
//                                                               ),
//                                                               Text(
//                                                                 "Choose From Gallery",
//                                                                 style: TextStyle(
//                                                                     fontSize:
//                                                                     14,
//                                                                     fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                     color: Colors
//                                                                         .white),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ));
//                                             },
//                                             child: const Icon(
//                                               Icons.camera_alt,
//                                               color:
//                                               AppColors.messageOptionColor,
//                                               size: 25,
//                                             ),
//                                           ),
//                                         ),
//                                         border: InputBorder.none,
//                                         contentPadding: const EdgeInsets.all(5),
//                                         hintText: "Message",
//                                         hintStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize:
//                                           SizeConfig.blockSizeHorizontal *
//                                               4,
//                                           color: AppColors.messageOptionColor,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 (isButtonDisabled)
//                                     ? Padding(
//                                   padding:
//                                   const EdgeInsets.only(bottom: 8),
//                                   child: RecordButton(
//                                     controller: animationController,
//                                     chatRoomId: widget.chatRoomId,
//                                     senderId: widget.senderId,
//                                     type: widget.type,
//                                   ),
//                                 )
//                                     : Padding(
//                                   padding: const EdgeInsets.only(
//                                       bottom: 8, right: 5),
//                                   child: CircleAvatar(
//                                     backgroundColor:
//                                     (AppColors.chatBackgroundColor),
//                                     radius: 25,
//                                     child: IconButton(
//                                       onPressed: () {
//                                         if (_controller.text.isNotEmpty) {
//
//                                           _scrollController.jumpTo(
//                                               _scrollController.position
//                                                   .maxScrollExtent);
//                                           setState(() {
//                                             isVisible = true;
//                                           });
//                                           _controller.clear();
//                                         }
//                                       },
//                                       icon: const Icon(
//                                         Icons.send,
//                                         color: AppColors.pinkColor,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Offstage(
//                             offstage: !emojiShowing,
//                             child: SizedBox(
//                               height: 250,
//                               child: EmojiPicker(
//                                 textEditingController: _controller,
//                                 config: const Config(
//                                   columns: 7,
//                                   emojiSizeMax: 32,
//                                   verticalSpacing: 0,
//                                   horizontalSpacing: 0,
//                                   gridPadding: EdgeInsets.zero,
//                                   initCategory: Category.RECENT,
//                                   bgColor: Color(0xFFF2F2F2),
//                                   indicatorColor: Colors.blue,
//                                   iconColor: Colors.grey,
//                                   iconColorSelected: Colors.blue,
//                                   backspaceColor: Colors.blue,
//                                   skinToneDialogBgColor: Colors.white,
//                                   skinToneIndicatorColor: Colors.grey,
//                                   enableSkinTones: true,
//                                   // showRecentsTab: true,
//                                   recentsLimit: 28,
//                                   replaceEmojiOnLimitExceed: false,
//                                   noRecents: Text(
//                                     'No Recent',
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.black26),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   loadingIndicator: SizedBox.shrink(),
//                                   tabIndicatorAnimDuration: kTabScrollDuration,
//                                   categoryIcons: CategoryIcons(),
//                                   buttonMode: ButtonMode.MATERIAL,
//                                   checkPlatformCompatibility: true,
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 onWillPop: () {
//                   if (emojiShowing) {
//                     setState(() {
//                       emojiShowing = false;
//                     });
//                   } else {
//                     Get.back();
//                   }
//                   return Future.value(false);
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
List<GetOldChat> dummyChat = [
  GetOldChat(
    id: '1',
    message: 'Hey there!',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:00:00Z',
    updatedAt: '2024-02-26T08:00:00Z',
  ),
  GetOldChat(
    id: '2',
    message: 'Hi! How are you?',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:01:00Z',
    updatedAt: '2024-02-26T08:01:00Z',
  ),
  GetOldChat(
    id: '3',
    // message: 'I\'m doing well, thanks! How about you?',
    message:
        "https://files.oyebesmartest.com/uploads/large/11577096156cm3q0bw4taekydbfqykgw0yvouc2qlepgeurdgxl8zzkgamjw5lsi1ey5ovte6dntjrpgfakxjq1tbqhri5dfk3feiqcqnnh6vj4.jpg",
    senderId: '10003523557',
    messageType: 0,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:02:00Z',
    updatedAt: '2024-02-26T08:02:00Z',
  ),
  GetOldChat(
    id: '4',
    message: 'I\'m good too, thanks!',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:03:00Z',
    updatedAt: '2024-02-26T08:03:00Z',
  ),
  GetOldChat(
    id: '5',
    message: 'Good morning!',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:04:00Z',
    updatedAt: '2024-02-26T08:04:00Z',
  ),
  GetOldChat(
    id: '6',
    message: 'Morning! How\'s your day going?',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:05:00Z',
    updatedAt: '2024-02-26T08:05:00Z',
  ),
  GetOldChat(
    id: '7',
    message: 'It\'s going great, thanks for asking!',
    senderId: '10003523557',
    messageType: 2,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:06:00Z',
    updatedAt: '2024-02-26T08:06:00Z',
  ),
  GetOldChat(
    id: '8',
    message:
        'https://images.unsplash.com/photo-1619533394727-57d522857f89?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bW9kZWwlMjBtYW58ZW58MHx8MHx8fDA%3D',
    senderId: '1000352355457',
    messageType: 0,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:07:00Z',
    updatedAt: '2024-02-26T08:07:00Z',
  ),
  GetOldChat(
    id: '9',
    message: 'Did you watch the game last night?',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:08:00Z',
    updatedAt: '2024-02-26T08:08:00Z',
  ),
  GetOldChat(
    id: '10',
    message: 'Yes, it was amazing!',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:09:00Z',
    updatedAt: '2024-02-26T08:09:00Z',
  ),
  GetOldChat(
    id: '11',
    message: 'I wish I could have watched it too.',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:10:00Z',
    updatedAt: '2024-02-26T08:10:00Z',
  ),
  GetOldChat(
    id: '12',
    message: 'You missed out on a great match!',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:11:00Z',
    updatedAt: '2024-02-26T08:11:00Z',
  ),
  GetOldChat(
    id: '13',
    message: 'Hey, have you seen the latest episode of that show?',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:12:00Z',
    updatedAt: '2024-02-26T08:12:00Z',
  ),
  GetOldChat(
    id: '14',
    message: 'No, not yet. I plan to watch it tonight.',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:13:00Z',
    updatedAt: '2024-02-26T08:13:00Z',
  ),
  GetOldChat(
    id: '15',
    message: 'It\'s really good, you should watch it!',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:14:00Z',
    updatedAt: '2024-02-26T08:14:00Z',
  ),
  GetOldChat(
    id: '16',
    message: 'I\'ll make sure to do that.',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:15:00Z',
    updatedAt: '2024-02-26T08:15:00Z',
  ),
  GetOldChat(
    id: '17',
    message: 'Did you hear about the new restaurant opening up downtown?',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:16:00Z',
    updatedAt: '2024-02-26T08:16:00Z',
  ),
  GetOldChat(
    id: '18',
    message: 'No, I didn\'t. What\'s it called?',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:17:00Z',
    updatedAt: '2024-02-26T08:17:00Z',
  ),
  GetOldChat(
    id: '19',
    message: 'It\'s called Fusion Bistro.',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:18:00Z',
    updatedAt: '2024-02-26T08:18:00Z',
  ),
  GetOldChat(
    id: '20',
    message: 'Sounds interesting, we should check it out sometime.',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:19:00Z',
    updatedAt: '2024-02-26T08:19:00Z',
  ),
  GetOldChat(
    id: '21',
    message: 'Definitely!',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:20:00Z',
    updatedAt: '2024-02-26T08:20:00Z',
  ),
  GetOldChat(
    id: '22',
    message: 'I\'m heading to the gym now, want to join?',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:21:00Z',
    updatedAt: '2024-02-26T08:21:00Z',
  ),
  GetOldChat(
    id: '23',
    message: 'Sorry, I can\'t. I have a meeting in 30 minutes.',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:22:00Z',
    updatedAt: '2024-02-26T08:22:00Z',
  ),
  GetOldChat(
    id: '24',
    message: 'No problem, maybe next time.',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:23:00Z',
    updatedAt: '2024-02-26T08:23:00Z',
  ),
  GetOldChat(
    id: '25',
    message: 'Hey, did you get the email I sent earlier?',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:24:00Z',
    updatedAt: '2024-02-26T08:24:00Z',
  ),
  GetOldChat(
    id: '26',
    message: 'Yes, I did. I\'ll reply to it soon.',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:25:00Z',
    updatedAt: '2024-02-26T08:25:00Z',
  ),
  GetOldChat(
    id: '27',
    message: 'Great, thanks!',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:26:00Z',
    updatedAt: '2024-02-26T08:26:00Z',
  ),
  GetOldChat(
    id: '28',
    message: 'Are you free for a call later?',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:27:00Z',
    updatedAt: '2024-02-26T08:27:00Z',
  ),
  GetOldChat(
    id: '29',
    message: 'Yes, I should be free after lunch.',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:28:00Z',
    updatedAt: '2024-02-26T08:28:00Z',
  ),
  GetOldChat(
    id: '30',
    message: 'Okay, I\'ll call you then.',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:29:00Z',
    updatedAt: '2024-02-26T08:29:00Z',
  ),
  GetOldChat(
    id: '31',
    message: 'Did you see the news this morning?',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:30:00Z',
    updatedAt: '2024-02-26T08:30:00Z',
  ),
  GetOldChat(
    id: '32',
    message: 'No, I haven\'t had the chance yet.',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:31:00Z',
    updatedAt: '2024-02-26T08:31:00Z',
  ),
  GetOldChat(
    id: '33',
    message: 'There was an earthquake in the neighboring city.',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:32:00Z',
    updatedAt: '2024-02-26T08:32:00Z',
  ),
  GetOldChat(
    id: '34',
    message: 'I hope everyone is safe.',
    senderId: '10003523557',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:33:00Z',
    updatedAt: '2024-02-26T08:33:00Z',
  ),
  GetOldChat(
    id: '35',
    message: 'Yes, let\'s hope so.',
    senderId: '1000352355457',
    messageType: 5,
    type: 0,
    date: '2024-02-26',
    createdAt: '2024-02-26T08:34:00Z',
    updatedAt: '2024-02-26T08:34:00Z',
  ),
];
