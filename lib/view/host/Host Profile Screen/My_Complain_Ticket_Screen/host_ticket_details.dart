import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import '../../../../Api_Service/Complain/host_complain/get_host_complain/get_host_complain_model.dart';

class HostTicketDetails extends StatefulWidget {

  final List<Data> complainData;
  final int index;

  const HostTicketDetails(
      {Key? key,
        required this.complainData,
        required this.index,
       })
      : super(key: key);

  @override
  State<HostTicketDetails> createState() => _HostTicketDetailsState();
}

class _HostTicketDetailsState extends State<HostTicketDetails> {

  GlobalKey<FormState> hostComplaint = GlobalKey<FormState>();

  TextEditingController hostMessageController = TextEditingController();
  TextEditingController hostContactController = TextEditingController();

  File? hostImageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Tickets Details",
          style: TextStyle(
            color: AppColors.pinkColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.appBarColor,
        leading: IconButton(
          splashColor: AppColors.transparentColor,
          highlightColor: AppColors.transparentColor,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.pinkColor,size: 22,),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Container(
          height: height,
          width: width,
          decoration:  const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.appBackground), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:  const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: height / 1.15,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff2A2A2A),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Form(
                            key: hostComplaint,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Number",
                                    style: TextStyle(
                                      color: AppColors.lightPinkColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    width: width,
                                    height: height / 16,
                                    padding: const EdgeInsets.only(left: 10,),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: AppColors.appBarColor,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Text(
                                      widget.complainData[widget.index].contact.toString(),
                                      style: const TextStyle(
                                          color: Color(0xff979797),fontSize: 16,),
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: Text(
                                    "Message",
                                    style: TextStyle(
                                      color: AppColors.lightPinkColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    width: width,
                                    height: height / 5,
                                    padding:
                                    const EdgeInsets.only(
                                        left: 10,
                                      top: 10,
                                      right: 8,
                                    ),
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: AppColors.appBarColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Text(
                                        widget.complainData[widget.index].message.toString(),
                                        style: const TextStyle(
                                            color: Color(0xff979797),fontSize: 16,),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 5,),
                                  child: Text(
                                    "Image",
                                    style: TextStyle(
                                      color: AppColors.lightPinkColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: height / 3,
                                    width: width / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(widget.complainData[widget.index].image.toString()),
                                      )
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    widget.complainData[widget.index].date.toString(),
                                    style: TextStyle(
                                      color: AppColors.lightPinkColor.withOpacity(0.72),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,)
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
