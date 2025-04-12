import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/view/Chat_Screen/chat_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import '../../../../../Api_Service/search/search_user/modal/user_search_model.dart';

class SearchMessageList extends StatefulWidget {
  final int index;
  final List<Data> data;

  const SearchMessageList({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  @override
  State<SearchMessageList> createState() => _SearchMessageListState();
}

class _SearchMessageListState extends State<SearchMessageList> {
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () async {
        await createChatRoomController.createChatRoom(loginUserId, widget.data[widget.index].id.toString());
        if (createChatRoomController.createChatRoomData?.status == true) {
          Get.off(() => ChatScreen(
                hostName: widget.data[widget.index].name.toString(),
                chatRoomId: createChatRoomController.createChatRoomData!.chatTopic!.id.toString(),
                senderId: createChatRoomController.createChatRoomData!.chatTopic!.userId.toString(),
                hostImage: widget.data[widget.index].image.toString(),
                receiverId: createChatRoomController.createChatRoomData!.chatTopic!.hostId.toString(),
                screenType: 'UserScreen',
                type: 1,
                callType: 'user',
              ));
        } else {
          Fluttertoast.showToast(msg: createChatRoomController.createChatRoomData?.message.toString() ?? "");
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 1,
            right: SizeConfig.blockSizeHorizontal * 2.5,
            left: SizeConfig.blockSizeHorizontal * 2.5),
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade900,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(widget.data[widget.index].image.toString()), fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data[widget.index].name.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
                        Text(
                          widget.data[widget.index].message.toString(),
                          style: TextStyle(
                            color: AppColors.pinkColor,
                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.data[widget.index].time.toString(),
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 1.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff717171),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
