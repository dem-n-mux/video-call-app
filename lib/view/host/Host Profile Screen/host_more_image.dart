import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/album/controller/delete_album_controoller.dart';
import 'package:hokoo_flutter/Api_Service/controller/get_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/model/get_host_model.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:lottie/lottie.dart';

class HostMoreImage extends StatefulWidget {
  final GetHostModel getHostModel;

  const HostMoreImage({Key? key, required this.getHostModel}) : super(key: key);

  @override
  State<HostMoreImage> createState() => _HostMoreImageState();
}

class _HostMoreImageState extends State<HostMoreImage> {
  DeleteAlbumController deleteAlbumController = Get.put(DeleteAlbumController());
  GetHostController getHostController = Get.put(GetHostController());

  // @override
  // void initState() {
  //   getHostController.getHost(loginUserId);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.appBarColor,
          leading: IconButton(
              highlightColor: AppColors.transparentColor,
              splashColor: AppColors.transparentColor,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.pinkColor,
                size: 22,
              )),
          title: const Text(
            "Images",
            style: TextStyle(
              color: AppColors.pinkColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: Obx(() {
          if (getHostController.isLoading.value) {
            return Container(
                alignment: Alignment.center,
                height: height,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          AppImages.appBackground,
                        ))),
                child: Lottie.asset(
                  width: 100,
                  height: 100,
                  repeat: true,
                  AppLottie.loadingLottie,
                ));
          } else {
            return Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        AppImages.appBackground,
                      ))),
              child: Column(
                children: [
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: SizedBox(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: getHostController.getHostData!.host!.album!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 140,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  getHostController.getHostData!.host!.album![index],
                                ),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                log("++++++++++++$index++++++++++++++${getHostController.getHostData!.host!.album![index].length}");
                                await deleteAlbumController.getDeleteAlbumData(loginUserId, index.toString());
                                await getHostController.getHost(loginUserId);
                                hostCoin.value = getHostController.getHostData?.host?.coin.toString() ?? "0";

                                setState(() {
                                  visibleHost = !visibleHost;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, right: 3),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: AppColors.blackColor.withOpacity(0.4)),
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            AppImages.delete,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }

// _getHostGallery() async {
//   PickedFile? pickedFile = await ImagePicker().getImage(
//     source: ImageSource.gallery,
//   );
//   if (pickedFile != null) {
//     setState(() {
//       hostProfileImage = File(pickedFile.path);
//       if (kDebugMode) {
//         log("That is Image From gallery :- $hostProfileImage");
//       }
//     });
//   }
// }
}
