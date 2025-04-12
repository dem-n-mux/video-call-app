// import 'dart:developer';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:hokoo_flutter/Notification/notification_service.dart';
// import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/home_screen/user_notification_screen.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
//
// /// Notifications ///
//
// class NotificationController {
//   static notificationActivity() async {
//     FirebaseMessaging firebaseMessaging =
//         FirebaseMessaging.instance; // Change here
//     firebaseMessaging.getToken().then((token) {
//       fcmToken = token!;
//       log("token is $fcmToken");
//     });
//
//     /// Notification ///
//     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//
//     await FirebaseMessaging.instance.subscribeToTopic('Cupie');
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log("Message data (Background) :- ${message.data}");
//       if (message.notification != null) {
//         log("Type (Background) :- ${message.data["type"]}");
//         if (message.data["type"] == "LIVE") {
//           log("live notification (Background)..");
//           // Get.to(() => Participant());
//         } else if (message.data["type"] == "ADMIN") {
//           log("admin notification (Background)...");
//           // Get.to(()=>const UserNotificationScreen());
//         }
//       }
//
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         log("Message data (OpenedApp) :- ${message.data}");
//         if (message.notification != null) {
//           log("Type (OpenedApp) :- ${message.data["type"]}");
//           if (message.data["type"] == "LIVE") {
//             log("live notification (OpenedApp)...");
//           } else if (message.data["type"] == "ADMIN") {
//             // Get.to(() => const UserNotificationScreen());
//             log("admin notification (OpenedApp)...");
//           }
//         }
//       });
//     });
//
//     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions();
//
//     Future<void> _firebaseMessagingBackgroundHandler(
//         RemoteMessage message) async {
//       await Firebase.initializeApp();
//       log("Handling a background message: ${message.messageId}");
//     }
//
//     FirebaseMessaging.instance.getInitialMessage().then((value) {
//       log(value.toString());
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       log("Message data(onMessage Opened): ${message.data}");
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log(message.notification!.title.toString());
//       log(message.notification!.body.toString());
//       LocalNotificationServices.createAndDisplayNotification(message);
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       log(message.notification!.title.toString());
//       log(message.notification!.body.toString());
//       LocalNotificationServices.createAndDisplayNotification(message);
//     });
//
//     FirebaseMessaging.onBackgroundMessage(
//         (message) => _firebaseMessagingBackgroundHandler(message));
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions();
//   }
// }
//
// Future<void> backgroundHandler(
//   RemoteMessage message,
// ) async {
//   log(
//     message.data.toString(),
//   );
//   log(message.notification!.title.toString());
//   log("4");
//   log("OnMessage Open App");
//   if (message.data["type"] == "ADMIN") {
//     Get.to(
//       () => const UserNotificationScreen(),
//     );
//     log("admin notification (OpenedApp)...");
//   } else if (message.data["type"] == "LIVE") {
//     // Get.to(
//     //       () => Participant(token: token, channelName: channelName,clientRole: ClientRole.Audience, liveStreamingId: '', hostname: userName, hostImage: userImage, hostId: loginUserId,),
//     // );
//   } else {
//     // Get.to(
//     //       () => const Chat(),
//     // );
//   }
// }
