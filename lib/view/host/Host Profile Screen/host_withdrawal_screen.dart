import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/controller/setting_controller.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/controller/create_redeem_controller.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/controller/withdraw_type_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';

class HostWithdrawScreen extends StatefulWidget {
  const HostWithdrawScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HostWithdrawScreen> createState() => _HostWithdrawScreenState();
}

class _HostWithdrawScreenState extends State<HostWithdrawScreen> {
  SettingController settingController = Get.put(SettingController());

  CreateRedeemController createRedeemController =
      Get.put(CreateRedeemController());

  WithdrawTypeController withdrawTypeController =
      Get.put(WithdrawTypeController());

  String selectedWithdrawMethod = "Paytm";
  String selectedWithdrawValue = "Paytm";

  int withdrawSelectedIndex = 0;

  bool isVisible = true;
  bool isActive = false;

  final TextEditingController withdrawController = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController bankNumber = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController coinController =
      TextEditingController(text: hostCoin.value);

  String autoCalculatedText =
      "${int.parse(hostCoin.value) / num.parse(coinPerDollarIs)}";

  void calculateText(String input) {
    setState(() {
      autoCalculatedText = "${int.parse(input) / num.parse(coinPerDollarIs)}";
    });
  }

  @override
  void initState() {
    getAllApi();
    super.initState();
  }

