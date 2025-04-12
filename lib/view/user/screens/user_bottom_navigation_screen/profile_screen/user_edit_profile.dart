import  'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/update_user_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../user_bottom_navigation_screen.dart';

class UserEditProfileScreen extends StatefulWidget {
  final String userProfileImage;

  const UserEditProfileScreen({Key? key, required this.userProfileImage})
      : super(key: key);

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  UpdateUserController updateUserController = Get.put(UpdateUserController());

  TextEditingController userNameController = TextEditingController();
  TextEditingController userDateOfBirthController = TextEditingController();
  TextEditingController userBioController = TextEditingController();

  dynamic userImagePicker;
  dynamic userType;
  String? gender;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String selectedValue = "female";

  DateTime dateOfBirth = DateTime.parse(userDob);

  Future<void> _startDatePicket(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateOfBirth,
        helpText: "Select Date of Birth",
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.pinkColor,
                onPrimary: Colors.white,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.black,
            ),
            child: child!,
          );
        },
        firstDate: DateTime(1950),
        lastDate: DateTime(2300));
    if (picked != null && picked != dateOfBirth) {
      setState(() {
        dateOfBirth = picked;
        log(dateOfBirth.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userImagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    // final updateProfile = Provider.of<UpdateUserProvider>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          centerTitle: true,
          elevation: 0,
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
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              color: AppColors.pinkColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      alignment: Alignment.center,
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.pinkColor,
                              Colors.black,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: getUserProfileImage == null
                          ?  Container(
                        height: 115,
                        width: 115,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          // image: DecorationImage(image: NetworkImage(userImage), fit: BoxFit.cover)
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: widget.userProfileImage,
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
                      )
                          : Container(
                              height: 115,
                              width: 115,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(getUserProfileImage!),
                                ),
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var source = userType == ImageSourceType.camera
                            ? ImageSource.camera
                            : ImageSource.gallery;
                        XFile userImage = await userImagePicker.pickImage(
                            source: source,
                            imageQuality: 50,
                            preferredCameraDevice: CameraDevice.front);
                        setState(() {
                          getUserProfileImage = File(userImage.path);
                          if (getUserProfileImage == null) {
                          } else {
                            setState(() {
                              on = true;
                            });
                          }
                        });
                      },
                      child: const Text(
                        "Change Photo",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: AppColors.lightPinkColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: const Color(0xff343434).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        maxLength: 20,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                        textInputAction: TextInputAction.next,
                        cursorColor: const Color(0xff5B5C5F).withOpacity(0.2),
                        controller: userNameController,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: const Color(0xff818892).withOpacity(0.6),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        decoration: InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          hintText: userName,
                          hintStyle: TextStyle(
                            color: const Color(0xff818892).withOpacity(0.6),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff343434).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField2(
                        barrierColor: Colors.transparent,
                        decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 12)),
                        isExpanded: true,
                        hint: Text(
                          userGender,
                          style: TextStyle(
                            color: const Color(0xff818892).withOpacity(0.6),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        items: genderItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: const Color(0xff818892)
                                        .withOpacity(0.6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          selectedValue = value.toString();
                          log(selectedValue.toString());
                        },
                        onSaved: (value) {
                          selectedValue = value.toString();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        _startDatePicket(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: const Color(0xff343434).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${dateOfBirth.toLocal()}".split(' ')[0],
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: const Color(0xff818892).withOpacity(0.6),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // child: TextFormField(
                        //   keyboardType: TextInputType.number,
                        //   onEditingComplete: () =>
                        //       FocusScope.of(context).nextFocus(),
                        //   textInputAction: TextInputAction.next,
                        //   cursorColor: const Color(0xff5B5C5F).withOpacity(0.2),
                        //   controller: userDateOfBirthController,
                        //   style: TextStyle(
                        //     decoration: TextDecoration.none,
                        //     color: const Color(0xff818892).withOpacity(0.6),
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        //   maxLines: 1,
                        //   decoration: InputDecoration(
                        //     border: InputBorder.none,
                        //     hintText: userDob,
                        //     hintStyle: TextStyle(
                        //       color: const Color(0xff818892).withOpacity(0.6),
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: const Color(0xff343434).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                        textInputAction: TextInputAction.next,
                        cursorColor: const Color(0xff5B5C5F).withOpacity(0.2),
                        controller: userBioController,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: const Color(0xff818892).withOpacity(0.6),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 6,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: userBio,
                          hintStyle: TextStyle(
                            color: const Color(0xff818892).withOpacity(0.6),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CommonButton(
                        text: "Save",
                        onTap: (isDisable)
                            ? () async {
                                await Fluttertoast.showToast(
                                  msg: "Please Wait...",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.35),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                setState(() {
                                  isDisable = false;
                                });
                                await updateUserController.updateUser(
                                    userNameController.text,
                                    userBioController.text,
                                    selectedValue,
                                    dateOfBirth.toString());
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setString(
                                    "userName",
                                    updateUserController
                                        .updateUserData!.user!.name
                                        .toString());
                                preferences.setString(
                                    "userBio",
                                    updateUserController
                                        .updateUserData!.user!.bio
                                        .toString());
                                preferences.setString(
                                    "userName",
                                    updateUserController
                                        .updateUserData!.user!.name
                                        .toString());
                                preferences.setString(
                                    "getUserDob",
                                    updateUserController
                                        .updateUserData!.user!.dob
                                        .toString());
                                preferences.setString(
                                    "loginUserId",
                                    updateUserController
                                        .updateUserData!.user!.id
                                        .toString());
                                preferences.setString(
                                    "getUserGender",
                                    updateUserController
                                        .updateUserData!.user!.gender
                                        .toString());
                                userName =
                                    preferences.getString("userName")!;
                                userBio = preferences.getString("userBio")!;
                                userImage =
                                    preferences.getString("userName")!;
                                userDob = preferences.getString("getUserDob")!;
                                loginUserId =
                                    preferences.getString("loginUserId")!;
                                userGender =
                                    preferences.getString("getUserGender")!;
                                Fluttertoast.showToast(
                                  msg: updateUserController
                                      .updateUserData!.message!,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.35),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                selectedIndex = 3;
                                Get.offAll(
                                    () => const UserBottomNavigationScreen());
                              }
                            : () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
