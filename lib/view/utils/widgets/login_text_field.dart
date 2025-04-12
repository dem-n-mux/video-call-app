import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';

class LogInTextFiled extends StatelessWidget {
  final String title;
  final String icon;
  final TextEditingController? controller;

  const LogInTextFiled({
    Key? key,
    required this.title,
    required this.icon, this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height / 14,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      padding: const EdgeInsets.only(
        left: 15,
      ),
      decoration: BoxDecoration(
          color: const Color(0xff9F7C88).withOpacity(0.75),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  icon,
                  width: 18,
                ),
                SizedBox(
                    height: height / 25,
                    width: 2,
                    child: VerticalDivider(
                      color: AppColors.lightPinkColor.withOpacity(0.4),
                      thickness: 1,
                    ),),
              ],
            ),
          ),
          const SizedBox(width: 10,),
          SizedBox(
            width: width / 1.4,
            child: TextFormField(
              controller: controller,
              cursorColor: AppColors.lightPinkColor,
              style: const TextStyle(
                  color: AppColors.lightPinkColor,
                  fontSize: 18),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title,
                hintStyle: const TextStyle(
                    fontSize: 18,
                    color: AppColors.lightPinkColor),
                contentPadding: EdgeInsets.zero
                // contentPadding: EdgeInsets.only(
                //     bottom: SizeConfig.blockSizeVertical * 1),
              ),
            ),
          )
        ],
      ),
    );
  }
}

///
// TextFormField(
// cursorColor: AppColors.pinkColor ,
// obscureText: obscureText,
// style: const TextStyle(color: Color(0xffFFE2EC)),
// onEditingComplete: onEditingComplete,
// decoration: InputDecoration(
// isDense: true,
// focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Color(0xffFFE2EC),width: 0.5)),
// enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Colors.transparent,width: 0.5)),
// border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
// prefixIcon: Container(
// margin:  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
// width: SizeConfig.blockSizeHorizontal* 2,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Image.asset(icon,height: SizeConfig.blockSizeVertical* 4,width: SizeConfig.blockSizeHorizontal* 4,),
// SizedBox(height:SizeConfig.blockSizeVertical* 4,child: const VerticalDivider(color: Colors.white,thickness: 0.5,))
// ],),
// ),
// hintStyle: TextStyle(color: Colors.white,fontSize: SizeConfig.blockSizeHorizontal*3.9),
// fillColor: const Color(0xff9F7C88).withOpacity(0.75),
// filled: true,
// hintText: title,
// suffixIcon: suffix,
// // contentPadding: EdgeInsets.zero
// ),
// )

////
