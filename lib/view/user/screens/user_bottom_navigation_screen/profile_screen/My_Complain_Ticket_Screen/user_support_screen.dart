import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Complain/user_complain/create_user_complain/create_user_complain_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_button.dart';
import 'package:image_picker/image_picker.dart';
import 'user_complain_screen.dart';

class UserSupportScreen extends StatefulWidget {
  const UserSupportScreen({Key? key}) : super(key: key);

  @override
  State<UserSupportScreen> createState() => _UserSupportScreenState();
}

class _UserSupportScreenState extends State<UserSupportScreen> {
  bool isAbsorbing = false;

  TextEditingController userMessageController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();

  CreateUserComplainController createComplainController =
      Get.put(CreateUserComplainController());

  ImagePicker picker = ImagePicker();
  File? userComplainImage1;

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
          "Complaint Or Suggestion",
          style: TextStyle(
            color: AppColors.pinkColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.appBarColor,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.pinkColor,
            size: 22,
          ),
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.appBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 520,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff2A2A2A),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 5,
                                  top: 5,
                                ),
                                child: Text(
                                  "Message",
                                  style: TextStyle(
                                    color: AppColors.lightPinkColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: AppColors.appBarColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  cursorColor: const Color(0xff979797),
                                  controller: userMessageController,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Color(0xff979797),
                                    fontSize: 15,
                                  ),
                                  maxLines: 6,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Enter Your Message Here",
                                    hintStyle: TextStyle(
                                      color: Color(0xff979797),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 5,
                                  top: 5,
                                ),
                                child: Text(
                                  "Contact",
                                  style: TextStyle(
                                    color: AppColors.lightPinkColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: AppColors.appBarColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  cursorColor: const Color(0xff979797),
                                  controller: userEmailController,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Color(0xff979797),
                                    fontSize: 15,
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    // limit the length to 10 characters
                                  ],
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: "Enter Your Mobile Number",
                                    hintStyle: TextStyle(
                                      color: Color(0xff979797),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 5,
                                  top: 5,
                                ),
                                child: Text(
                                  "Attach Your Image or Screenshot",
                                  style: TextStyle(
                                    color: AppColors.lightPinkColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  _getFromGallery();
                                },
                                child: userComplainImage1 == null
                                    ? Container(
                                        height: 150,
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: AppColors.appBarColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 35,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Container(
                                        height: 150,
                                        width: width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                FileImage(userComplainImage1!),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                AbsorbPointer(
                  absorbing: isAbsorbing,
                  child: CommonButton(
                    text: "Submit",
                    onTap: () async {
                      setState(() {

                        isAbsorbing = true;
                        log("==============isAbsorbing is :- $isAbsorbing");
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isAbsorbing = false;
                            log("==============isAbsorbing is :- $isAbsorbing");
                          });
                        });
                      });

                      if (userMessageController.text.isEmpty ||
                          userEmailController.text.isEmpty ||
                          userComplainImage1 == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.transparentColor,
                            duration: Duration(
                              milliseconds: 1000,
                            ),
                            content: Text("Please Enter All Fields",
                                style:
                                    TextStyle(color: AppColors.lightPinkColor)),
                          ),
                        );
                      } else {
                        if (userEmailController.text.toString().length == 10) {
                          await Fluttertoast.showToast(
                            msg: "Please Wait...",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black.withOpacity(0.35),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          await createComplainController.userComplain(
                              message: userMessageController.text.toString(),
                              contact: userEmailController.text.toString(),
                              userId: loginUserId);
                          Get.offAll(() => const UserComplainScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppColors.transparentColor,
                              duration: Duration(
                                milliseconds: 1000,
                              ),
                              content: Text("Please Enter valid mobile number",
                                  style: TextStyle(
                                      color: AppColors.lightPinkColor)),
                            ),
                          );
                        }
                      }
                      // await Fluttertoast.showToast(
                      //   msg: "Please Wait...",
                      //   toastLength: Toast.LENGTH_LONG,
                      //   gravity: ToastGravity.SNACKBAR,
                      //   timeInSecForIosWeb: 1,
                      //   backgroundColor: Colors.black.withOpacity(0.35),
                      //   textColor: Colors.white,
                      //   fontSize: 16.0,
                      // );
                      // setState(() {
                      //   isAbsorbing = true;
                      //   log("==============isAbsorbing is :- $isAbsorbing");
                      //   Future.delayed(const Duration(seconds: 3), () {
                      //     setState(() {
                      //       isAbsorbing = false;
                      //       log("==============isAbsorbing is :- $isAbsorbing");
                      //     });
                      //   });
                      // });

                      // if (userMessageController.text.isEmpty &&
                      //     userEmailController.text.isEmpty) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text("Please Enter All Fields"),
                      //     ),
                      //   );
                      // } else {
                      //   await createComplainController.userComplain(
                      //       userEmailController.text, userMessageController.text,loginUserId);
                      //   Get.offAll(() => const UserComplainScreen());
                      // }
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(
        () {
          userComplainImage = File(image.path);
          userComplainImage1 = File(image.path);
          if (userComplainImage == null) {
          } else {
            setState(() {
              on = true;
            });
          }
          if (kDebugMode) {
            log("That is Image From gallery :- $userComplainImage");
          }
        },
      );
    }
  }
}
