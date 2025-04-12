import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/controller/host_credit_controller.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/controller/host_debit_controller.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/controller/redeem_request_controller.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'host_credit_screen.dart';
import 'host_debit_screen.dart';
import 'host_redeem_request_screen.dart';

class HostHistoryScreen extends StatefulWidget {
  const HostHistoryScreen({Key? key}) : super(key: key);

  @override
  State<HostHistoryScreen> createState() => _HostHistoryScreenState();
}

class _HostHistoryScreenState extends State<HostHistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  RedeemRequestHistoryController redeemRequestHistoryController =
      Get.put(RedeemRequestHistoryController());
  HostCreditHistoryController hostCreditHistoryController =
      Get.put(HostCreditHistoryController());
  HostDebitHistoryController hostDebitHistoryController =
      Get.put(HostDebitHistoryController());

  @override
  void initState() {
    log("%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController!.addListener(() {
      setState(() {
        log("mario12345");
      });
    });
    hostHistory();
    super.initState();
  }

  hostHistory() async {
    await redeemRequestHistoryController.getHostRedeemRequestHistory(loginUserId);
    await hostCreditHistoryController.getHostCreditHistory(loginUserId);
    await hostDebitHistoryController.getHostDebitHistory(loginUserId);
  }

  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();

  Future<void> _startDatePicket(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        helpText: "Select Start Date",
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.pinkColor,
                onPrimary: Colors.white,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.black,
            ),
            child: child!,
          );
        },
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        List finalstartDate = startDate.toString().split(" ");
        log("++++++++++++++Final == $finalstartDate");
        List finalEnddate = endDate.toString().split(" ");
        log("++++++++++++++Final == $finalEnddate");

        redeemRequestHistoryController.getHostRedeemRequestHistory(
            loginUserId, finalstartDate[0], finalEnddate[0]);
        hostCreditHistoryController.getHostCreditHistory(
            loginUserId, finalstartDate[0], finalEnddate[0]);
        hostDebitHistoryController.getHostDebitHistory(
            loginUserId, finalstartDate[0], finalEnddate[0]);
      });
    }
  }

  Future<void> _endDatePicket(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        helpText: "Select End Date",
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.pinkColor,
                onPrimary: Colors.white,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.black,
            ),
            child: child!,
          );
        },
        firstDate: startDate,
        lastDate: DateTime.now());

    if (picked != null && picked.isAfter(startDate)) {
      setState(() {
        endDate = picked;
        List finalstartDate = startDate.toString().split(" ");
        log("++++++++++++++Final == $finalstartDate");
        List finalEnddate = endDate.toString().split(" ");
        log("++++++++++++++Final == $finalEnddate");

        redeemRequestHistoryController.getHostRedeemRequestHistory(
            loginUserId, finalstartDate[0], finalEnddate[0]);
        hostCreditHistoryController.getHostCreditHistory(
            loginUserId, finalstartDate[0], finalEnddate[0]);
        hostDebitHistoryController.getHostDebitHistory(
            loginUserId, finalstartDate[0], finalEnddate[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(AppImages.appBackground),
      )),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Scaffold(
            backgroundColor: AppColors.transparentColor,
            body: Obx(() {
              if (redeemRequestHistoryController.isLoading.value || hostCreditHistoryController.isLoading.value || hostDebitHistoryController.isLoading.value) {

                return SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_outlined,
                              color: AppColors.pinkColor,
                              size: 22,
                            ),
                          ),
                          Text(
                            "History",
                            style: TextStyle(
                              color: AppColors.pinkColor,
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.blockSizeVertical * 3,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 10),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 2,
                      ),
                      const CircularProgressIndicator(
                        color: AppColors.pinkColor,
                      )
                    ],
                  ),
                );
              } else {
                return SizedBox(
                  height: height,
                  width: width,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 3.5,
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3,
                            ),
                            height: SizeConfig.blockSizeVertical * 27,
                            color: AppColors.transparentColor.withOpacity(0.2),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        splashColor: AppColors.transparentColor,
                                        highlightColor:
                                            AppColors.transparentColor,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: AppColors.pinkColor,
                                            size: 22)),
                                    const Text(
                                      "History",
                                      style: TextStyle(
                                        color: AppColors.pinkColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  10),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  child: TabBar(
                                    onTap: (val) {
                                      setState(() {
                                        log("mario");
                                      });
                                    },
                                    indicatorColor: AppColors.pinkColor,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    labelColor: Colors.white,
                                    controller: _tabController,
                                    tabs: const [
                                      Tab(
                                        child: Text("Redeem",
                                            style: TextStyle(fontSize: 17)),
                                      ),
                                      Tab(
                                        child: Text("Credit",
                                            style: TextStyle(fontSize: 17)),
                                      ),
                                      Tab(
                                        child: Text("Debit",
                                            style: TextStyle(fontSize: 17)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 70,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                HostRechargeScreen(
                                  redeemRequestModel:
                                      redeemRequestHistoryController
                                          .redeemRequestModel!,
                                ),
                                HostCreditScreen(
                                  hostCreditHistoryModel:
                                      hostCreditHistoryController
                                          .hostCreditHistoryModel!,
                                ),
                                HostDebitScreen(
                                  hostDebitHistoryModel:
                                      hostDebitHistoryController
                                          .hostDebitHistoryModel!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: SizeConfig.blockSizeVertical * 20.3,
                        left: SizeConfig.blockSizeHorizontal * 8,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Start Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    color: AppColors.pinkColor,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    _startDatePicket(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: SizeConfig.blockSizeVertical * 5,
                                    width: SizeConfig.blockSizeHorizontal * 38,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xff4F4F4F)
                                              .withOpacity(0.8)),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${startDate.toLocal()}"
                                              .split(' ')[0],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.7,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  2,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.white,
                                          size: SizeConfig.blockSizeVertical *
                                              2.5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 8,
                            ),
                            Column(
                              children: [
                                Text(
                                  "End Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    color: AppColors.pinkColor,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    _endDatePicket(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: SizeConfig.blockSizeVertical * 5,
                                    width: SizeConfig.blockSizeHorizontal * 38,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xff4F4F4F)
                                              .withOpacity(0.8)),
                                      color: Colors.black,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${endDate.toLocal()}"
                                                .split(' ')[0],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.7,
                                            )),
                                        SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  2,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.white,
                                          size: SizeConfig.blockSizeVertical *
                                              2.5,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            })),
      ),
    );
  }
}
