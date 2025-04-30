// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutterwave_standard/flutterwave.dart';
// import 'package:get/get.dart';
// import 'package:hokoo_flutter/Api_Service/coin%20history/coin_plan/coin_plan_controller.dart';
// import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
// import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
// CoinPlanController coinHistoryController = Get.put(CoinPlanController());
//
//
// class FlutterWaveService {
//
//     Future handlePaymentSuccess({required String planId,required String coin,required String coinPlanId}) async {
//     String? selectTime;
//     // createPremiumPlan.createPremiumData(userId, "Flutter Wave", planId);
//     Fluttertoast.showToast(
//       msg: "Payment Successfully",
//       backgroundColor: AppColors.pinkColor,
//       fontSize: 15,
//       textColor: Colors.white,
//       timeInSecForIosWeb: 4,
//     );
//
//     int coinUpdate = int.parse(userCoin.value) + int.parse(coin);
//     userCoin.value = "$coinUpdate";
//
//     log("Stripe pay Coin Update is :- ${userCoin.value}");
//
//     await coinHistoryController.coinPlanHistory(
//         loginUserId, coinPlanId, "Stripe Pay");
//     selectedIndex = 0;
//     Get.offAll(() => const UserBottomNavigationScreen());
//     log("selectTime :: $selectTime");
//   }
//
//   void handlePaymentInitialization({required String amount, required String currency, required String planId,required String coin}) async {
//     // int amountInPaisa = (bookingScreenController.totalPrice * 100).toInt();
//     // log("Flutter Wave Stripe Key :: ${splashController.settingCategory?.setting?.flutterWaveKey}");
//
//     final Customer customer = Customer(name: "Flutter wave Developer", email:"customer@customer.com", phoneNumber: '' );
//
//     log("Flutter Wave Start$flutterWaveId");
//     final Flutterwave flutterwave = Flutterwave(
//         context: Get.context!,
//         publicKey: flutterWaveId,
//         currency: currency,
//         // publicKey: splashController.settingCategory?.setting?.flutterWaveKey ?? "",
//         // currency: splashController.settingCategory?.setting?.currencyName ?? "",
//         redirectUrl: "https://www.google.com/",
//         txRef: DateTime.now().microsecond.toString(),
//         amount: amount,
//         customer: customer,
//         paymentOptions: "ussd, card, barter, pay attitude",
//         customization: Customization(title: "Babble"),
//         isTestMode: true);
//     log("Flutter Wave Finish");
//     final ChargeResponse response = await flutterwave.charge();
//     log("Flutter Wave ----------- ");
//     log("Payment ${response.status.toString()}");
//
//     if (response.success == true) {
//       handlePaymentSuccess(coinPlanId: planId,coin: coin,planId: planId);
//     }
//
//     log("Flutter Wave Response :: ${response.toString()}");
//     log("Flutter Wave Json Response :: ${response.toJson()}");
//   }
// }
