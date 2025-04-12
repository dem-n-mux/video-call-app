import 'dart:io';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/host_request_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/progress_dialog.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_button.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UserHostRequestScreen extends StatefulWidget {
  const UserHostRequestScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserHostRequestScreen> createState() => _UserHostRequestScreenState();
}

class _UserHostRequestScreenState extends State<UserHostRequestScreen> {
  HostRequestController hostRequestController = Get.put(HostRequestController());
  TextEditingController selfIntroduction = TextEditingController();
  ImagePicker picker = ImagePicker();
  Image? videoThumbnail;
  List<File> selectedImage = [];
  RxBool isShowVideo = false.obs;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ProgressDialog(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: AppColors.transparentColor,
            appBar: AppBar(
              backgroundColor: AppColors.appBarColor,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                splashColor: AppColors.transparentColor,
                highlightColor: AppColors.transparentColor,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AppColors.pinkColor,
                  size: 22,
                ),
              ),
              title: const Text(
                "Host Center",
                style: TextStyle(
                  color: AppColors.pinkColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: SafeArea(
                child: Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.appBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          // height: SizeConfig.screenHeight,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff343434),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 12,
                              right: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "1. Self-introduction Photos",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Please upload your real picture. Also the 1st picture will be used as the cover photo of the dating hosts list. (You cannot upload landscape photos, physical, animal photos, comics and blurred images.)",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    height: 137,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await _getHostGallery().then(
                                              (value) {
                                                log("value ::: $value");
                                                selectedImage.add(hostRequestImage!);
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: const DecorationImage(
                                                  fit: BoxFit.fill, image: AssetImage(AppImages.hostImage)),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Color(0xff959595),
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: selectedImage.length,
                                              separatorBuilder: (context, index) {
                                                return const SizedBox(
                                                  width: 10,
                                                );
                                              },
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(
                                                        selectedImage[index],
                                                      ),
                                                    ),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedImage.removeAt(index);
                                                      });
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 7,
                                                        right: 5,
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment.topRight,
                                                        child: Icon(
                                                          Icons.close_outlined,
                                                          size: 25,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "2. Video Introduction",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Make an awesome 1st impression with the video that introduces you. Share the true you and tell us who you are, what's your location, what do you do, your interests etc.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    height: 137,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _getHostGalleryForVideo();
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: videoThumbnail != null
                                                  ? DecorationImage(
                                                      image: videoThumbnail!.image, // Use the video thumbnail image
                                                      fit: BoxFit.cover, // Set the cover aspect ratio
                                                    )
                                                  : const DecorationImage(
                                                      fit: BoxFit.fill, // You can customize this for the "Add" icon
                                                      image: AssetImage(AppImages.hostImage),
                                                    ),
                                            ),
                                            child: Obx(
                                              () => isShowVideo.value
                                                  ? const Center(child: CupertinoActivityIndicator())
                                                  : videoThumbnail == null
                                                      ? const Icon(
                                                          Icons.add,
                                                          color: Color(0xff959595),
                                                          size: 30,
                                                        )
                                                      : const SizedBox.shrink(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "4. Self-introducation",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Please briefly introduce your characteristics to attract others to date you.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: AppColors.appBarColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextFormField(
                                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                                    cursorColor: AppColors.lightPinkColor,
                                    controller: selfIntroduction,
                                    style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: AppColors.lightPinkColor,
                                      fontSize: 16,
                                    ),
                                    maxLines: 7,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15, top: 10),
                                      border: InputBorder.none,
                                      hintText: "Tell us about yourself...",
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff343434),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ).paddingOnly(bottom: 15),
                              ],
                            ),
                          ),
                        ),
                        CommonButton(
                          text: "Done",
                          onTap: (isDisable)
                              ? () async {
                                  isLoading = true;
                                  setState(() {});
                                  // await Fluttertoast.showToast(
                                  //   msg: "Please Wait...",
                                  //   toastLength: Toast.LENGTH_SHORT,
                                  //   gravity: ToastGravity.SNACKBAR,
                                  //   timeInSecForIosWeb: 1,
                                  //   backgroundColor: Colors.black.withOpacity(0.35),
                                  //   textColor: Colors.white,
                                  //   fontSize: 16.0,
                                  // );
                                  if (hostRequestImage == null) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: AppColors.appBarColor,
                                        content: Text(
                                          "Please Select Image",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                    setState(() {});
                                    isLoading = false;
                                  } else if (selfIntroduction.text.isEmpty) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: AppColors.appBarColor,
                                        content: Text(
                                          "Please enter your bio..",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                    setState(() {});
                                    isLoading = false;
                                  } else {
                                    isLoading = true;
                                    await hostRequestController.sendHostRequest(
                                        selfIntroduction.text, fetchCountry["country"] ?? "india");
                                    await Fluttertoast.showToast(
                                      msg: hostRequestController.hostRequestData?.message ?? "",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black.withOpacity(0.35),
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    selfIntroduction.clear();
                                    Get.back();
                                    setState(() {});
                                    isLoading = false;
                                  }
                                }
                              : () {},
                        ).paddingSymmetric(vertical: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _getHostGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        hostRequestImage = File(image.path);
        if (kDebugMode) {
          log("That is Image From gallery :- $hostRequestImage");
        }
      });
    } else {
      log("Please Select Image");
    }
  }

  _getHostGalleryForVideo() async {
    videoThumbnail = null;
    XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    try {
      if (video != null) {
        File videoFile = File(video.path);
        int fileSizeInBytes = await videoFile.length();
        if (fileSizeInBytes <= 30 * 1024 * 1024) {
          isShowVideo(true);
          hostRequestVideo = videoFile;
          await _generateVideoThumbnail(hostRequestVideo!);
          isShowVideo(false);
        } else {
          Fluttertoast.showToast(
            msg: "Please choose a video under 30 MB",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black.withOpacity(0.35),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        log("Please Select Video");
      }
    } catch (e) {
      log("Error is :: $e");
    }
  }

  Future<void> _generateVideoThumbnail(File videoFile) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
      maxWidth: 300,
      maxHeight: 450,
    );

    setState(() {
      videoThumbnail = Image.file(File(thumbnailPath!));
    });
  }
}
