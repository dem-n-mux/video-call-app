import 'package:flutter/material.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';


class CommonStreamButton extends StatelessWidget {
  final String image;
  final void Function() onTap;
  const CommonStreamButton({Key? key,required this.image, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.pinkColor,AppColors.pinkColor,Color(0xff5E6066)]),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.5),
          child: Container(
            alignment: Alignment.center,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff5C6064).withOpacity(0.70),
            ),
            child: Image.asset(image,fit: BoxFit.cover,height: 20,width:20,),
          ),
        ),
      ),
    );
  }
}
