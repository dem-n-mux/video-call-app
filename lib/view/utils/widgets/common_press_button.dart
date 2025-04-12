import 'package:flutter/material.dart';
import '../settings/app_colors.dart';


class CommonPressButton extends StatelessWidget {
  final String title;
  final double top;
  final void Function()? onTap;
  const CommonPressButton({Key? key, required this.title, required this.top, this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:top),
        height: height / 15,
        width: width / 2,
        decoration: BoxDecoration(color: AppColors.pinkColor,borderRadius: BorderRadius.circular(33)),
        child: Text(title,style:  const TextStyle(color: AppColors.lightPinkColor,fontWeight: FontWeight.w600,fontSize: 20),),
      ),
    );
  }
}
