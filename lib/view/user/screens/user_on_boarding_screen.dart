import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/on_boarding_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import '../pages/on_boarding_pages.dart';

class UserOnBoardingScreen extends StatefulWidget {
  const UserOnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserOnBoardingScreen> createState() => _UserOnBoardingScreenState();
}

class _UserOnBoardingScreenState extends State<UserOnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: Scaffold(
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.appBackground), fit: BoxFit.cover)),
          child: PageView.builder(
            onPageChanged: (int index) {
              setState(() {
                initialIndex = index;
              });
            },
            controller: pageController,
            physics: const PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: onBoardingList.length,
            itemBuilder: (BuildContext context, int index) {
              return OnBoardingPages(
                onBoarding: onBoardingList[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
