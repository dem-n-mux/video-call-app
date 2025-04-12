// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/profile_screen/user_profile_screen.dart';
//
// class LocalNotificationServices {
//   LocalNotificationServices._();
//
//   static final LocalNotificationServices localNotificationServices = LocalNotificationServices._();
//
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   AndroidNotificationDetails androidNotificationDetails =
//
//       /// android notification details
//
//       const AndroidNotificationDetails(
//     "0",
//     "Cupie",
//     channelDescription: "hello user",
//     icon: "mipmap/ic_launcher",
//     importance: Importance.high,
//     priority: Priority.high,
//     playSound: true,
//   );
//
//   // IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
//   //   presentAlert: true,
//   //   presentBadge: true,
//   //   presentSound: true,
//   // );
//
//   init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("mipmap/ic_launcher");
//
//     //Initialization Settings for iOS
//     // final IOSInitializationSettings initializationSettingsIOS =
//     // IOSInitializationSettings(
//     //   requestSoundPermission: false,
//     //   requestBadgePermission: false,
//     //   requestAlertPermission: false,
//     // );
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidNotificationDetails,
//       // iOS: iosNotificationDetails,
//     );
//     //InitializationSettings for initializing settings for both platforms (Android & iOS)
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       // iOS: initializationSettingsIOS
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (notification) {
//         log("printttttttttttttttttt.....");
//         Get.to(const UserProfileScreen());
//       },
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Notification Title',
//       'This is the Notification Body',
//       platformChannelSpecifics,
//       payload: 'Notification Payload',
//     );
//   }
//
//   requestIOSPermissions(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
//     flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }
//
//   selectNotification(String? payload) {}
//
//   static Future<void> createAndDisplayNotification(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       await flutterLocalNotificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             "id",
//             "cupie",
//             channelDescription: message.notification!.body,
//             importance: Importance.high,
//             playSound: true,
//             icon: 'mipmap/ic_launcher',
//           ),
//         ),
//       );
//     } on Exception catch (e) {
//       log(e.toString());
//     }
//   }
// }
