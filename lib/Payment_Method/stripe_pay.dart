import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:http/http.dart' as http;
import '../Api_Service/coin history/coin_plan/coin_plan_controller.dart';

CoinPlanController coinHistoryController = Get.put(CoinPlanController());

class StripeService {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {
        required String amount,
        required String coin,
      required String currency,
      required String coinPlanId}) async {
    try {
      debugPrint("Start Payment");
      paymentIntentData = await createPaymentIntent(amount, currency);

      debugPrint("After payment intent");
      log(paymentIntentData.toString());
      if (paymentIntentData != null) {
        // CardEditController cardEditController = CardEditController(
        //   initialDetails: CardFieldInputDetails(
        //     complete: true,
        //     number: '4312424253534242',
        //     cvc: '234',
        //     expiryMonth: 3,
        //     expiryYear: 2024,
        //   )
        // );
        // await Stripe.buildWebCard(
        //   controller: cardEditController,
        // );

        debugPrint(" payment intent is not null .........");
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
           merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
          googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: '+92', testEnv: true),
          style: ThemeMode.dark,
        ));
        debugPrint(" initPaymentSheet  .........");
        displayPaymentSheet(coinPlanId,coin);
      }
    } catch (e, s) {
      debugPrint("After payment intent Error: ${e.toString()}");
      debugPrint("After payment intent s Error: ${s.toString()}");
    }
  }

  displayPaymentSheet(String coinPlanId,String coin) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // ToastMessage.success('Payment Successful');
      updateUserPlan(coinPlanId,coin);
    } on Exception catch (e) {
      if (e is StripeException) {
        debugPrint("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        debugPrint("Unforcen Error: $e");
      }
    } catch (e) {
      debugPrint("Exception $e");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculate(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      debugPrint("Start Payment Intent http rwq post method");

      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization": "Bearer $secretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          });
      debugPrint("End Payment Intent http rwq post method");
      debugPrint(response.body.toString());

      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('err charging user: ${e.toString()}');
    }
  }

  calculate(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  updateUserPlan(
    String coinPlanId,
      String coin,
  ) async {
    Fluttertoast.showToast(
      msg: "Payment Successfully",
      backgroundColor: AppColors.pinkColor,
      fontSize: 15,
      textColor: Colors.white,
      timeInSecForIosWeb: 4,
    );

    int coinUpdate = int.parse(userCoin.value) + int.parse(coin);
    userCoin.value = "$coinUpdate";

    log("Stripe pay Coin Update is :- ${userCoin.value}");

    await coinHistoryController.coinPlanHistory(
        loginUserId, coinPlanId, "Stripe Pay");
    selectedIndex = 0;
    Get.offAll(() => const UserBottomNavigationScreen());
  }
}
