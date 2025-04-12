import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_on_boarding_screen.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_press_button.dart';
import 'package:hokoo_flutter/view/utils/widgets/signup_text_field.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 5.5, SizeConfig.blockSizeVertical * 12,
              SizeConfig.blockSizeHorizontal * 5.5, 20),
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.appBackground), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Fill Your Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 3.5),
                ),
                SignupTextField(
                  onEditingComplete: () => Get.focusScope?.nextFocus(),
                  title: 'Full Name',
                ),
                SignupTextField(
                  onEditingComplete: () => Get.focusScope?.nextFocus(),
                  title: 'Email Address',
                ),
                SignupTextField(
                  onEditingComplete: () => Get.focusScope?.unfocus(),
                  title: 'Password',
                ),
                InkWell(
                  onTap: () {
                    Get.off(() => const UserOnBoardingScreen());
                  },
                  child: CommonPressButton(
                    title: "Next",
                    top: SizeConfig.blockSizeVertical * 7,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