  getAllApi() async {
    await settingController.setting();
    await withdrawTypeController.withdrawType();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            highlightColor: AppColors.transparentColor,
            splashColor: AppColors.transparentColor,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.pinkColor,
              size: 22,
            ),
          ),
          backgroundColor: AppColors.appBarColor,
          centerTitle: true,
          title: const Text(
            "Withdraw",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.pinkColor,
              fontSize: 22,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(bottom: 15, top: 20),
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.appBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              AppImages.withdrawCoin,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 13,
                      ),
                      Obx(
                        () => Text(
                          hostCoin.value,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: AppColors.lightPinkColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Note :- ",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.pinkColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "Minimum 10\$ Withdraw",
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.lightPinkColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    height: 55,
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(0xff313131),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          child: TextField(
                            maxLength: 6,
                            onChanged: (value) {
                              setState(() {
                                calculateText(value);
                              });
                            },
                            controller: coinController,
                            cursorColor: Colors.white,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            decoration: const InputDecoration(
                                border: InputBorder.none, counterText: ""),
                          ),
                        ),
                        const Text(
                          "=",
                          style: TextStyle(
                            color: AppColors.pinkColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Text(
                          "\$ $autoCalculatedText",
                          style: const TextStyle(
                              color: AppColors.lightPinkColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text(
                    "Coin to Withdraw",
                    style: TextStyle(
                      color: AppColors.lightPinkColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 465,
                      width: 375,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xff313131),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Payment details",
                              style: TextStyle(
                                color: AppColors.lightPinkColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: StatefulBuilder(
                                            builder: (context, setState1) =>
                                                Container(
                                              height: 350,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: AppColors.blackColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15,
                                                        horizontal: 15),
                                                    alignment: Alignment.center,
                                                    width: Get.width,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        18),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        18))),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Spacer(),
                                                          const Text(
                                                            "Select Withdraw Method",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .lightPinkColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                          const Spacer(),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 3),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          )
                                                        ]),
                                                  ),

                                                  // Container(
                                                  //   padding: const EdgeInsets
                                                  //           .symmetric(
                                                  //       horizontal: 15,
                                                  //       vertical: 25),
                                                  //   height: 315,
                                                  //   width: Get.width,
                                                  //   decoration: const BoxDecoration(
                                                  //       borderRadius:
                                                  //           BorderRadius.only(
                                                  //               bottomRight:
                                                  //                   Radius
                                                  //                       .circular(
                                                  //                           18),
                                                  //               bottomLeft: Radius
                                                  //                   .circular(
                                                  //                       18))),
                                                  //   child: Column(
                                                  //     children: [
                                                  //       Row(
                                                  //         mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .spaceBetween,
                                                  //         children: [
                                                  //           Row(
                                                  //             children: [
                                                  //               Container(
                                                  //                 height: 50,
                                                  //                 width: 50,
                                                  //                 decoration:
                                                  //                     const BoxDecoration(
                                                  //                   shape: BoxShape
                                                  //                       .circle,
                                                  //                 ),
                                                  //                 child: Image.network(
                                                  //                     "https://cdn.icon-icons.com/icons2/730/PNG/512/paytm_icon-icons.com_62778.png",
                                                  //                     fit: BoxFit
                                                  //                         .contain),
                                                  //               ),
                                                  //               const SizedBox(
                                                  //                   width: 20),
                                                  //               Column(
                                                  //                 mainAxisAlignment:
                                                  //                     MainAxisAlignment
                                                  //                         .start,
                                                  //                 crossAxisAlignment:
                                                  //                     CrossAxisAlignment
                                                  //                         .start,
                                                  //                 children: const [
                                                  //                   Text(
                                                  //                       "Paytm",
                                                  //                       style: TextStyle(
                                                  //                           color:
                                                  //                               AppColors.withdrawColor,
                                                  //                           fontWeight: FontWeight.w600,
                                                  //                           fontSize: 18)),
                                                  //                 ],
                                                  //               )
                                                  //             ],
                                                  //           ),
                                                  //           Transform.scale(
                                                  //             scale: 1.2,
                                                  //             child: Radio(
                                                  //                 activeColor:
                                                  //                     AppColors
                                                  //                         .pinkColor,
                                                  //                 overlayColor:
                                                  //                     MaterialStateProperty
                                                  //                         .all(Colors
                                                  //                             .transparent),
                                                  //                 value:
                                                  //                     "Paytm",
                                                  //                 groupValue:
                                                  //                     selectedWithdrawValue,
                                                  //                 onChanged:
                                                  //                     (value) {
                                                  //                   setState(
                                                  //                       () {
                                                  //                     setState1(
                                                  //                         () {
                                                  //                       selectedWithdrawValue =
                                                  //                           value!;
                                                  //                       selectedWithdrawMethod =
                                                  //                           selectedWithdrawValue;
                                                  //                     });
                                                  //                   });
                                                  //                 }),
                                                  //           )
                                                  //         ],
                                                  //       ),
                                                  //       const SizedBox(
                                                  //           height: 20),
                                                  //       Row(
                                                  //         mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .spaceBetween,
                                                  //         children: [
                                                  //           Row(
                                                  //             children: [
                                                  //               Container(
                                                  //                 height: 50,
                                                  //                 width: 50,
                                                  //                 decoration:
                                                  //                     const BoxDecoration(
                                                  //                   shape: BoxShape
                                                  //                       .circle,
                                                  //                 ),
                                                  //                 child: Image.network(
                                                  //                     "https://cdn-icons-png.flaticon.com/512/1377/1377239.png",
                                                  //                     fit: BoxFit
                                                  //                         .contain),
                                                  //               ),
                                                  //               const SizedBox(
                                                  //                   width: 20),
                                                  //               Column(
                                                  //                 mainAxisAlignment:
                                                  //                     MainAxisAlignment
                                                  //                         .start,
                                                  //                 crossAxisAlignment:
                                                  //                     CrossAxisAlignment
                                                  //                         .start,
                                                  //                 children: const [
                                                  //                   Text(
                                                  //                       "Paypal",
                                                  //                       style: TextStyle(
                                                  //                           color:
                                                  //                               AppColors.withdrawColor,
                                                  //                           fontWeight: FontWeight.w600,
                                                  //                           fontSize: 18)),
                                                  //                 ],
                                                  //               )
                                                  //             ],
                                                  //           ),
                                                  //           Transform.scale(
                                                  //             scale: 1.2,
                                                  //             child: Radio(
                                                  //                 overlayColor:
                                                  //                     MaterialStateProperty
                                                  //                         .all(Colors
                                                  //                             .transparent),
                                                  //                 activeColor:
                                                  //                     AppColors
                                                  //                         .pinkColor,
                                                  //                 value:
                                                  //                     "Paypal",
                                                  //                 groupValue:
                                                  //                     selectedWithdrawValue,
                                                  //                 onChanged:
                                                  //                     (value) {
                                                  //                   setState(
                                                  //                       () {
                                                  //                     setState1(
                                                  //                         () {
                                                  //                       selectedWithdrawValue =
                                                  //                           value!;
                                                  //                       selectedWithdrawMethod =
                                                  //                           selectedWithdrawValue;
                                                  //                     });
                                                  //                   });
                                                  //                 }),
                                                  //           )
                                                  //         ],
                                                  //       ),
                                                  //       const SizedBox(
                                                  //           height: 20),
                                                  //       Row(
                                                  //         mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .spaceBetween,
                                                  //         children: [
                                                  //           Padding(
                                                  //             padding:
                                                  //                 const EdgeInsets
                                                  //                         .only(
                                                  //                     left: 5),
                                                  //             child: Row(
                                                  //               children: [
                                                  //                 Container(
                                                  //                   height: 50,
                                                  //                   width: 50,
                                                  //                   decoration:
                                                  //                       const BoxDecoration(
                                                  //                     shape: BoxShape
                                                  //                         .circle,
                                                  //                   ),
                                                  //                   child: Image.asset(
                                                  //                       AppIcons
                                                  //                           .bankIcon,
                                                  //                       fit: BoxFit
                                                  //                           .contain),
                                                  //                 ),
                                                  //                 const SizedBox(
                                                  //                     width:
                                                  //                         20),
                                                  //                 Column(
                                                  //                   mainAxisAlignment:
                                                  //                       MainAxisAlignment
                                                  //                           .start,
                                                  //                   crossAxisAlignment:
                                                  //                       CrossAxisAlignment
                                                  //                           .start,
                                                  //                   children: const [
                                                  //                     Text(
                                                  //                         "Bank Transfer",
                                                  //                         style: TextStyle(
                                                  //                             color: AppColors.withdrawColor,
                                                  //                             fontWeight: FontWeight.w600,
                                                  //                             fontSize: 18)),
                                                  //                   ],
                                                  //                 )
                                                  //               ],
                                                  //             ),
                                                  //           ),
                                                  //           Transform.scale(
                                                  //             scale: 1.2,
                                                  //             child: Radio(
                                                  //                 overlayColor:
                                                  //                     MaterialStateProperty
                                                  //                         .all(Colors
                                                  //                             .transparent),
                                                  //                 activeColor:
                                                  //                     AppColors
                                                  //                         .pinkColor,
                                                  //                 value:
                                                  //                     "Enter Bank Details",
                                                  //                 groupValue:
                                                  //                     selectedWithdrawValue,
                                                  //                 onChanged:
                                                  //                     (value) {
                                                  //                   setState(
                                                  //                       () {
                                                  //                     setState1(
                                                  //                         () {
                                                  //                       selectedWithdrawValue =
                                                  //                           value!;
                                                  //                       selectedWithdrawMethod =
                                                  //                           selectedWithdrawValue;
                                                  //                     });
                                                  //                   });
                                                  //                 }),
                                                  //           )
                                                  //         ],
                                                  //       ),
                                                  //       const SizedBox(
                                                  //           height: 25),
                                                  //       InkWell(
                                                  //         onTap: () {
                                                  //           setState(() {
                                                  //             isActive = true;
                                                  //             isVisible = false;
                                                  //           });
                                                  //           Get.back();
                                                  //         },
                                                  //         child: Container(
                                                  //           alignment: Alignment
                                                  //               .center,
                                                  //           padding:
                                                  //               const EdgeInsets
                                                  //                   .symmetric(
                                                  //             horizontal: 10,
                                                  //             vertical: 5,
                                                  //           ),
                                                  //           height: 42,
                                                  //           width: 97,
                                                  //           decoration: BoxDecoration(
                                                  //               borderRadius:
                                                  //                   BorderRadius
                                                  //                       .circular(
                                                  //                           10),
                                                  //               color: AppColors
                                                  //                   .pinkColor),
                                                  //           child: const Text(
                                                  //             "Done",
                                                  //             style: TextStyle(
                                                  //                 color: Colors
                                                  //                     .white,
                                                  //                 fontSize: 17,
                                                  //                 fontWeight:
                                                  //                     FontWeight
                                                  //                         .bold),
                                                  //           ),
                                                  //         ),
                                                  //       )
                                                  //     ],
                                                  //   ),
                                                  // )

                                                  Flexible(
                                                    child: ListView.builder(
                                                      itemCount:
                                                          withdrawTypeController
                                                              .getWithdrawTypeModel!
                                                              .withdraw!
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                withdrawSelectedIndex =
                                                                    index;

                                                                selectedWithdrawMethod = withdrawTypeController
                                                                    .getWithdrawTypeModel!
                                                                    .withdraw![
                                                                        index]
                                                                    .name
                                                                    .toString();
                                                              });

                                                              // log(selectedWithdrawMethod);
                                                              // log(withdrawSelectedIndex.toString());
                                                              Get.back();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      right: 12,
                                                                      left: 12),
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                height: 70,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .appBarColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: ListTile(
                                                                  leading:
                                                                      Container(
                                                                    height: 50,
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image: NetworkImage("${Constant.BASE_URL}${withdrawTypeController.getWithdrawTypeModel!.withdraw![index].image.toString()}"))),
                                                                  ),
                                                                  title: Text(
                                                                      withdrawTypeController
                                                                          .getWithdrawTypeModel!
                                                                          .withdraw![
                                                                              index]
                                                                          .name
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: AppColors
                                                                              .lightPinkColor,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                ),
                                                              ),
                                                            ));
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 55,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.appBarColor,
                                    ),
                                    child: ListTile(
                                      title: Text(selectedWithdrawMethod,
                                          style: const TextStyle(
                                              color: AppColors.lightPinkColor,
                                              fontSize: 18)),
                                      trailing: const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: AppColors.whiteColor,
                                          size: 30),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "* if below all information is correct then your withdraw request is accept *",
                              style: TextStyle(
                                color: AppColors.pinkColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: withdrawTypeController
                                  .getWithdrawTypeModel!
                                  .withdraw![withdrawSelectedIndex]
                                  .details!
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  "• ${withdrawTypeController.getWithdrawTypeModel!.withdraw![withdrawSelectedIndex].details![index].toString()}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColors.lightPinkColor),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Spacer(),
                            Padding(
                                padding: const EdgeInsets.only(
                                  right: 15,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Description",
                                        style: TextStyle(
                                          color: AppColors.lightPinkColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: AppColors.appBarColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        onEditingComplete: () =>
                                            FocusScope.of(context).nextFocus(),
                                        cursorColor: AppColors.lightPinkColor,
                                        controller: withdrawController,
                                        style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          color: AppColors.lightPinkColor,
                                          fontSize: 18,
                                        ),
                                        maxLines: 5,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          border: InputBorder.none,
                                          hintText: "Enter your details",
                                          hintStyle: TextStyle(
                                            color: AppColors.lightPinkColor,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (withdrawController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Please Enter your withdraw details...",
                          backgroundColor: AppColors.blackColor,
                          fontSize: 15,
                          textColor: Colors.white,
                          timeInSecForIosWeb: 4,
                        );
                      } else if (int.parse(hostCoin.value) <=
                          settingController.getSetting!.setting!.withdrawLimit!
                              .toInt()) {
                        Fluttertoast.showToast(
                          msg: "No Enough coin to withdraw",
                          backgroundColor: AppColors.blackColor,
                          fontSize: 15,
                          textColor: Colors.white,
                          timeInSecForIosWeb: 4,
                        );
                      } else if (int.parse(coinController.text) >
                          int.parse(hostCoin.value)) {
                        Fluttertoast.showToast(
                          msg: "Withdraw coin are more then total coin",
                          backgroundColor: AppColors.blackColor,
                          fontSize: 15,
                          textColor: Colors.white,
                          timeInSecForIosWeb: 4,
                        );
                      } else if (int.parse(coinController.text) == 0) {
                        Fluttertoast.showToast(
                          msg: "Please Enter some coin",
                          backgroundColor: AppColors.blackColor,
                          fontSize: 15,
                          textColor: Colors.white,
                          timeInSecForIosWeb: 4,
                        );
                      } else {
                        showModalBottomSheet(
                            backgroundColor: AppColors.transparentColor,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 250,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  color: AppColors.appBarColor,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    const Text(
                                      "Withdraw",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        color: AppColors.pinkColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "Are you sure your want to",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: AppColors.lightPinkColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Withdraw $autoCalculatedText\$ Amount ?",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: AppColors.lightPinkColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xff3D3D3D),
                                            ),
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Get.back();
                                          },
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.pinkColor,
                                            ),
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            await Fluttertoast.showToast(
                                              msg: "Redirecting...",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black
                                                  .withOpacity(0.35),
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                            await createRedeemController
                                                .createRedeem(
                                                    int.parse(
                                                        coinController.text),
                                                    selectedWithdrawMethod,
                                                    withdrawController.text);
                                            // Fluttertoast.showToast(
                                            //   msg: createRedeemController
                                            //       .createRedeemModel!
                                            //       .message!,
                                            //   toastLength:
                                            //       Toast.LENGTH_SHORT,
                                            //   gravity:
                                            //       ToastGravity.CENTER,
                                            //   timeInSecForIosWeb: 1,
                                            //   backgroundColor: Colors
                                            //       .black
                                            //       .withOpacity(0.35),
                                            //   textColor: Colors.white,
                                            //   fontSize: 16.0,
                                            // );

                                            withdrawController.clear();
                                            selectedIndex = 2;
                                            Get.offAll(
                                                const HostBottomNavigationBarScreen());
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      }

                      //   (withdrawController.text.isNotEmpty)
                      //       ? (int.parse(hostCoin.value) <=
                      //               settingController
                      //                   .getSetting!.setting!.withdrawLimit!
                      //                   .toInt())
                      //           ? Fluttertoast.showToast(
                      //               msg: "No Enough coin to withdraw",
                      //               backgroundColor: AppColors.blackColor,
                      //               fontSize: 15,
                      //               textColor: Colors.white,
                      //               timeInSecForIosWeb: 4,
                      //             )
                      //           : showModalBottomSheet(
                      //               backgroundColor: AppColors.transparentColor,
                      //               context: context,
                      //               builder: (context) {
                      //                 return Container(
                      //                   height: 250,
                      //                   decoration: const BoxDecoration(
                      //                     borderRadius: BorderRadius.only(
                      //                       topLeft: Radius.circular(15),
                      //                       topRight: Radius.circular(15),
                      //                     ),
                      //                     color: AppColors.appBarColor,
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       const SizedBox(
                      //                         height: 25,
                      //                       ),
                      //                       const Text(
                      //                         "Withdraw",
                      //                         style: TextStyle(
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: 22,
                      //                           color: AppColors.pinkColor,
                      //                         ),
                      //                       ),
                      //                       const SizedBox(
                      //                         height: 15,
                      //                       ),
                      //                       const Text(
                      //                         "Are you sure your want to",
                      //                         style: TextStyle(
                      //                           fontWeight: FontWeight.w400,
                      //                           fontSize: 20,
                      //                           color: AppColors.lightPinkColor,
                      //                         ),
                      //                       ),
                      //                       const SizedBox(
                      //                         height: 5,
                      //                       ),
                      //                       Text(
                      //                         "Withdraw $autoCalculatedText\$ Amount ?",
                      //                         style: const TextStyle(
                      //                           fontWeight: FontWeight.w400,
                      //                           fontSize: 20,
                      //                           color: AppColors.lightPinkColor,
                      //                         ),
                      //                       ),
                      //                       const SizedBox(
                      //                         height: 50,
                      //                       ),
                      //                       Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.spaceEvenly,
                      //                         children: [
                      //                           GestureDetector(
                      //                             child: Container(
                      //                               alignment: Alignment.center,
                      //                               height: 50,
                      //                               width: 120,
                      //                               decoration: BoxDecoration(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         10),
                      //                                 color:
                      //                                     const Color(0xff3D3D3D),
                      //                               ),
                      //                               child: const Text(
                      //                                 "Cancel",
                      //                                 style: TextStyle(
                      //                                   color: Colors.white,
                      //                                   fontSize: 22,
                      //                                   fontWeight:
                      //                                       FontWeight.w700,
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                             onTap: () {
                      //                               Get.back();
                      //                             },
                      //                           ),
                      //                           GestureDetector(
                      //                             child: Container(
                      //                               alignment: Alignment.center,
                      //                               height: 50,
                      //                               width: 120,
                      //                               decoration: BoxDecoration(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         10),
                      //                                 color: AppColors.pinkColor,
                      //                               ),
                      //                               child: const Text(
                      //                                 "Yes",
                      //                                 style: TextStyle(
                      //                                   color: Colors.white,
                      //                                   fontSize: 22,
                      //                                   fontWeight:
                      //                                       FontWeight.w500,
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                             onTap: () async {
                      //                               await Fluttertoast.showToast(
                      //                                 msg: "Redirecting...",
                      //                                 toastLength:
                      //                                     Toast.LENGTH_SHORT,
                      //                                 gravity:
                      //                                     ToastGravity.CENTER,
                      //                                 timeInSecForIosWeb: 1,
                      //                                 backgroundColor: Colors
                      //                                     .black
                      //                                     .withOpacity(0.35),
                      //                                 textColor: Colors.white,
                      //                                 fontSize: 16.0,
                      //                               );
                      //                               await createRedeemController
                      //                                   .createRedeem(
                      //                                       int.parse(
                      //                                           coinController
                      //                                               .text),
                      //                                       selectedWithdrawMethod,
                      //                                       withdrawController
                      //                                           .text);
                      //                               // Fluttertoast.showToast(
                      //                               //   msg: createRedeemController
                      //                               //       .createRedeemModel!
                      //                               //       .message!,
                      //                               //   toastLength:
                      //                               //       Toast.LENGTH_SHORT,
                      //                               //   gravity:
                      //                               //       ToastGravity.CENTER,
                      //                               //   timeInSecForIosWeb: 1,
                      //                               //   backgroundColor: Colors
                      //                               //       .black
                      //                               //       .withOpacity(0.35),
                      //                               //   textColor: Colors.white,
                      //                               //   fontSize: 16.0,
                      //                               // );
                      //
                      //                               withdrawController.clear();
                      //                               selectedIndex = 2;
                      //                               Get.offAll(
                      //                                   const HostBottomNavigationBarScreen());
                      //                             },
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 );
                      //               })
                      //       : Fluttertoast.showToast(
                      //           msg: "Please Enter your withdraw details...",
                      //           backgroundColor: AppColors.blackColor,
                      //           fontSize: 15,
                      //           textColor: Colors.white,
                      //           timeInSecForIosWeb: 4,
                      //         );
                      //
                      //   log(
                      //       "Withdraw amount limit is :- ${settingController.getSetting!.setting!.withdrawLimit!.toInt()}");
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  AppImages.profileWalletBox,
                                ),
                              ),
                            ),
                            height: 60,
                          ),
                        ),
                        ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: SizedBox(
                                height: 25,
                                width: 25,
                                child: Image.asset(AppImages.withDraw)),
                          ),
                          title: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Withdraw",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.lightPinkColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
