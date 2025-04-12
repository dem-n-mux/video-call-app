import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/matching_screen/user_matched_calling_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/dummy_host_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UserMatchedScreen extends StatefulWidget {
  final String randomMatchImage;
  final String randomMatchName;
  final String receiverId;
  final String? selectedGenderIs;

  const UserMatchedScreen(
      {Key? key,
      required this.randomMatchImage,
      required this.randomMatchName,
      this.selectedGenderIs,
      required this.receiverId})
      : super(key: key);

  @override
  State<UserMatchedScreen> createState() => _UserMatchedScreenState();
}

class _UserMatchedScreenState extends State<UserMatchedScreen> {
  final String matchName = dummyHostList.first.personName;
  final String matchImage = dummyHostList.first.personImage;

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 4100), () {});
    if (!mounted) return;
    Get.offAll(() => UserMatchedCallingScreen(
          matchName: widget.randomMatchName,
          matchImage: widget.randomMatchImage,
          genderIs: widget.selectedGenderIs,
          receiverId: widget.receiverId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    dummyHostList.shuffle();
    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        selectedIndex = 0;
        Get.offAll(() => const UserBottomNavigationScreen());
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(image: AssetImage(AppImages.appBackground), fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 300,
                    width: Get.width / 1.4,
                    decoration: BoxDecoration(
                      // image: DecorationImage(image: AssetImage(AppImages.appBackground),fit: BoxFit.cover),
                      boxShadow: kElevationToShadow[2],
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.scaffoldColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CircularPercentIndicator(
                          percent: 1,
                          radius: 50,
                          backgroundColor: Colors.white,
                          animation: true,
                          animationDuration: 4000,
                          center: Container(
                            margin: const EdgeInsets.all(3.7),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),clipBehavior: Clip.hardEdge,
                            child: CachedNetworkImage(

                              imageUrl: widget.randomMatchImage,
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
                          progressColor: AppColors.pinkColor,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          widget.randomMatchName,
                          style: const TextStyle(
                            color: AppColors.pinkColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "You like her.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "waiting for her reply",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                //
                // const Padding(
                //   padding: EdgeInsets.only(top: 30),
                //   child: Text(
                //     "Matching for new Friends...",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 18,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: height / 4,
                // ),
                // Stack(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(
                //             right: 80,
                //           ),
                //           child: CircleAvatar(
                //             radius: 55,
                //             backgroundColor: const Color(
                //               0xffD9206B,
                //             ),
                //             child: CircleAvatar(
                //               backgroundColor: Colors.transparent,
                //               backgroundImage: NetworkImage(userProfilePicture
                //               ),
                //               radius: 52,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Padding(
                //           padding: EdgeInsets.only(
                //             left: 80,
                //           ),
                //           child: CircleAvatar(
                //             radius: 55,
                //             backgroundColor: Color(
                //               0xffD9206B,
                //             ),
                //             child: CircleAvatar(
                //               backgroundColor: Colors.transparent,
                //               backgroundImage: NetworkImage(
                //                 AppImages.homeProfileModel1,
                //               ),
                //               radius: 52,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                // const Spacer(),
                // Column(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Get.off(
                //           () => const UserMatchedCallingScreen(),
                //         );
                //       },
                //       child: Container(
                //         margin: const EdgeInsets.symmetric(vertical: 10),
                //         alignment: Alignment.center,
                //         height: height / 16,
                //         width: width / 2.7,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(25),
                //           color: AppColors.pinkColor,
                //             ),
                //         child: const Text("Call Now",
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold)),
                //       ),
                //     ),
                //     TextButton(
                //       onPressed: () {
                //         Get.off(() => const UserSearchingScreen());
                //       },
                //       child: const Text(
                //         "Match again",
                //         style: TextStyle(
                //           fontSize: 16,
                //           color: Color(
                //             0xffFEF1FC,
                //           ),
                //         ),
                //       ),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.only(top: 50,bottom: 15,),
                //       child: Text(
                //         "Go meet people around the world",
                //         style: TextStyle(fontSize: 18, color: Colors.white),
                //       ),
                //     )
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
