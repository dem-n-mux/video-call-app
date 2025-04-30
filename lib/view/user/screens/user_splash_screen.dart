import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/controller/get_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/setting_controller.dart';
import 'package:hokoo_flutter/Api_Service/notification/user_notification/update_fcm/user_update_notification_controller.dart';
import 'package:hokoo_flutter/view/Chat_Screen/chat_screen.dart';
import 'package:hokoo_flutter/view/Live_Stream/participant.dart';
import 'package:hokoo_flutter/view/host/Host%20Home%20Screen/Video%20Call/host_in_coming_call_screen.dart';
import 'package:hokoo_flutter/view/host/Host%20Home%20Screen/host_notification_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/home_screen/user_notification_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';

// ignore:library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_user_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/get_user_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_login_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Host/Host Profile Screen/host_history_screen/host_history_screen.dart';

class UserSplashScreen extends StatefulWidget {
  const UserSplashScreen({Key? key}) : super(key: key);

  @override
  State<UserSplashScreen> createState() => _UserSplashScreenState();
}

class _UserSplashScreenState extends State<UserSplashScreen> with WidgetsBindingObserver {
  SettingController settingController = Get.put(SettingController());
  FetchUserController fetchUserController = Get.put(FetchUserController());
  GetUserController getUserController = Get.put(GetUserController());
  GetHostController getHostController = Get.put(GetHostController());
  FetchHostController fetchHostController = Get.put(FetchHostController());
  UserUpdateNotificationController userUpdateNotificationController = Get.put(UserUpdateNotificationController());

