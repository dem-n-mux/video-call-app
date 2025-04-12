import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:lottie/lottie.dart';
import '../../../../Api_Service/withdraw/models/host_credit_history_model.dart';
import '../../../utils/settings/app_lottie.dart';
import '../../../utils/widgets/size_configuration.dart';

class HostCreditScreen extends StatefulWidget {
  final HostCreditHistoryModel hostCreditHistoryModel;

  const HostCreditScreen({Key? key, required this.hostCreditHistoryModel}) : super(key: key);

  @override
  State<HostCreditScreen> createState() => _HostCreditScreenState();
}

class _HostCreditScreenState extends State<HostCreditScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: (widget.hostCreditHistoryModel.history!.isNotEmpty)
            ? SingleChildScrollView(
                child: ListView.separated(
                  separatorBuilder: (context, i) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.hostCreditHistoryModel.history!.length,
                  itemBuilder: (context, i) {
                    return Container(
                      height: height / 11,
                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 15,
                        left: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff343434).withOpacity(0.5),
                      ),
                      child: ListTile(
                          leading: Container(
                              alignment: Alignment.center,
                              height: height / 7.5,
                              width: width / 7.5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff1D1C1D),
                              ),
                              child: SizedBox(
                                height: 25,
                                // color: AppColor.white,
                                child: Image.asset("assets/images/rechargeDiamond.png", fit: BoxFit.cover),
                              )),
                          title: Text(
                            widget.hostCreditHistoryModel.history![i].userName.toString(),
                            style: const TextStyle(
                              color: AppColors.pinkColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            widget.hostCreditHistoryModel.history![i].date.toString(),
                            style: TextStyle(
                              color: AppColors.lightPinkColor.withOpacity(0.46),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: Text(
                            widget.hostCreditHistoryModel.history![i].coin.toString(),
                            style: const TextStyle(
                                fontSize: 20, color: AppColors.lightPinkColor, fontWeight: FontWeight.w700),
                          )),
                    );
                  },
                ),
              )
            : Center(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeVertical * 15),
                    Lottie.asset(AppLottie.notificationLottieTwo,
                        repeat: true, reverse: false, width: SizeConfig.blockSizeHorizontal * 45),
                    Text(
                      "Not data Found!!",
                      style: TextStyle(
                          color: const Color(
                            0xffDF4D97,
                          ),
                          fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
