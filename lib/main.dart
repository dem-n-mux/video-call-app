import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/view/user/screens/user_splash_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/platform_device_id.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseMessaging? messaging;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> backgroundNotification(RemoteMessage message) async {
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

  log('Got a message whilst in the foreground!');
  log('Notification Setting :: $settings');
  log('Message data: ${message.data}');

  if (message.notification != null) {
    log('Message also contained a notification: ${message.notification}');
  }
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin?.initialize(
    const InitializationSettings(android: initializationSettingsAndroid),
    onDidReceiveBackgroundNotificationResponse: (message) {},
  );
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    '0',
    'Babble',
    channelDescription: 'hello',
    importance: Importance.max,
    icon: '@mipmap/ic_launcher',
    priority: Priority.high,
  );

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin?.show(
    message.hashCode,
    message.notification!.title.toString(),
    message.notification!.body.toString(),
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  hideStatusBar();

  /// Identity ///
  androidId = (await PlatformDeviceId.getDeviceId)!;
  log("Android ID :: $androidId");

  /// FCM_Token ///
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      fcmToken = value ?? 'asdfsadfsadgsagf';
      log("Fcm Token :: $fcmToken");
    });
  } catch (e) {
    log("Error FCM token: $e");
  }
  log("FCM Tocken :: $fcmToken");
  FirebaseMessaging.onBackgroundMessage(backgroundNotification);

  SharedPreferences preferences = await SharedPreferences.getInstance();

  fetchBanner = preferences.getString("fetchBanner") == null ? {} : jsonDecode(preferences.getString("fetchBanner")!);

  fetchCountry = preferences.getString("fetchCountry") == null ? {} : jsonDecode(preferences.getString("fetchCountry")!);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  ///Real User Data ///
  // userName = preferences.getString("getUserName") ?? "Babble User";
  // userGender = preferences.getString("userGender") ?? "Female";
  // userBio = preferences.getString("getUserBio") ?? "I am Babble user";
  // userImage = preferences.getString("userName") ?? AppImages.userProfile;
  // userDob = preferences.getString("getUserDob") ?? "2023-03-10 11:02:15.252970";
  // loginUserId = preferences.getString("loginUserId") ?? '';
  // chatUserId = preferences.getString("chatUserId") ?? '';
  // chatRoomId = preferences.getString("chatRoomId") ?? '';
  // chatHostId = preferences.getString("chatHostId") ?? '';
  // storyId = preferences.getString("storyId") ?? "";
  loginUserId = preferences.getString("loginUserId") ?? "";
  // getLiveHostId = preferences.getString("getLiveHostId") ?? "";
  // getLiveRoomId = preferences.getString("getLiveRoomId") ?? "";
  // isLogin = preferences.getBool("isLogin") ?? false;
  isHost = preferences.getBool("isHost") ?? false;
  // userIsBlock = preferences.getBool("userIsBlock") ?? false;
  // hostIsBlock = preferences.getBool("hostIsBlock") ?? false;
  // isAppActive = preferences.getBool("isAppActive") ?? true;
  // isOnline = preferences.getBool("isOnline") ?? true;
  // userCoin.value = preferences.getString("userCoin") ?? "100";
  // hostCoin.value = preferences.getString("hostCoin") ?? "100";

  log("loginUserId: $loginUserId");

  isOnBoarding = preferences.getBool("isOnBoarding") ?? true;
  isBottom = preferences.getBool("isBottom") ?? false;

  toysId = preferences.getString("toysId") ?? " ";
  loveId = preferences.getString("loveId") ?? " ";

  runApp(const MyApp());
}
///////// ================================

hideStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparentColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final StreamController purchaseStreamController = StreamController<PurchaseDetails>.broadcast();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      theme: ThemeData(
        unselectedWidgetColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      getPages: [GetPage(name: "/", page: () => const UserSplashScreen())],
      debugShowCheckedModeBanner: false,
    );
  }
}
