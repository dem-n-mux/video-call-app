import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/update_host_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostEditProfileScreen extends StatefulWidget {
  final String hostProfileImage;

  const HostEditProfileScreen({Key? key, required this.hostProfileImage})
      : super(key: key);

  @override
  State<HostEditProfileScreen> createState() => _HostEditProfileScreenState();
}

class _HostEditProfileScreenState extends State<HostEditProfileScreen> {
  UpdateHostController updateHostController = Get.put(UpdateHostController());

  TextEditingController hostNameController = TextEditingController();
  TextEditingController hostDateOfBirthController = TextEditingController();
  TextEditingController hostBioController = TextEditingController();

  dynamic hostImagePicker;
  dynamic hostType;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String selectedValue = "female";

  // DateTime startDate = DateTime.parse(userDob);
  DateTime startDate = DateTime.now();

  Future<void> _startDatePicket(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
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
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        log(startDate.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    hostImagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    log("startDate:$startDate");
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
            splashColor: AppColors.transparentColor,
            highlightColor: AppColors.transparentColor,
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
                      child: fetchHostImage == null
                          ? Container(
                              height: 115,
                              width: 115,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        widget.hostProfileImage,
                                      ))),
                            )
                          : Container(
                              height: 115,
                              width: 115,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(fetchHostImage!),
                                ),
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var source = hostType == ImageSourceType.camera
                            ? ImageSource.camera
                            : ImageSource.gallery;
                        XFile userImage = await hostImagePicker.pickImage(
                            source: source,
                            imageQuality: 50,
                            preferredCameraDevice: CameraDevice.front);
                        setState(() {
                          fetchHostImage = File(userImage.path);
                          if (fetchHostImage == null) {
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
                        controller: hostNameController,
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
                              "${startDate.toLocal()}".split(' ')[0],
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
                        controller: hostBioController,
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
                                setState(() {
                                  isDisable = false;
                                });
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
                                await updateHostController.updateHost(
                                    hostNameController.text,
                                    hostBioController.text,
                                    selectedValue,
                                    hostDateOfBirthController.text);
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setString(
                                    "userName",
                                    updateHostController
                                        .updateHostData!.host!.name
                                        .toString());
                                preferences.setString(
                                    "userBio",
                                    updateHostController
                                        .updateHostData!.host!.bio
                                        .toString());
                                preferences.setString(
                                    "userImage",
                                    updateHostController
                                        .updateHostData!.host!.image
                                        .toString());
                                preferences.setString(
                                    "getUserDob",
                                    updateHostController
                                        .updateHostData!.host!.dob
                                        .toString());
                                preferences.setString(
                                    "loginUserId",
                                    updateHostController
                                        .updateHostData!.host!.id
                                        .toString());
                                preferences.setString(
                                    "userGender",
                                    updateHostController
                                        .updateHostData!.host!.gender
                                        .toString());
                                userName = preferences.getString("userName")!;
                                userBio = preferences.getString("userBio")!;
                                userImage = preferences.getString("userImage")!;
                                userDob = preferences.getString("getUserDob")!;
                                loginUserId =
                                    preferences.getString("loginUserId")!;
                                userGender =
                                    preferences.getString("userGender")!;
                                Fluttertoast.showToast(
                                  msg: updateHostController
                                      .updateHostData!.message!,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.35),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                selectedIndex = 2;
                                Get.offAll(() =>
                                    const HostBottomNavigationBarScreen());
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
