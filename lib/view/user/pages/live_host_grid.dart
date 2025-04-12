import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/gift/model/create_gift_category_model.dart';
import 'package:hokoo_flutter/Api_Service/model/host_thumb_list_model.dart';
import 'package:hokoo_flutter/view/Live_Stream/fake_live_page.dart';
import 'package:hokoo_flutter/view/Live_Stream/participant.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/home_screen/user_home_profile_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';
import '../../utils/settings/app_colors.dart';
import '../../utils/settings/app_variables.dart';

class OnlineHostGrid extends StatefulWidget {
  final CreateGiftCategoryModel? createGiftCategoryModel;
  final List<Host> hostData;
  final int index;

  const OnlineHostGrid({
    Key? key,
    required this.hostData,
    required this.index,
    this.createGiftCategoryModel,
  }) : super(key: key);

  @override
  State<OnlineHostGrid> createState() => _OnlineHostGridState();
}

class _OnlineHostGridState extends State<OnlineHostGrid> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () async {
        /// host id
        hostId = widget.hostData[widget.index].id.toString();
        setState(() {
          switchPage = true;
          isProfile = true;
        });

        if (widget.hostData[widget.index].isFake.toString() == "true") {
          if (widget.hostData[widget.index].status.toString() == "Live") {
            Get.to(() => FakeLivePage(
                  videoUrl: widget.hostData[widget.index].channel.toString(),
                  name: widget.hostData[widget.index].name.toString(),
                  coin: widget.hostData[widget.index].coin.toString(),
                  image: widget.hostData[widget.index].image.toString(),
                  country: widget.hostData[widget.index].country.toString(),
                  age: widget.hostData[widget.index].age.toString(),
                ));
          } else {
            Get.off(
              () => UserHomeProfileScreen(
                hostData: widget.hostData,
                index: widget.index,
                token: widget.hostData[widget.index].token.toString(),
                channel: widget.hostData[widget.index].channel.toString(),
                hostId: widget.hostData[widget.index].id.toString(),
                userId: loginUserId,
              ),
            );
          }
        } else if (widget.hostData[widget.index].status.toString() == "Live") {
          Get.to(() => Participant(
                clientRole: ClientRole.Audience,
                token: widget.hostData[widget.index].token.toString(),
                channelName: widget.hostData[widget.index].channel.toString(),
                liveStreamingId: widget.hostData[widget.index].liveStreamingId.toString(),
                hostname: widget.hostData[widget.index].name.toString(),
                hostImage: widget.hostData[widget.index].image.toString(),
                hostId: widget.hostData[widget.index].id.toString(),
              ));
        } else {
          Get.off(
            () => UserHomeProfileScreen(
              hostData: widget.hostData,
              index: widget.index,
              token: widget.hostData[widget.index].token.toString(),
              channel: widget.hostData[widget.index].channel.toString(),
              hostId: widget.hostData[widget.index].id.toString(),
              userId: loginUserId,
            ),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // image: DecorationImage(
              //     image: NetworkImage(widget.hostData[widget.index].image.toString()), fit: BoxFit.cover),
            ),
            foregroundDecoration: BoxDecoration(
              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                AppColors.transparentColor,
                AppColors.transparentColor,
                Colors.black12,
                Colors.black26,
                Colors.black38,
                Colors.black45,
                Colors.black54,
                Colors.black87
              ]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: AspectRatio(
              aspectRatio: 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: widget.hostData[widget.index].image.toString(),
                  errorWidget: (context, url, error) {
                    return Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: Center(child: Image.asset(AppIcons.logoPlaceholder)));
                  },
                  placeholder: (context, url) {
                    return Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: Center(child: Image.asset(AppIcons.logoPlaceholder)));
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    alignment: Alignment.center,
                    height: SizeConfig.blockSizeVertical * 3,
                    width: SizeConfig.blockSizeHorizontal * 17,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black.withOpacity(0.6)

                            // (widget.hostData[widget.index].status.toString() !=
                            //         "Online")
                            //     ? Colors.transparent
                            //     : Colors.black.withOpacity(0.6)
                            ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (widget.hostData[widget.index].status.toString() == 'Live')
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: SizedBox(
                                  height: 10,
                                  width: 13,
                                  child: Lottie.asset(
                                    AppLottie.liveLottie,
                                    fit: BoxFit.cover,
                                    repeat: true,
                                    reverse: true,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: SizeConfig.blockSizeHorizontal * 1,
                                backgroundColor: (widget.hostData[widget.index].status.toString() == "Online")
                                    ? AppColors.onlineColor
                                    : (widget.hostData[widget.index].status.toString() == "Busy")
                                        ? Colors.red
                                        : (widget.hostData[widget.index].status.toString() == "Live")
                                            ? AppColors.pinkColor
                                            : AppColors.transparentColor,
                              ),
                        (widget.hostData[widget.index].status.toString() == 'Online')
                            ? SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.2,
                              )
                            : SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                        Text(
                          widget.hostData[widget.index].status.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.blockSizeHorizontal * 3),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(right: 10, top: 10),
          Positioned(
            left: 10,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hostData[widget.index].name.toString(),
                  style: TextStyle(
                      color: Colors.white, fontSize: SizeConfig.blockSizeHorizontal * 4.5, fontWeight: FontWeight.w900),
                ),
                Text(
                  "${widget.hostData[widget.index].country??"India"}, ${widget.hostData[widget.index].age}",
                  style: TextStyle(
                      color: const Color(0xffE5E5E5),
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
