import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';

class CustomReportView {
  static RxInt selectedReport = 0.obs;
  static List reportTypes = [
    "NULL",
    "Block Video",
    "Sexual Content",
    "Violent or Repulsive Content",
    "Hateful or Abusive Content",
    "Harmful or Dangerous Acts",
    "Spam or Misleading",
    "Child Abuse",
    "Others",
  ];
  static void show() {
    Get.bottomSheet(
      backgroundColor: AppColors.appBarColor,
      SizedBox(
        height: 460,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
                height: 3,
                width: SizeConfig.blockSizeHorizontal * 12,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: AppColors.grey)),
            const SizedBox(height: 10),
            Text("Report", style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.w900)),
            const Divider(indent: 25, endIndent: 25, color: AppColors.grey),
            Obx(
              () => Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 1; i < reportTypes.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 0),
                          child: Row(
                            children: [
                              Radio(
                                  value: i,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  activeColor: AppColors.pinkColor,
                                  groupValue: selectedReport.value,
                                  onChanged: (value) => selectedReport.value = value!),
                              Text(
                                reportTypes[i],
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.grey.withOpacity(0.4)),
                              ),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.urbanist(
                                  color: AppColors.whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {
                              if (selectedReport.value != 0) {
                                Get.back();
                                Fluttertoast.showToast(
                                    msg:
                                        "Host blocked request successfully, please wait we will take action shortly");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.pinkColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Report",
                                style: GoogleFonts.urbanist(
                                  color: AppColors.whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
    );
  }
}
