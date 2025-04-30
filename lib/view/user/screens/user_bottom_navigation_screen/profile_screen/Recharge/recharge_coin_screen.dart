import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_coin_plan_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/profile_screen/Recharge/pay_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/recharge_coin_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';

class RechargeCoinScreen extends StatefulWidget {
  const RechargeCoinScreen({Key? key}) : super(key: key);

  @override
  State<RechargeCoinScreen> createState() => _RechargeCoinScreenState();
}

class _RechargeCoinScreenState extends State<RechargeCoinScreen> {
  FetchCoinPlanController fetchCoinPlanController = Get.put(FetchCoinPlanController());

  @override
  void initState() {
    fetchCoinPlanController.fetchCoinPlan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Recharge Coins",
          style: TextStyle(
            color: AppColors.pinkColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.appBarColor,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.pinkColor),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.appBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: Obx(() {
                if (fetchCoinPlanController.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.pinkColor,
                  ));
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(2),
                        height: height / 6,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.pinkColor,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                  AppColors.pinkColor
                                ])),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffFFE4EC), // Light blush
                                    Color(0xffFFD6E6), // Soft pink
                                    Color(0xffFFD6E6), // Soft pink repeated
                                    Color(0xffFFE4EC), // Light blush again
                                    Color(0xffFFCCDB), // Slightly deeper pink
                                  ]),
                              borderRadius: BorderRadius.circular(12)),
                          width: Get.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: AssetImage(AppImages.rechargeCoin))),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Text(
                                          userCoin.value,
                                          style: const TextStyle(
                                            color: AppColors.pinkColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Available Coins",
                                        style: TextStyle(
                                          color: AppColors.pinkColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Buy Coins",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: AppColors.pinkColor,
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      (fetchCoinPlanController.coinPlanList.isEmpty)
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(height: SizeConfig.blockSizeVertical * 10),
                                  Lottie.asset(AppLottie.notificationLottieTwo,
                                      repeat: true, reverse: false, width: SizeConfig.blockSizeHorizontal * 45),
                                  Text(
                                    "Not available any coin plan!! ",
                                    style: TextStyle(
                                        color: const Color(
                                          0xffDF4D97,
                                        ),
                                        fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          : Flexible(
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: fetchCoinPlanController.coinPlanList.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 30,
                                    child: Divider(
                                      color: AppColors.lightPinkColor.withOpacity(0.5),
                                      indent: 33,
                                      endIndent: 33,
                                      height: 2.5,
                                    ),
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => PayScreen(
                                              planId: fetchCoinPlanController.coinPlanList[index].id.toString(),
                                              coin: fetchCoinPlanController.coinPlanList[index].coin.toString(),
                                              amount: "${fetchCoinPlanController.coinPlanList[index].dollar}",
                                              productKey: fetchCoinPlanController.coinPlanList[index].productKey
                                                  .toString(),
                                            ));
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              rechargeCoins[index].image,
                                            ),
                                          ),
                                          Text(
                                            "${fetchCoinPlanController.coinPlanList[index].coin.toString()} coin",
                                            style: const TextStyle(
                                              color: AppColors.pinkColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 75,
                                            height: 30,
                                            decoration:
                                                (fetchCoinPlanController.coinPlanList[index].tag!.isNotEmpty)
                                                    ? BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: AppColors.lightPinkColor,
                                                      )
                                                    : BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.transparent,
                                                      ),
                                            child: Text(
                                              fetchCoinPlanController.coinPlanList[index].tag.toString(),
                                              style: const TextStyle(
                                                color: AppColors.pinkColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 90,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: AppColors.pinkColor,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              "\$${fetchCoinPlanController.coinPlanList[index].dollar.toString()}",
                                              style: const TextStyle(
                                                color: AppColors.lightPinkColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                  // return ListTile(
                                  //   leading: CircleAvatar(
                                  //     radius: 18,
                                  //     backgroundImage: AssetImage(
                                  //       rechargeCoins[index].image,
                                  //     ),
                                  //   ),
                                  //   title: Row(
                                  //     children: [
                                  //       Text(rechargeCoins[index].coin,style: const TextStyle(color: AppColors.lightPinkColor,fontWeight: FontWeight.w400,fontSize: 18,),),
                                  //       const SizedBox(width: 13,),
                                  //       Container(
                                  //         alignment: Alignment.center,
                                  //         height: 30,
                                  //         width: 75,
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(10),
                                  //           color: AppColors.lightPinkColor,
                                  //         ),
                                  //         child: Text(rechargeCoins[index].offerIs,style: const TextStyle(color: AppColors.pinkColor,fontWeight: FontWeight.w500,fontSize: 13,),),
                                  //       )
                                  //     ],
                                  //   ),
                                  //
                                  //   trailing: Container(
                                  //     alignment: Alignment.center,
                                  //     width: 90,
                                  //     height: 35,
                                  //     decoration: BoxDecoration(
                                  //       color: AppColors.pinkColor,
                                  //       borderRadius: BorderRadius.circular(20),
                                  //     ),
                                  //     child: Text(rechargeCoins[index].amount,style: const TextStyle(color: AppColors.lightPinkColor,fontSize: 15,fontWeight: FontWeight.w500,),),
                                  //   ),
                                  //
                                  // );
                                },
                              ),
                            ),
                    ],
                  );
                }
              })),
        ),
      ),
    );
  }
}
