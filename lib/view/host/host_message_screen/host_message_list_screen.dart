import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/Api_Service/chat/model/chat_thumb_model.dart';
import 'package:hokoo_flutter/Api_Service/controller/setting_controller.dart';
import 'package:hokoo_flutter/view/Chat_Screen/chat_screen.dart';
import 'package:hokoo_flutter/view/Chat_Screen/fake_chat/fake_chat_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';

class HostMessageListScreen extends StatefulWidget {
  final int index;
  final List<ChatList> chatThumb;

  const HostMessageListScreen({
    Key? key,
    required this.index,
    required this.chatThumb,
  }) : super(key: key);

  @override
  State<HostMessageListScreen> createState() => _HostMessageListScreenState();
}

class _HostMessageListScreenState extends State<HostMessageListScreen> {
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());
  SettingController settingController = Get.put(SettingController());
  @override
  void initState() {
    settingController.setting();
    // createChatRoomController.createChatRoom(widget.chatThumb[widget.index].id.toString(), loginUserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () async {
        if (widget.chatThumb[widget.index].isFake ?? false) {
          await createChatRoomController.createChatRoom(widget.chatThumb[widget.index].id.toString(), loginUserId);
          if (createChatRoomController.createChatRoomData?.status == true) {
            Get.to(() => FakeChatScreen(
                  hostName: widget.chatThumb[widget.index].name.toString(),
                  chatRoomId: createChatRoomController.createChatRoomData!.chatTopic!.id.toString(),
                  senderId: loginUserId,
                  hostImage: widget.chatThumb[widget.index].image.toString(),
                  receiverId: createChatRoomController.createChatRoomData!.chatTopic!.userId.toString(),
                  screenType: 'HostScreen',
                  type: 0,
                  callType: 'host',
                  videoUrl: widget.chatThumb[widget.index].video.toString(),
                ));
          } else {
            Fluttertoast.showToast(msg: createChatRoomController.createChatRoomData?.message.toString() ?? "");
          }
        } else {
          await createChatRoomController.createChatRoom(widget.chatThumb[widget.index].id.toString(), loginUserId);
          if (createChatRoomController.createChatRoomData?.status == true) {
            Get.off(() => ChatScreen(
                  hostName: widget.chatThumb[widget.index].name.toString(),
                  chatRoomId: createChatRoomController.createChatRoomData!.chatTopic!.id.toString(),
                  senderId: createChatRoomController.createChatRoomData!.chatTopic!.hostId.toString(),
                  hostImage: widget.chatThumb[widget.index].image.toString(),
                  receiverId: createChatRoomController.createChatRoomData!.chatTopic!.userId.toString(),
                  screenType: 'HostScreen',
                  type: 0,
                  callType: 'host',
                ));
          } else {
            Fluttertoast.showToast(msg: createChatRoomController.createChatRoomData?.message.toString() ?? "");
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 1,
            right: SizeConfig.blockSizeHorizontal * 2.5,
            left: SizeConfig.blockSizeHorizontal * 2.5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade900,
          ),
          child: ListTile(
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff343434)),
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: widget.chatThumb[widget.index].image.toString(),
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Center(
                    child: Image.asset(
                      AppIcons.userPlaceholder,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Center(
                    child: Image.asset(
                      AppIcons.userPlaceholder,
                    ),
                  );
                },
              ),
            ),
            title: Text(
              widget.chatThumb[widget.index].name.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeVertical * 2,
              ),
            ),
            subtitle: SizedBox(
              height: 16,
              child: Text(
                widget.chatThumb[widget.index].message.toString(),
                style: const TextStyle(
                  color: AppColors.pinkColor,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                ),
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.chatThumb[widget.index].time.toString(),
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 1.5,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff717171),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  (widget.chatThumb[widget.index].count.toString() == "0")
                      ? const SizedBox()
                      : Container(
                          alignment: Alignment.center,
                          height: SizeConfig.blockSizeVertical * 2.9,
                          width: SizeConfig.blockSizeHorizontal * 6.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffD97998),
                          ),
                          child: Text(
                            widget.chatThumb[widget.index].count.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.blockSizeVertical * 1.4,
                              color: Colors.white,
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
