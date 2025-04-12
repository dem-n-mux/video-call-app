// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
// import 'controller/fetch_user_controller.dart';
//
// class DemoApi extends StatefulWidget {
//   const DemoApi({Key? key}) : super(key: key);
//
//   @override
//   State<DemoApi> createState() => _DemoApiState();
// }
//
// class _DemoApiState extends State<DemoApi> {
//   String fcmToken =
//       "dRfx0TJdQ7iyb43GjKtJsu:APA91bHLcJoL3w70GJaYNrLG_KYqqitWPwSyT7zKVsKNZRw4KhpOdgqA_hoVZuUabfYIiwHce_JmJzdgFKb8TkWN2IcT08agmr3RO3rMq-AxPFM2r8yukFf0ML6fJIVkYv5DL3pnyHvH";
//   FetchUserController fetchUserController = Get.put(FetchUserController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         height: Get.height,
//         width: Get.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: (){
//                   setState(() {
//                     fetchUserController.fetchUser(0, fcmToken,androidId, "","India");
//                   });
//                 },
//                 child: const Text(
//                   "Click Me",
//                   style: TextStyle(color: Colors.white),
//                 )),
//             Text(
//               (fetchUserController.userData?.user?.name.toString() == null)
//                   ? "Hi"
//                   : fetchUserController.userData!.user!.name.toString(),
//               style: const TextStyle(color: Colors.black),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
