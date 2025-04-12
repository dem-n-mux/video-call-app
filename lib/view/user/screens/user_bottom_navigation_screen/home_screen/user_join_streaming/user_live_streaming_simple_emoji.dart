// import 'package:flutter/material.dart';
// import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
// import 'package:hokoo_flutter/view/utils/settings/models/sticker_model.dart';
//
// class SimpleEmojiScreen extends StatefulWidget {
//   const SimpleEmojiScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SimpleEmojiScreen> createState() => _SimpleEmojiScreenState();
// }
//
// class _SimpleEmojiScreenState extends State<SimpleEmojiScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       scrollDirection: Axis.vertical,
//       physics: const BouncingScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: emoji.length,
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 100,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,),
//       itemBuilder: (BuildContext context, i) {
//         return InkWell(
//           onTap: () {
//           },
//           child: Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(emoji[i].image),
//                     fit: BoxFit.cover,
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//                 alignment: Alignment.center,
//               ),
//
//               const SizedBox(
//                 height: 3,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 20,
//                     width: 20,
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(
//                             AppImages.singleCoin,
//                           ),
//                         )
//                     ),
//                   ),
//                   const Text("50",
//                       style: TextStyle(
//                           fontSize: 14, color: Colors.white)),
//                 ],
//               ),
//
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
