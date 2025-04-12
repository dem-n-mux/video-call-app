import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';

class RechargeCoins{
  String image;
  String coin;
  String offerIs;
  String amount;

  RechargeCoins({required this.image,required this.coin,required this.offerIs,required this.amount});

}

List<RechargeCoins> rechargeCoins = [
  RechargeCoins(
    image: AppImages.rechargeCoin,
    coin: "200 coin",
    offerIs: "",
    amount: "₹190.00",
  ),
  RechargeCoins(
    image: AppImages.rechargeCoin,
    coin: "500 coin",
    offerIs: "",
    amount: "₹480.00",
  ),
  RechargeCoins(
    image: AppImages.rechargeCoin,
    coin: "1100 coin",
    offerIs: "Most Hot",
    amount: "₹990.00",
  ),
  RechargeCoins(
    image: AppImages.rechargeCoin,
    coin: "2300 coin",
    offerIs: "",
    amount: "₹1,950.00",
  ),
  RechargeCoins(
    image: AppImages.rechargeCoin,
    coin: "6000 coin",
    offerIs: "Best Offer",
    amount: "₹4,850.00",
  ),
  RechargeCoins(
    image: AppImages.rechargeCoin,
    coin: "12000 coin",
    offerIs: "",
    amount: "₹9,700.00",
  ),
];