
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';


class OnBoarding{

  final String titleOne;
  final String titleTwo;
  final String subTitle;
  final String image;

  OnBoarding({required this.titleOne,required this.image,required this.subTitle,required this.titleTwo});
}




List<OnBoarding> onBoardingList=[
  OnBoarding(titleOne: "Find Your", image: AppImages.onBoardingOne, subTitle: "With our new exciting features", titleTwo: "Special Someone"),
  OnBoarding(titleOne: "More Profiles,", image: AppImages.onBoardingTwo, subTitle: "Connecting you with more profiles", titleTwo: "More Dates"),
  OnBoarding(titleOne: "Interact Around", image: AppImages.onBoardingThree, subTitle: "Send direct message to your matches", titleTwo: "The World"),
];

