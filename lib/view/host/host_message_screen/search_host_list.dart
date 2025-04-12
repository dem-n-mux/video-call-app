import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/view/Chat_Screen/chat_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import '../../../Api_Service/search/search_host/host_search_model.dart';

class SearchHostDataList extends StatefulWidget {
  final int index;
  final List<Data> data;

  const SearchHostDataList({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  @override
  State<SearchHostDataList> createState() => _SearchHostDataListState();
}

class _SearchHostDataListState extends State<SearchHostDataList> {
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());

  // @override
  // void initState() {
  //   createChatRoomController.createChatRoom(widget.data[widget.index].id.toString(), loginUserId);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () async {
        await createChatRoomController.createChatRoom(widget.data[widget.index].id.toString(), loginUserId);
        if (createChatRoomController.createChatRoomData?.status == true) {
          Get.off(() => ChatScreen(
                hostName: widget.data[widget.index].name.toString(),
                chatRoomId: createChatRoomController.createChatRoomData!.chatTopic!.id.toString(),
                senderId: createChatRoomController.createChatRoomData!.chatTopic!.hostId.toString(),
                hostImage: widget.data[widget.index].image.toString(),
                receiverId: createChatRoomController.createChatRoomData!.chatTopic!.userId.toString(),
                screenType: 'HostScreen',
                type: 0,
                callType: 'host',
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade900,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                widget.data[widget.index].image.toString(),
              ),
            ),
            title: Text(
              widget.data[widget.index].name.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeVertical * 2,
              ),
            ),
            subtitle: Text(
              widget.data[widget.index].message.toString(),
              style: TextStyle(
                color: AppColors.pinkColor,
                fontSize: SizeConfig.blockSizeVertical * 1.5,
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
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
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  // (widget.chatThumb[widget.index].count.toString() == "0")
                  //     ? const SizedBox()
                  //     : Container(
                  //   alignment: Alignment.center,
                  //   height: SizeConfig.blockSizeVertical * 2.9,
                  //   width: SizeConfig.blockSizeHorizontal * 6.1,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: const Color(0xffD97998),
                  //   ),
                  //   child: Text(
                  //     widget.chatThumb[widget.index].count.toString(),
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: SizeConfig.blockSizeVertical * 1.4,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
