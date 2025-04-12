import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/story/controller/host_vise_story_controller.dart';
import 'package:hokoo_flutter/Api_Service/story/model/host_vise_story_model.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';

class HostStoryScreen extends StatefulWidget {
  final List<Story> hostWiseStory;
  final int index;

  const HostStoryScreen({
    Key? key,
    required this.index,
    required this.hostWiseStory,
  }) : super(key: key);

  @override
  State<HostStoryScreen> createState() => _HostStoryScreenState();
}

class _HostStoryScreenState extends State<HostStoryScreen> {
  HostViceStoryController hostViceStoryController =
  Get.put(HostViceStoryController());
  @override
  void initState() {
    hostViceStoryController.fetchHostViceStory(loginUserId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    widget.hostWiseStory[widget.index].image.toString()),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 20, right: 20, bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.blackColor),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      // const Spacer(),
                      // GestureDetector(
                      //   onTap: () {
                      //     showModalBottomSheet(
                      //         shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(25.0),
                      //             topRight: Radius.circular(25.0),
                      //           ),
                      //         ),
                      //         backgroundColor: AppColors.appBarColor,
                      //         barrierColor:
                      //             const Color(0xff383838).withOpacity(0.6),
                      //         context: context,
                      //         builder: (context) {
                      //           return SizedBox(
                      //             height: height / 2.8,
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.center,
                      //               children: [
                      //                 const Padding(
                      //                   padding: EdgeInsets.symmetric(
                      //                       vertical: 60),
                      //                   child: Column(
                      //                     children: [
                      //                       Text(
                      //                         "Are you sure you want to",
                      //                         style: TextStyle(
                      //                           color: AppColors.lightPinkColor,
                      //                           fontWeight: FontWeight.w400,
                      //                           fontSize: 20,
                      //                         ),
                      //                       ),
                      //                       SizedBox(
                      //                         height: 12,
                      //                       ),
                      //                       Text(
                      //                         "delete this story ?",
                      //                         style: TextStyle(
                      //                           color: AppColors.lightPinkColor,
                      //                           fontWeight: FontWeight.w400,
                      //                           fontSize: 20,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 const Spacer(),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: [
                      //                     GestureDetector(
                      //                       child: Container(
                      //                         alignment: Alignment.center,
                      //                         height: height / 16,
                      //                         width: width / 3,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius:
                      //                               BorderRadius.circular(10),
                      //                           color: const Color(0xff3D3D3D),
                      //                         ),
                      //                         child: const Text(
                      //                           "Cancel",
                      //                           style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize: 22,
                      //                             fontWeight: FontWeight.w600,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       onTap: () {
                      //                         Get.back();
                      //                       },
                      //                     ),
                      //                     GestureDetector(
                      //                       onTap: () {
                      //                         setState(() {
                      //                           selectedImage.removeAt(index);
                      //                           selectedIndex = 0;
                      //                           Get.off(() =>
                      //                               const HostBottomNavigationBarScreen());
                      //                         });
                      //                       },
                      //                       child: Container(
                      //                         alignment: Alignment.center,
                      //                         height: height / 16,
                      //                         width: width / 3,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius:
                      //                               BorderRadius.circular(10),
                      //                           color: AppColors.pinkColor,
                      //                         ),
                      //                         child: const Text(
                      //                           "Yes",
                      //                           style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize: 22,
                      //                             fontWeight: FontWeight.w600,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 const SizedBox(
                      //                   height: 30,
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         });
                      //   },
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     height: 40,
                      //     width: 40,
                      //     decoration: const BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: AppColors.blackColor),
                      //     child: Container(
                      //       height: 18,
                      //       width: 18,
                      //       decoration: const BoxDecoration(
                      //         image: DecorationImage(
                      //           image: AssetImage(
                      //             AppImages.delete,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.blackColor,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.hostWiseStory[widget.index].view
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
