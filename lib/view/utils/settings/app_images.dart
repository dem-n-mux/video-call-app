import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppImages {
  static const weddingCouple = "assets/images/wedding_couple.png";
  static const splashCenterImage = "assets/images/splashCenterImage.png";
  static const splashScreenBackground = "assets/images/splashScreenBackground.png";
  static const coverImage = "assets/images/coverImage.jpg";
  static const profileMale = "assets/images/profile_male.png";
  static const profileFemale = "assets/images/profile_female.png";
  static const splashScreenImage = "assets/images/splashImage.png";
  static const loginModel = "assets/images/login_model.png";
  static const appBackground = "assets/images/app_background.png";
  static const onBoardingOne = "assets/images/onBoarding_one.png";
  static const onBoardingTwo = "assets/images/onBoarding_two.png";
  static const onBoardingThree = "assets/images/onBoarding_three.png";
  static const carouselModel = "assets/images/carousel_model.PNG";
  static const storyModel1 = "https://images.unsplash.com/photo-1615212814093-f56085658024?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80";
  static const storyModel12 = "https://images.unsplash.com/photo-1615212863630-1691e4c99c15?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80";
  static const storyModel13 = "https://images.unsplash.com/photo-1615212116387-d66aba3d76f9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80";
  static const storyModel14 = "https://images.unsplash.com/photo-1615212079782-15a3ed596838?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80";
  static const storyModel2 = "https://images.unsplash.com/photo-1550456915-749f38312cbe?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80";
  static const storyModel21 = "https://images.unsplash.com/photo-1617058998642-5ce6c139754b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60";
  static const storyModel22 = "https://images.unsplash.com/photo-1599588683983-dc7dd610d430?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTF8di03bDNLdWR6SXN8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
  static const storyModel3 = "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bW9kZWx8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60";
  static const storyModel31 = "https://images.unsplash.com/photo-1574773063456-7fc8e7cfe898?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTZ8di03bDNLdWR6SXN8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
  static const storyModel4 = "https://images.unsplash.com/photo-1592310854336-2461319558d2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MzB8di03bDNLdWR6SXN8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
  static const storyModel41 = "https://images.unsplash.com/photo-1591624739238-f2b789898aa7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MzF8di03bDNLdWR6SXN8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
  static const storyModel42 = "https://images.unsplash.com/photo-1553544923-37efbe6ff816?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8Mzl8di03bDNLdWR6SXN8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
  static const storyModel43 = "https://images.unsplash.com/photo-1591596737769-29af4654dbb6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8Mjl8di03bDNLdWR6SXN8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
  static const storyModel5 = "https://images.unsplash.com/photo-1530651788726-1dbf58eeef1f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=627&q=80";
  static const storyModel51 = "https://images.unsplash.com/photo-1506691318991-c91e7df669b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEwfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60";
  static const storyModel52 = "https://images.unsplash.com/photo-1515160813423-b851dc54a427?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60";
  static const storyModel6 = "https://images.unsplash.com/photo-1584378698540-b658ce7a0fd0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTl8amVvOFNVa0I4dWd8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
  static const storyModel61 = "https://images.unsplash.com/photo-1610313898425-a5c637a940db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTF8amVvOFNVa0I4dWd8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60";
  static const homeProfileModel1 = "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1600";
  static const homeProfileModel2 = "https://images.pexels.com/photos/2787341/pexels-photo-2787341.jpeg?auto=compress&cs=tinysrgb&w=1600";
  static const homeProfileModel3 = "https://images.pexels.com/photos/2774197/pexels-photo-2774197.jpeg?auto=compress&cs=tinysrgb&w=1600";
  static const homeProfileModel4 = "https://images.pexels.com/photos/388517/pexels-photo-388517.jpeg?auto=compress&cs=tinysrgb&w=1600";
  static const homeProfileModel5 = "https://images.pexels.com/photos/921647/pexels-photo-921647.jpeg?auto=compress&cs=tinysrgb&w=1600";
  static const userProfileModel = "https://images.unsplash.com/photo-1505481454812-642d2c1a7da9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDV8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60";
  static const userProfile = "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80";
  static const indiaFlag = "https://img.freepik.com/free-vector/illustration-india-flag_53876-27130.jpg?w=1800&t=st=1667978682~exp=1667979282~hmac=2cc1718c114693068227333ae08ca1aac8f19703628b1f90712ff000977d30e5";
  static const japanFlag = "https://cdn.pixabay.com/photo/2013/07/13/14/15/japan-162328_960_720.png";
  static const australiaFlag = "https://cdn.pixabay.com/photo/2013/07/12/18/42/australia-153732_960_720.png";
  static const chinaFlag = "https://cdn.pixabay.com/photo/2012/04/10/23/05/china-26841_960_720.png";
  static const southKoreaFlag = "https://cdn.pixabay.com/photo/2013/07/13/14/17/south-korea-162427_960_720.png";
  static const usaFlag = "https://cdn.pixabay.com/photo/2017/02/06/15/09/american-flag-2043285_960_720.png";
  static const ukFlag = "https://cdn.pixabay.com/photo/2015/11/06/13/29/union-jack-1027898_960_720.jpg";
  static const germanyFlag = "https://cdn.pixabay.com/photo/2012/04/12/23/52/germany-31017_960_720.png";
  static const canadaFlag = "https://cdn.pixabay.com/photo/2012/04/10/23/27/canada-27003_960_720.png";
  static const southAfricaFlag = "https://cdn.pixabay.com/photo/2013/07/13/14/17/south-africa-162425_960_720.png";
  static const plainImage = "https://cdn-icons-png.flaticon.com/512/921/921490.png";
  static const shareUs = "assets/images/shareUs.png";
  static const rateUs = "assets/images/rateUs.png";
  static const privacyPolicy = "assets/images/privacyPolicy.png";
  static const aboutUs = "assets/images/aboutUs.png";
  static const String hostImage = "assets/images/hostImage.png";
  static const String check = "assets/images/check.png";
  static const String edit = "assets/images/edit.png";
  static const hostCenter = "assets/images/hostCenter.png";
  static const history = "assets/images/history.png";
  static const supportUs = "assets/images/supportUs.png";
  static const switchUser = "assets/images/switchUser.png";
  static const String profileWalletBox = "assets/images/profileWalletBox.png";
  static const String diamond = "assets/images/diamond.png";
  static const rechargeBox = "assets/images/rechargeBox.png";
  static const String singleCoin = "assets/images/coin.png";
  static const String messageVideoCallIcon = "assets/images/message_video_call_icon.png";
  static const String hostHome = "assets/images/hostHome.png";
  static const String hostMessage = "assets/images/hostMessage.png";
  static const String hostProfile = "assets/images/hostProfile.png";
  static const String flairImage = "assets/images/flairImage.png";
  static const String streamModel = "assets/images/stream_model.png";
  static const String delete = "assets/images/delete.png";
  static const String multiCoin = "assets/images/coins_icon.png";
  static const String e1 = "assets/images/e1.png";
  static const String e2 = "assets/images/e2.png";
  static const String e3 = "assets/images/e3.png";
  static const String e4 = "assets/images/e4.png";
  static const String e5 = "assets/images/e5.png";
  static const String bubble = "assets/images/bubble.png";
  static const String fires = "assets/images/fires.png";
  static const String heartsFilter = "assets/images/heartsfilter.png";
  static const String liveGif1 = "assets/images/livegif1.gif";
  static const String liveGif3 = "assets/images/livegif3.gif";
  static const String liveGif4 = "assets/images/livegif4.gif";
  static const String liveGif5 = "assets/images/livegif5.gif";
  static const String liveGif6 = "assets/images/livegif6.gif";
  static const String h1 = "assets/images/h1.png";
  static const String h2 = "assets/images/h2.png";
  static const String h3 = "assets/images/h3.png";
  static const String h4 = "assets/images/h4.png";
  static const String h5 = "assets/images/h5.png";
  static const String withdrawCoin = "assets/images/withdrawCoin.png";
  static const String withDraw = "assets/images/withdraw.png";
  static const String gift = "assets/images/gift.png";
  static const String b1 = "assets/loveBirds/1.png";
  static const String b2 = "assets/loveBirds/2.png";
  static const String b3 = "assets/loveBirds/3.png";
  static const String b4 = "assets/loveBirds/4.png";
  static const String b5 = "assets/loveBirds/5.png";
  static const String b6 = "assets/loveBirds/6.png";
  static const String b7 = "assets/loveBirds/7.png";
  static const String b8 = "assets/loveBirds/8.png";
  static const String b9 = "assets/loveBirds/9.png";
  static const String b10 = "assets/loveBirds/10.png";
  static const String b11 = "assets/loveBirds/11.png";
  static const String b12 = "assets/loveBirds/12.png";
  static const String b13 = "assets/loveBirds/13.png";
  static const String b14 = "assets/loveBirds/14.png";
  static const String b15 = "assets/loveBirds/15.png";

  static const String ee1 = "assets/emoji/ee1.png";
  static const String ee2 = "assets/emoji/ee2.png";
  static const String ee3 = "assets/emoji/ee3.png";
  static const String ee4 = "assets/emoji/ee4.png";
  static const String ee5 = "assets/emoji/ee5.png";
  static const String ee6 = "assets/emoji/ee6.png";
  static const String ee7 = "assets/emoji/ee7.png";
  static const String ee8 = "assets/emoji/ee8.png";
  static const String ee9 = "assets/emoji/ee9.png";
  static const String ee10 = "assets/emoji/ee10.png";
  static const String ee11 = "assets/emoji/ee11.png";
  static const String ee12 = "assets/emoji/ee12.png";

  static const String s1 = "assets/sticker/sticker1.png";
  static const String s2 = "assets/sticker/sticker2.png";
  static const String s3 = "assets/sticker/sticker3.png";
  static const String s4 = "assets/sticker/sticker4.png";
  static const String s5 = "assets/sticker/sticker5.png";
  static const String s6 = "assets/sticker/sticker6.png";
  static const String s7 = "assets/sticker/sticker7.png";
  static const String s8 = "assets/sticker/sticker8.png";

  static const carousalSliderImage1 = "https://media.istockphoto.com/id/1034325638/photo/young-woman-with-curly-hair-sitting-on-wooden-pier.jpg?s=612x612&w=0&k=20&c=ktrk1QMgJFDixzQeJ83UdpZnwVJb8L0hXO8kRPrkG60=";
  static const carousalSliderImage2 = "https://media.istockphoto.com/id/1374481988/photo/portrait-image-of-a-beautiful-young-asian-woman-in-white-shirt-with-hat-sitting-and-relaxing.jpg?s=612x612&w=0&k=20&c=Y_UsYmjx4UkecEx606byIBRU5nmc8Hj0eF_hLSfbIYY=";
  static const carousalSliderImage3 = "https://media.istockphoto.com/id/1421069728/photo/autumn-skin-care-little-child-wear-hat-on-autumn-landscape-small-girl-touch-clean-pure-skin.jpg?s=612x612&w=0&k=20&c=2sFLy8shMEDzJl2EphO88ZrWrFgC0_pOcumVGkjSaDE=";
  static const carousalSliderImage4 = "https://media.istockphoto.com/id/518596898/photo/young-woman-enjoying-pamukkale-turkey.jpg?s=612x612&w=0&k=20&c=POPHoflvQN7HDFZIU0shl-ZeKMwEv7zhLu-fy0JG55Y=";
  static const carousalSliderImage5 = "https://media.istockphoto.com/id/1413445489/photo/more-beautiful-blossom-than-ever-happy-girl-smile-on-chamomile-field-little-girl-child.jpg?s=612x612&w=0&k=20&c=JWMJ19Zs8T7Z01_Vyws3OWFcYyKfyO6l0nt6b9r24d8=";

  static const String flipCamera = "assets/images/flipCamera.png";
  static const String send = "assets/images/send.png";

  static const String share = "assets/images/share.png";
  static const String giftGif = "assets/images/gift.gif";
  static const String starGif = "assets/images/star.gif";

  static const String both = "assets/images/both.png";
  static const String male = "assets/images/male.png";
  static const String female = "assets/images/female.png";

  static const String matchingLottie = "assets/lottie/matchingLottie.json";

  static const String videoCamera = "assets/images/videoCamera.png";
  static const String bothImage = "assets/images/both.png.png";
  static const String maleImage = "assets/images/male.png";
  static const String femaleImage = "assets/images/female.png";
  static const String info = "assets/images/info.png";

  static const String hostFileImage = "hostFileImage";
  static const String demoBanner = "assets/images/demo_banner.jpg";

  static const String videoCall = "assets/images/videoCall.png";


  static const String messageCamera = "assets/images/messageCamera.png";
  static const String messageGellary = "assets/images/messageGellary.png";

  static const String powerOff = "assets/images/powerOff.png";
  static const String rechargeCoin = "assets/images/rechargeCoin.png";


  static const String googlePay1 = "assets/images/googlePay.png";
  static const String razorPay1 = "assets/images/razorPay.png";
  static const String stripePay1 = "assets/images/stripePay.png";
  static const String flutterWave = "assets/images/flutter_wave.png";


  static const String banner1 = "assets/Banner/1.jpg";
  static const String banner2 = "assets/Banner/1.png";
  static const String banner3 = "assets/Banner/2.jpg";
  static const String banner4 = "assets/Banner/4.png";
  static const String banner5 = "assets/Banner/5.png";

  static const String global = "assets/images/global.png";

  static const String noNotification = "assets/images/noNotification.png";


  static Future<bool> saveImageToPreferences(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(hostFileImage, value);
  }

  static Future<String> getImageFromPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(hostFileImage)!;
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }
}
