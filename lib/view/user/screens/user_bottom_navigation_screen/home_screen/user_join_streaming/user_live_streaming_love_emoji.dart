// import 'package:flutter/material.dart';
// import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
// import 'package:hokoo_flutter/view/utils/settings/models/sticker_model.dart';
//
// class LoveEmojiScreen extends StatefulWidget {
//   const LoveEmojiScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoveEmojiScreen> createState() => _LoveEmojiScreenState();
// }
//
// class _LoveEmojiScreenState extends State<LoveEmojiScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       scrollDirection: Axis.vertical,
//       physics: const BouncingScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: loveBirds.length,
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 100,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemBuilder: (BuildContext context, i) {
//         return InkWell(
//           onTap: () {
//           },
//           child: Column(
//             children: [
//               InkWell(
//                 onTap: () async {
//                   setState(() {
//                     loveBirdsImage.add(loveBirds[i].image);
//                     log(loveBirdsImage.length);
//                     loveBirdsImage.removeRange(0, loveBirdsImage.length - 1);
//                     log(loveBirdsImage.length);
//
//                   });
//                   await Future.delayed( const Duration( seconds: 1)).then((value) {
//                     setState(() {
//                       loveBirdsImage.add(AppImages.flairImage);
//                       log(loveBirdsImage);
//                     });
//                   });
//                 },
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(loveBirds[i].image),
//                       fit: BoxFit.cover,
//                     ),
//                     shape: BoxShape.circle,
//                   ),
//                   alignment: Alignment.center,
//                 ),
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
//                       image: DecorationImage(
//                         image: AssetImage(
//                           AppImages.singleCoin,
//                         ),
//                       )
//                     ),
//                   ),
//                   const Text("50",
//                       style: TextStyle(
//                           fontSize: 14, color: Colors.white,),),
//                 ],
//               )
//
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
