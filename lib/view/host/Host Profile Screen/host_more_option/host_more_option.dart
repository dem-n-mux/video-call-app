import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Profile%20Screen/host_more_option/host_privacy_policy.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/models/more_option_model.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'host_about_us.dart';

class HostMoreOptionScreen extends StatefulWidget {
  const HostMoreOptionScreen({Key? key}) : super(key: key);

  @override
  State<HostMoreOptionScreen> createState() => _HostMoreOptionScreenState();
}

class _HostMoreOptionScreenState extends State<HostMoreOptionScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<HostMoreOptionModel> hostMoreOptionList = [
      // HostMoreOptionModel(
      //   container: Container(
      //     alignment: Alignment.center,
      //     height: height / 19.5,
      //     width: width / 9.5,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(10),
      //       color: const Color(0xff8D8D8D).withOpacity(0.2),
      //     ),
      //     child: SizedBox(
      //         height: 25, width: 25, child: Image.asset(AppImages.info)),
      //   ),
      //   name: "Personal Information",
      //   onTap: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return Dialog(
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           child: Container(
      //             height: 300,
      //             decoration: BoxDecoration(
      //               color: Colors.black,
      //               borderRadius: BorderRadius.circular(20),
      //             ),
      //             child: Column(
      //               children: [
      //                 const SizedBox(
      //                   height: 25,
      //                 ),
      //                 const Text(
      //                   "Personal Information",
      //                   style: TextStyle(
      //                     color: AppColors.pinkColor,
      //                     fontSize: 22,
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 15,
      //                 ),
      //                 Container(
      //                   margin: const EdgeInsets.only(
      //                     top: 10,
      //                   ),
      //                   alignment: Alignment.center,
      //                   height: 110,
      //                   width: 110,
      //                   decoration: const BoxDecoration(
      //                       shape: BoxShape.circle,
      //                       gradient: LinearGradient(
      //                         colors: [
      //                           AppColors.pinkColor,
      //                           AppColors.pinkColor,
      //                           Colors.transparent,
      //                         ],
      //                         begin: Alignment.topLeft,
      //                         end: Alignment.bottomRight,
      //                       )),
      //                   child: Container(
      //                     height: 105,
      //                     width: 105,
      //                     decoration: BoxDecoration(
      //                       shape: BoxShape.circle,
      //                       image: DecorationImage(
      //                         image: NetworkImage(
      //                           loginHostImage,
      //                         ),
      //                         fit: BoxFit.cover,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 15,
      //                 ),
      //                 Text(
      //                   "ID :- $hostUniqueId",
      //                   style: const TextStyle(
      //                     fontWeight: FontWeight.w600,
      //                     fontSize: 18,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 15,
      //                 ),
      //                 Text(
      //                   "Password :- $hostPassword",
      //                   style: const TextStyle(
      //                     fontWeight: FontWeight.w600,
      //                     fontSize: 18,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      HostMoreOptionModel(
        container: Container(
          alignment: Alignment.center,
          height: height / 19.5,
          width: width / 9.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff6DF3A9).withOpacity(0.2),
          ),
          child: SizedBox(
              height: 25, width: 25, child: Image.asset(AppImages.aboutUs)),
        ),
        name: "About Us",
        onTap: () {
          Get.to(() => const HostAboutUsScreen());
        },
      ),
      HostMoreOptionModel(
        container: Container(
          alignment: Alignment.center,
          height: height / 19.5,
          width: width / 9.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffFFD300).withOpacity(0.2),
          ),
          child: SizedBox(
            height: 25,
            width: 25,
            child: Image.asset(
              AppImages.shareUs,
            ),
          ),
        ),
        name: "Share Us",
        onTap: () {
          Share.share(
            "Hello MyVideoApp",
          );
        },
      ),
      HostMoreOptionModel(
        container: Container(
          alignment: Alignment.center,
          height: height / 19.5,
          width: width / 9.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffFF9473).withOpacity(0.2),
          ),
          child: SizedBox(
              height: 25, width: 25, child: Image.asset(AppImages.rateUs)),
        ),
        name: "Rate Us",
        onTap: () {
          StoreRedirect.redirect(
            androidAppId: "com.zhiliaoapp.musically",
          );
        },
      ),
      HostMoreOptionModel(
        container: Container(
          alignment: Alignment.center,
          height: height / 19.5,
          width: width / 9.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff36C79B).withOpacity(0.2),
          ),
          child: SizedBox(
            height: 25,
            width: 25,
            child: Image.asset(AppImages.privacyPolicy),
          ),
        ),
        name: "Privacy Policy",
        onTap: () {
          Get.to(() => const HostPrivacyPolicyScreen());
        },
      ),
    ];

    return IconButton(
      splashColor: AppColors.transparentColor,
      highlightColor: AppColors.transparentColor,
      onPressed: () {
        showModalBottomSheet(
          barrierColor: const Color(0xff343434).withOpacity(0.6),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          backgroundColor: AppColors.appBarColor,
          context: context,
          builder: (context) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: SizedBox(
                height: Get.height / 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "More Option",
                          style: TextStyle(
                            color: AppColors.pinkColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: hostMoreOptionList.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 15, left: 15),
                            child: Container(
                              alignment: Alignment.center,
                              height: height / 13,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade900,
                              ),
                              child: ListTile(
                                onTap: hostMoreOptionList[i].onTap,
                                leading: hostMoreOptionList[i].container,
                                title: Text(
                                  hostMoreOptionList[i].name,
                                  style: const TextStyle(
                                    color: AppColors.lightPinkColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 20,
                                  color: AppColors.lightPinkColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.more_vert,
        color: AppColors.pinkColor,
        size: 32,
      ),
    );
  }
}
