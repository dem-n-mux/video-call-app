import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Fetch_Country/Local_Country/fetch_country_controller.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/settings/app_variables.dart';
import '../../utils/settings/models/on_boarding_model.dart';
import '../screens/user_login_screen.dart';


class OnBoardingPages extends StatefulWidget {
  final OnBoarding onBoarding;

  const OnBoardingPages({Key? key, required this.onBoarding}) : super(key: key);

  @override
  State<OnBoardingPages> createState() => _OnBoardingPagesState();
}

class _OnBoardingPagesState extends State<OnBoardingPages> {
  FetchCountryController fetchCountryController =
      Get.put(FetchCountryController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20),
              child: GestureDetector(
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    if (fetchCountry.isEmpty) {
                      ////// fetch country //////
                      await fetchCountryController.fetchCountry();
                      preferences.setString("fetchCountry",
                          jsonEncode(fetchCountryController.fetchCountryData));
                      fetchCountry =
                          jsonDecode(preferences.getString("fetchCountry")!);
                    }
                    preferences.setBool("isOnBoarding", false);
                    isOnBoarding = preferences.getBool("isOnBoarding")!;
                    Get.offAll(() => const UserLoginScreen());
                  },
                  child: const Center(
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 50,
            bottom: 10,
          ),
          height: height / 2.2,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    widget.onBoarding.image,
                  ))),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.onBoarding.titleOne,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.onBoarding.titleTwo,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.onBoarding.subTitle,
                style: TextStyle(
                    color: AppColors.whiteGreyColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            pageController.nextPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
            if (initialIndex == 2) {
              SharedPreferences pref = await SharedPreferences.getInstance();
              if (fetchCountry.isEmpty) {
                ////// fetch country //////
                await fetchCountryController.fetchCountry();
                pref.setString("fetchCountry",
                    jsonEncode(fetchCountryController.fetchCountryData));
                fetchCountry = jsonDecode(pref.getString("fetchCountry")!);
              }
              pref.setBool("isOnBoarding", false);
              isOnBoarding = pref.getBool("isOnBoarding")!;
              Get.offAll(() => const UserLoginScreen());
            }
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 5,
            ),
            height: height / 16,
            width: width,
            decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(25)),
            child: const Text(
              "Next",
              style: TextStyle(
                color: AppColors.lightPinkColor,
                fontWeight: FontWeight.w600,
                fontSize: 21,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
