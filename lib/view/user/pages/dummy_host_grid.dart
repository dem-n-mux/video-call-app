import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';
import '../../utils/settings/app_colors.dart';
import '../../utils/settings/app_variables.dart';
import '../../utils/settings/models/dummy_host_model.dart';

class DummyHostGrid extends StatefulWidget {
  final DummyHostModel dummyHostModel;

  const DummyHostGrid({Key? key, required this.dummyHostModel})
      : super(key: key);

  @override
  State<DummyHostGrid> createState() => _DummyHostGridState();
}

class _DummyHostGridState extends State<DummyHostGrid> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          switchPage = true;
          isProfile = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(widget.dummyHostModel.personImage),
              fit: BoxFit.cover),
        ),
        foregroundDecoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.transparentColor,
                AppColors.transparentColor,
                Colors.black12,
                Colors.black26,
                Colors.black38,
                Colors.black45,
                Colors.black54,
                Colors.black87
              ]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  alignment: Alignment.center,
                  height: SizeConfig.blockSizeVertical * 3,
                  width: SizeConfig.blockSizeHorizontal * 16.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: (widget.dummyHostModel.isOnline == '')
                          ? AppColors.transparentColor
                          : Colors.black.withOpacity(0.6)),
                  child: Row(
                    children: [
                      (widget.dummyHostModel.isOnline == 'Live')
                          ? Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: SizedBox(
                          height: 10,
                          width: 13,
                          child: Lottie.asset(
                            AppLottie.liveLottie,
                            fit: BoxFit.cover,
                            repeat: true,
                            reverse: true,
                          ),
                        ),
                      )
                          : CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 1,
                        backgroundColor:
                        (widget.dummyHostModel.isOnline == "Online")
                            ? AppColors.onlineColor
                            : (widget.dummyHostModel.isOnline ==
                            "Busy")
                            ? Colors.red
                            : (widget.dummyHostModel.isOnline ==
                            "Live")
                            ? AppColors.pinkColor
                            : AppColors.transparentColor,
                      ),
                      (widget.dummyHostModel.isOnline == 'Online')
                          ? SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1.2,
                      )
                          : SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1.5,
                      ),
                      Text(
                        widget.dummyHostModel.isOnline,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.blockSizeHorizontal * 3),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.dummyHostModel.personName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "${widget.dummyHostModel.country}, ${widget.dummyHostModel.age}",
                  style: TextStyle(
                      color: const Color(0xffE5E5E5),
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