  connect() async {
    socket = IO.io(Constant.BASE_URL,
        IO.OptionBuilder().setTransports(['websocket']).setQuery({"globalRoom": loginUserId}).build());
    socket.connect();
    socket.onConnect((data) {
      log(" Socket Connected HostInComingCallScreen");
    });
    socket.on("callRequest", (data) {
      log("CallRequest Data :: $data");
      if (data["live"] == "live") {
      } else {
        if (bgcall.value) {
          log("==========================!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        } else {
          Get.to(
            () => HostInComingCallScreen(
              receiveCallData: data,
              name: data["callerName"],
              image: data["callerImage"],
              callId: data["callId"],
            ),
          );
        }
      }
    });
  }

  initFirebase() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log("The Notification Setting is :: $settings");

    await messaging.getToken().then((value) {
      log("this is fcm token = $value");
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      setState(() {
        log("notificationVisit with start :- $notificationVisit");
        notificationVisit = !notificationVisit;
        log("notificationVisit with SetState :- $notificationVisit");
      });
      handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("this is event log :- $event");
      handleMessage(event);
    });

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');

        if (message.notification != null) {
          log('Message also contained a notification: ${message.notification}');
        }
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin
            ?.initialize(const InitializationSettings(android: initializationSettingsAndroid),
                onDidReceiveNotificationResponse: (payload) {
          log("payload is:- $payload");
          handleMessage(message);
        });
        _showNotificationWithSound(message);
      },
    );
  }

  Future<void> handleMessage(RemoteMessage message) async {
    String screenType = "";
    String callType = "";
    int type = 0;

    if (message.data['type'] == 'ADMIN' && message.data['loginType'] == 'user') {
      log("Admin user notification");
      Get.to(() => const UserNotificationScreen());
    } else if (message.data['type'] == 'ADMIN' && message.data['loginType'] == 'host') {
      log("Admin host notification");
      Get.to(() => const HostNotificationScreen());
    } else if (message.data['type'] == 'MESSAGE') {
      log("Notification Type is :-  ${message.data['type']}");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("loginUserId", fetchUserController.userData!.user!.id.toString());
      preferences.setBool("isHost", fetchUserController.userData?.user?.isHost ?? false);
      isHost = preferences.getBool("isHost") ?? false;
      loginUserId = preferences.getString("loginUserId")!;

      if (isHost == true) {
        screenType = 'HostScreen';
        type = 0;
        callType = 'host';
      } else {
        screenType = 'UserScreen';
        type = 1;
        callType = 'user';
      }

      log("That is background chat log......");
      log("That is app terminated chat log......");
      log("host name is :-  ${message.data['name']}");
      log("chatRoomId is :-  ${message.data['topic']}");
      log("senderId is :-  ${message.data['_id']}");
      log("hostImage is :-  ${message.data['image']}");
      log("receiverId is :-  ${message.data['topic']}");
      log("screen type is :-  $screenType");
      log("type is :-  $type");
      log("callType is :-  $callType");

      Get.to(() => ChatScreen(
            hostName: message.data['name'],
            chatRoomId: message.data['topic'],
            senderId: loginUserId,
            hostImage: message.data['image'],
            receiverId: message.data['_id'],
            screenType: screenType,
            type: type,
            callType: callType,
          ));
    } else if (message.data['type'] == 'REDEEM') {
      log("Redeem notification is.....");
      Get.to(() => const HostHistoryScreen());
    } else {
      log("live streaming notification");

      Get.to(() => Participant(
            token: message.data['token'],
            channelName: message.data['channel'],
            clientRole: ClientRole.Audience,
            liveStreamingId: message.data['liveStreamingId'],
            hostname: message.data['name'],
            hostImage: message.data['image'],
            hostId: message.data['_id'],
          ));
    }
  }

  Future _showNotificationWithSound(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '0',
      'Babble',
      channelDescription: 'hello',
      icon: 'mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin?.show(
      message.hashCode,
      message.notification!.body.toString(),
      message.notification!.title.toString(),
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initFirebase();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // NotificationController.notificationActivity();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await settingController.setting();
      preferences.setBool("isAppActive", settingController.getSetting?.setting?.isAppActive ?? false);
      isAppActive = preferences.getBool("isAppActive")!;
      isLogin = preferences.getBool("isLogin") ?? false;

      coinPerDollarIs = settingController.getSetting?.setting?.coinPerDollar?.toString() ?? "";

      log("Coin per dollar is :- $coinPerDollarIs");
      publishableKey = settingController.getSetting?.setting?.stripePublishableKey ?? "";
      secretKey = settingController.getSetting?.setting?.stripeSecretKey ?? "";
      razorPayKey = settingController.getSetting?.setting?.razorPayId ?? "";
      googlePayIsActive = settingController.getSetting?.setting?.googlePlaySwitch ?? false;
      razorPayIsActive = settingController.getSetting?.setting?.razorPaySwitch ?? false;
      stripePayIsActive = settingController.getSetting?.setting?.stripeSwitch ?? false;
      isLogin = preferences.getBool("isLogin") ?? false;
      log("googlePayIsActive :- $googlePayIsActive");
      log("razorPayIsActive :- $razorPayIsActive");
      log("stripePayIsActive :- $stripePayIsActive");
      log("stripePayIsActive :- $stripePayIsActive");
      Stripe.publishableKey = publishableKey;
      log("Stripe.publishableKey :- ${Stripe.publishableKey}");
      log("razorPayKey :- $razorPayKey");

      if (isAppActive) {
        log("isAppActive :- $isAppActive");
        log("isLogin :- $isLogin");
        if (isLogin) {
          log("isLogin :- $isLogin");

          await getUserController.getUser(loginUserId, isHost ? "Host" : "User");
          if (getUserController.getUserData?.status == true) {
            if (getUserController.getUserData?.findUser?.isHost == true) {
              await fetchHostController.fetchHost(
                  1,
                  fcmToken,
                  androidId,
                  getUserController.getUserData?.findUser?.email ?? '',
                  getUserController.getUserData?.findUser?.country ?? '',
                  getUserController.getUserData?.findUser?.name ?? "");
              log("check coin host :: ${fetchHostController.hostData?.host?.coin.toString() ?? ''}");
              preferences.setBool("hostIsBlock", fetchHostController.hostData?.host?.isBlock ?? false);
              preferences.setString("userName", fetchHostController.hostData?.host?.name.toString() ?? '');
              preferences.setString("userCoin", fetchHostController.hostData?.host?.coin.toString() ?? '');
              preferences.setString("userImage", fetchHostController.hostData?.host?.image.toString() ?? "");
              preferences.setString(
                  "getHostCoverImage", fetchHostController.hostData?.host?.coverImage.toString() ?? '');
              preferences.setString("userBio", fetchHostController.hostData?.host?.bio.toString() ?? '');
              preferences.setString("userGender", fetchHostController.hostData?.host?.gender.toString() ?? '');
              preferences.setString("uniqueID", fetchHostController.hostData?.host?.uniqueID ?? "");
              preferences.setString("loginUserId", fetchHostController.hostData?.host?.id.toString() ?? "");
              //----------------------------------
              hostIsBlock = preferences.getBool("hostIsBlock") ?? false;
              userName = preferences.getString("userName") ?? "";
              loginUserId = preferences.getString("loginUserId") ?? "";
              userCoin.value = preferences.getString("userCoin") ?? "";
              userImage = preferences.getString("userImage") ?? "";
              hostCoverImage = preferences.getString("getHostCoverImage") ?? "";
              userBio = preferences.getString("userBio") ?? "";
              uniqueId = preferences.getString("uniqueId") ?? "";
              userGender = preferences.getString("userGender") ?? "";
              log("userImage1:::::$userImage");
              log("Got to host");
              selectedIndex = 0;
              Get.off(() => const HostBottomNavigationBarScreen());
            } else {
              preferences.setString("userName", getUserController.getUserData?.findUser?.name.toString() ?? "");
              preferences.setString("userImage", getUserController.getUserData?.findUser?.image.toString() ?? "");
              preferences.setString("userBio", getUserController.getUserData?.findUser?.bio.toString() ?? "");
              preferences.setString("loginUserId", getUserController.getUserData?.findUser?.id.toString() ?? "");
              preferences.setString("userCoin", getUserController.getUserData?.findUser?.coin.toString() ?? "");
              preferences.setString("uniqueId", getUserController.getUserData?.findUser?.uniqueId.toString() ?? "");
              preferences.setBool("userIsBlock", getUserController.getUserData?.findUser?.isBlock ?? false);
              preferences.setBool("isHost", getUserController.getUserData?.findUser?.isHost! ?? false);
              preferences.setString("userCoin", getUserController.getUserData?.findUser?.coin.toString() ?? "");
              preferences.setBool("isHost", fetchUserController.userData?.user?.isHost ?? false);
              isHost = preferences.getBool("isHost") ?? false;
              userCoin.value = preferences.getString("userCoin") ?? '';
              userBio = preferences.getString("userBio") ?? "";
              userImage = preferences.getString("userImage") ?? "";
              userName = preferences.getString("userName") ?? "";
              loginUserId = preferences.getString("loginUserId") ?? "";
              userGender = preferences.getString("userGender") ?? "";
              isHost = preferences.getBool("isHost") ?? false;
              userIsBlock = preferences.getBool("userIsBlock") ?? false;
              userCoin.value = preferences.getString("userCoin") ?? "";
              uniqueId = preferences.getString("uniqueId") ?? '';
              log("userImage2:::::$userImage");
              log("userImage2:::::$userName");
              selectedIndex = 0;
              Get.off(() => const UserBottomNavigationScreen());
              await userUpdateNotificationController.userUpdateNotificationIs(loginUserId, fcmToken, "user");
            }
          } else {
            Fluttertoast.showToast(msg: "User doesn't exit");
            log("User doesn't exit");
            Get.off(() => const UserLoginScreen());
          }
        } else {
          Fluttertoast.showToast(msg: "user not Login");
          log("user not Login");
          Get.off(() => const UserLoginScreen());
        }

        connect();

        // if (notificationVisit == false) {
        //   if (userIsBlock || hostIsBlock) {
        //   } else {
        //     if (isOnBoarding) {
        //       Get.offAll(() => const UserOnBoardingScreen());
        //     } else if (isBottom) {
        //       if (isHost) {
        //         Get.offAll(() => const HostBottomNavigationBarScreen());
        //       } else {
        //         Get.offAll(() => const UserBottomNavigationScreen());
        //       }
        //     } else {
        //       Get.offAll(() => const UserLoginScreen());
        //     }
        //   }
        // }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      log("Went to Background");
      bgcall.value = true;
    }
    if (state == AppLifecycleState.resumed) {
      log("Come back to Foreground");
      bgcall.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        if (settingController.isLoading.value) {
          return Container(
            color: AppColors.whiteColor,
            // decoration: const BoxDecoration(
            //     image: DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
            child: const Column(
              children: [
                Expanded(
                  child: Center(
                      child: Image(
                    image: AssetImage(AppImages.splashCenterImage),
                    height: 130,
                  )),
                ),
                Column(
                  children: [
                    Text(
                      "Babble",
                      style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        "Let's Dive!",
                        style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else if (userIsBlock || hostIsBlock || isAppActive == false) {
          return Stack(
            children: [
              Container(
                color: AppColors.whiteColor,
                // decoration: const BoxDecoration(
                //     image: DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
                child: const Column(
                  children: [
                    Expanded(
                      child: Center(
                          child: Image(
                        image: AssetImage(AppImages.splashCenterImage),
                        height: 130,
                      )),
                    ),
                    Column(
                      children: [
                        Text(
                          "Babble",
                          style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            "Let's Dive!",
                            style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 230,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(
                            AppImages.appBackground,
                          ),
                          fit: BoxFit.cover)),
                  alignment: Alignment.center,
                  child: const Text(
                    "App is Not Working Currently",
                    style: TextStyle(color: AppColors.lightPinkColor),
                  ),
                ),
              )
            ],
          );
        } else if (userIsBlock) {
          return Stack(
            children: [
              Container(
                color: AppColors.whiteColor,
                // decoration: const BoxDecoration(
                //     image: DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
                child: const Column(
                  children: [
                    Expanded(
                      child: Center(
                          child: Image(
                        image: AssetImage(AppImages.splashCenterImage),
                        height: 130,
                      )),
                    ),
                    Column(
                      children: [
                        Text(
                          "Babble",
                          style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            "Let's Dive!",
                            style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 350,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(
                            AppImages.appBackground,
                          ),
                          fit: BoxFit.cover)),
                  alignment: Alignment.center,
                  child: const Text(
                    "You are Block By Admin",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        } else if (hostIsBlock) {
          return Stack(
            children: [
              Container(
                color: AppColors.whiteColor,
                // decoration: const BoxDecoration(
                //     image: DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
                child: const Column(
                  children: [
                    Expanded(
                      child: Center(
                          child: Image(
                        image: AssetImage(AppImages.splashCenterImage),
                        height: 130,
                      )),
                    ),
                    Column(
                      children: [
                        Text(
                          "Babble",
                          style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            "Let's Dive!",
                            style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 350,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(
                            AppImages.appBackground,
                          ),
                          fit: BoxFit.cover)),
                  alignment: Alignment.center,
                  child: const Text(
                    "You are Block By Admin",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        } else if (settingController.getSetting?.message == "No data found!") {
          return Container(
            height: Get.height,
            width: Get.width,
            color: AppColors.whiteColor,
            // decoration: const BoxDecoration(
            //     image: DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(settingController.getSetting!.message.toString(),
                    style: const TextStyle(color: AppColors.lightPinkColor, fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
          );
        } else {
          return Container(
            color: AppColors.whiteColor,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     fit: BoxFit.cover,
            //     image: AssetImage(
            //       AppImages.splashScreenBackground,
            //     ),
            //   ),
            // ),
            child: const Column(
              children: [
                Expanded(
                  child: Center(
                      child: Image(
                    image: AssetImage(AppImages.splashCenterImage),
                    height: 130,
                  )),
                ),
                Column(
                  children: [
                    Text(
                      "Babble",
                      style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        "Let's Dive!",
                        style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
